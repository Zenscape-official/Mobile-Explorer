import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/Controller/productController.dart';
import 'package:zenscape_app/Screens/network/proposalDetails.dart';
import 'package:zenscape_app/backend%20files/ProposalsModel.dart';
import 'package:zenscape_app/backend%20files/networkList.dart';
import 'package:zenscape_app/widgets/filterTab.dart';
import '../../Controller/dropDownController.dart';
import '../../controller/proposalsFunc.dart';
import '../../widgets/navigationDrawerWidget.dart';

class Proposals extends StatefulWidget {
final NetworkList? networkListProposal;
 const Proposals({Key? key, this.networkListProposal}) : super(key: key);
  @override
  State<Proposals> createState() => _ProposalsState();
}

class _ProposalsState extends State<Proposals> {
  final ProductController productController= Get.put(ProductController());
  final ProposalController _proposalController= Get.put(ProposalController());
  bool isLoaded=false;
  var prop;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    Get.delete<ProposalController>();
    super.dispose();
  }

  getData() async{
     prop= await _proposalController.fetchProducts(widget.networkListProposal!.proposalsUrl!);
    setState(() {
      if (prop!=null){
        isLoaded=true;
      }
      else{
        isLoaded=false;
      }
    });
  }

  BookController bookController = BookController();
  TextEditingController nameController=TextEditingController();
  String fullName = '';

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      drawer: NavDraw(networkData: widget.networkListProposal),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Text('Proposals',style:kBigBoldTextStyle),
          CircleAvatar(
              radius:15,
              child: Image.network(widget.networkListProposal!.logoUrl??widget.networkListProposal!.logUrl!),
              backgroundColor: Colors.transparent),
        ],
      ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width/1.1,
              height: 40,
              decoration: kBoxDecorationWithoutGradient,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.transparent,
                    focusedBorder: InputBorder.none,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    hintText: 'Select a chain',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (text) {
                    setState(() {
                      fullName = text;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            const [
              Filter(),
            ],
          ),
         isLoaded?SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height/1.4,
              child:Obx(()=> CupertinoScrollbar(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ProposalController.proposalList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        ProposalCard(ProposalController.proposalList[index]);
                    })
              ),
            ),
          ),
          ):const CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class ProposalCard extends StatelessWidget {
  final ProposalsModel product;
  ProposalCard(this.product, {Key? key}) : super(key: key);
  var status='';
  bool ispassed=true;
  void fun(){
    if(product.status=='PROPOSAL_STATUS_PASSED'){
      status='Passed';
    }
    else{
      status='Rejected';
      ispassed=false;
    }
  }
  @override
  Widget build(BuildContext context) {
    fun();
    return InkWell(
      onTap: ()=> Get.to(() => ProposalDetails(proposalProduct: product)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

   decoration: kBoxDecorationWithGradient,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration:const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(200.0),),
                            color: Color(0xFFD4F1FF)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('#${product.id!}',
                            style:kSmallTextStyle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 150,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(product.content!.title!,
                                style: const TextStyle(
                                    color: Colors.blue
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:ispassed? Colors.lightGreenAccent.withOpacity(.1):Colors.red.shade50,
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(
                          color: ispassed? const Color(0xFF6BD68D):Colors.red.withOpacity(.5),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            CircleAvatar(backgroundColor: ispassed? Colors.green:Colors.red,
                              radius: 3,),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(status,
                                style: kSmallTextStyle,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ],
                ),
              ),
              const Divider(color: Colors.grey,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                     Text('Voting Starts',
                      style: kSmallTextStyle,),
                    Text(product.votingStartTime!.toString(),
                    style: kSmallTextStyle,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Voting Ends',style: kSmallTextStyle,),
                    Text(product.votingEndTime!.toString(),
                      style:kSmallTextStyle,),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
