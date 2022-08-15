import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/Controller/product_controller.dart';
import '../../backend files/akashproposals.dart';
import '../../widgets/NavigationDrawerWidget.dart';

class Proposals extends StatelessWidget {
 //final Proposal product=Proposal();
  final ProductController productController= Get.put(ProductController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title:Row(
        children: const [
          Text('PROPOSAL',style:kBigTextStyle),
        ],
      ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,),
      body: isDataLoading?
      const Center(child: CircularProgressIndicator(),):
      Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height/1.2,
              child:Obx(()=> ListView.builder(
                reverse: true,
                physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: ProductController.productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      ProposalCard(ProductController.productList[index]);
                  }),
            ),
          ),
          )],
      )
      ,
    );
  }
}

class ProposalCard extends StatelessWidget {

  final Proposal product;
   ProposalCard(this.product, {Key? key}) : super(key: key);
  var status='';
  bool ispassed=true;
  void fun(){
    if(product.status.toString()=='Status.PROPOSAL_STATUS_PASSED'){
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
    return Padding(
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
                          child: Text('#${product.proposalId!}',
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
                  const Text('voting starts',
                    style: kSmallTextStyle,),
                  Text(product.votingStartTime.toString(),
                  style: kSmallTextStyle,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('voting ends',style: kSmallTextStyle,),
                  Text(product.votingEndTime.toString(),
                    style:kSmallTextStyle,),
                ],
              ),
            ),
          ],
        ), //Column
      ), //SizedBox
                      ),
    );
  }
}
