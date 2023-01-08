import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/screens/network/proposalDetails.dart';
import '../../backend_files/proposalsModel.dart';
import '../../controller/networklistController.dart';
import '../../controller/proposalsFunc.dart';
import '../../widgets/navigationDrawerWidget.dart';

class Proposals extends StatefulWidget {
final NetworkList? networkListProposal;
 const Proposals({Key? key, this.networkListProposal}) : super(key: key);
  @override
  State<Proposals> createState() => _ProposalsState();
}

class _ProposalsState extends State<Proposals> {
  final ProposalController productController= Get.put(ProposalController());
  final NetworkController networkController = Get.put(NetworkController());
  bool isLoaded=false;
  var prop;
  List<ProposalsModel> proposals=[];

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
    final result= await networkController.fetchList(widget.networkListProposal!.proposalsUrl!);
   proposals= await productController.fetchProducts(widget.networkListProposal!.proposalsUrl!);
    if (result['success'] == false) {
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(prop['response']),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          );
        },
      );
    }
    if(result['success'] == true) {
      prop = List.from(result['response'])
          .map((e) => ProposalsModel.fromJson(e))
          .toList()
          .reversed
          .toList()
          .obs;
    }
    setState(() {
      if (proposals.isNotEmpty){
        isLoaded=true;
      }
      else{
        isLoaded=false;
      }
    });
  }

  TextEditingController nameController=TextEditingController();
  String fullName = '';

  @override
  Widget build(BuildContext context) {
    proposals.sort((b, a) => b.id!.compareTo(a.id!));
     return Scaffold(
      drawer: NavDraw(networkData: widget.networkListProposal),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Text('Proposals',style:kBigBoldTextStyle),
          CircleAvatar(
              radius:15,
              child: InkWell(
                 // onTap: ()=> Navigator.of(context).popUntil((route) => route.isFirst),
                  child: Image.network(widget.networkListProposal!.logoUrl??widget.networkListProposal!.logUrl!)),
              backgroundColor: Colors.transparent),
        ],
      ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

           isLoaded?
           Obx(()=> CupertinoScrollbar(
             child: ListView.builder(
               physics: const NeverScrollableScrollPhysics(),
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                 itemCount: proposals.length,
                 itemBuilder: (BuildContext context, int index) {

                   return
                     ProposalCard(proposals.reversed.toList()[index]);
                 })
           ),
           ):Center(child: const CircularProgressIndicator()),
          ],
        ),
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
    else if(product.status=='PROPOSAL_STATUS_REJECTED'){
      status='Rejected';
      ispassed=false;
    }
    else if(product.status=='PROPOSAL_STATUS_VOTING_PERIOD'){
      status='Voting';
      ispassed=false;
    }
    else if(product.status=='PROPOSAL_STATUS_INVALID'){
      status='Invalid';
      ispassed=false;
    }
  }
  @override
  Widget build(BuildContext context) {

    fun();
    return InkWell(
      onTap:()=> Navigator.push(context, CupertinoPageRoute(builder: (context) => ProposalDetails(proposalProduct:product,))),
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
                    Text(
                        '${dateTime(product.votingStartTime!).toString()} ${product.votingStartTime!.timeZoneName}',
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
                    Text('${dateTime(product.votingEndTime!).toString()} ${(product.votingEndTime!.timeZoneName).toString()}',
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
