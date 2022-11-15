import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Screens/network/transactionDetails.dart';
import 'package:zenscape_app/backend_files/txDetailRaw.dart';
import '../../Constants/constants.dart';
import '../../widgets/navigationDrawerWidget.dart';
import '../../widgets/onboardingwidgets/toggleButton.dart';
class Txs extends StatefulWidget {
  final RawLogModel? rawLogModel;
   Txs({Key? key,this.rawLogModel}) : super(key: key);
  @override
  State<Txs> createState() => _TxsState();
}

class _TxsState extends State<Txs> {
  TextEditingController nameController=TextEditingController();
  String txHash='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDraw(),
      appBar: AppBar(
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Text('TRANSACTIONS',
                style:kBigBoldTextStyle),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ToggleButton(leftTitle: 'Blocks',rightTitle: 'Transactions',alignment: 0,)
                ],),
            ),
            Container(
                width: MediaQuery.of(context).size.width/1.1,
                height: 40,
                decoration: kBoxDecorationWithGradient,
                margin: const EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    filled: true,
                    fillColor: Colors.transparent,
                    focusedBorder: InputBorder.none,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    hintText: 'Select a chain',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (text) {
                    setState(() {
                      txHash = text;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                )),
            ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return
                    InkWell(
                      onTap:()=> Get.to(() => TxDetails()),
                      child: Container(
                        decoration: kBoxDecorationWithGradient,
                        margin: const EdgeInsets.all(14),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              children:[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        Text('123456',
                                            style:kMediumBoldTextStyle),
                                        Container(
                                          decoration: BoxDecoration (
                                            border: Border.all(
                                              color: Colors.lightBlueAccent.withOpacity(.4),
                                              width: 1.0,
                                            ),
                                            color: const Color(0xFF8CDAFF).withOpacity(.1),
                                            borderRadius: const BorderRadius.all(Radius.circular(15.0),

                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(.05),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: const Offset(-2, -2), // changes position of shadow
                                              ),],),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                                            child: Text('10s ago',
                                                style:TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black.withOpacity(.5),
                                                )),
                                          ),
                                        )
                                      ]
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        Text('Block Hash',
                                            style:kSmallTextStyle),
                                        Text('cban123..ybg',
                                            style:kSmallBoldTextStyle)
                                      ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Proposer',
                                            style:kSmallTextStyle),
                                        Text('AUDIT.one',
                                            style:kSmallBoldTextStyle)
                                      ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        Text('Transaction',
                                            style:kSmallTextStyle),
                                        Text('0',
                                            style:kSmallBoldTextStyle)
                                      ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8,4.0,8,12),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Time',
                                            style:kSmallTextStyle),
                                        Text('2022-4-12 19:55:26',
                                            style:kSmallBoldTextStyle)
                                      ]
                                  ),
                                ),

                              ]
                          ),
                        ),
                      ),
                    );
                }),
          ],
        ),
      ),
    );
  }
}
