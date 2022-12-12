import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/txModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/toggleController.dart';
import 'package:http/http.dart' as http;
import '../../controller/txToggleController.dart';

class BlockDetails extends StatefulWidget {

  BlockDetails({Key? key}) : super(key: key);
  @override
  State<BlockDetails> createState() => _BlockDetailsState();
}
class _BlockDetailsState extends State<BlockDetails> {

  @override
  void initState() {
    super.initState();

    //getData();
  }
  @override
  Widget build(BuildContext context) {

    //toggleController.updateData(0);
    return
      Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Block Details',
                style: kBigBoldTextStyle,
              ),
            ],
          ),
        ),
        body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GetBuilder<TxToggleController>(

                        builder: (txToggleController) {
                          return ToggleSwitch(
                            borderWidth: 1,
                            minHeight: 30,
                            borderColor: [Colors.grey.shade400],
                            minWidth: 110.0,
                            cornerRadius: 20.0,
                            activeBgColors: [
                              [const Color(0xFF12BFFF).withOpacity(.1)],
                              [const Color(0xFF12BFFF).withOpacity(.1)]
                            ],
                            activeFgColor: Colors.lightBlueAccent,
                            inactiveBgColor: Colors.white,
                            inactiveFgColor: Colors.grey,
                            initialLabelIndex: txToggleController.isBlockSelected == 0 ?0:1,
                            totalSwitches: 2,
                            labels: const ['Summary', 'JSON'],
                            radiusStyle: true,
                            onToggle: (index) {
                             // summarySelected = index!;
                             // txToggleController.updateData(index);
                            },
                          );
                        }
                    )
                  ],),
              ),
              GetBuilder<TxToggleController>(builder:(txToggleController) {
                return txToggleController.isBlockSelected == 0
                    ? Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: kBoxDecorationWithGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Information', style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Chain Id', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text('comdex-1', style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text('TxHash', style: kSmallTextStyle),
                                  InkWell(
                                    onTap:()=> Clipboard.setData ( ClipboardData(text: '')).then((_){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(content: Text('Transaction Hash Copied to your clipboard !')));
                                    }),
                                    child: Row(
                                      children: [
                                        const SizedBox(width:4),
                                        const Icon(Icons.copy,
                                          color: Colors.black54,
                                          size: 15,

                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                  'hash',
                                  textAlign: TextAlign.start
                                  ,style:kMediumBoldTextStyle),

                              const SizedBox(
                                height: 20,
                              ),
                              Text('Status', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                  'Fail',
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Height', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                  '',
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Time', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),

                              Text('', style: kMediumBoldTextStyle),
                              SizedBox(
                                  height:10,width:15,
                                  child: LinearProgressIndicator()),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Fee', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),

                              const SizedBox(height: 20),
                              Text('Gas (used/wanted)', style: kSmallTextStyle),
                              const SizedBox(
                                height: 3,
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              Text('Memo', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text('',
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                            ]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10,top: 10,left: 10),

                      width: MediaQuery.of(context).size.width/1.1,
                      decoration: kBoxDecorationWithGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>[


                              Text('Signer',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(' ',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Client ID',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(' ',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Block',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('App',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Height',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Time',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Total',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Last Commit Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Data Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Validator Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Next Validator Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Consensus Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('App Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Last Result Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Evidence Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Proposer Address',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text('',
                                  style:kMediumBoldTextStyle),

                            ]
                        ),
                      ),
                    ),
                    Container(margin: const EdgeInsets.only(right: 10,top: 10,left: 10),
                        width: MediaQuery.of(context).size.width/1.1,
                        decoration: kBoxDecorationWithGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget>[
                                Text ('Information',
                                    style:kMediumBoldTextStyle),
                                const SizedBox(height: 20,),
                                Text('IBC Acknowledgement',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Sequence',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Amount',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('--',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Origin Amount',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('--',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Origin Denom',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('--',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Reciever',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('--',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Sender',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('--',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Source Port',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Source Channel',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Destination Port',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Destination Channel',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Signer',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('',
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Effected',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('--',
                                    style:kMediumBoldTextStyle ),
                              ]
                          ),
                        )
                    ),
                    // Container(margin: const EdgeInsets.only(right: 10,top: 10,left: 10),
                    //     width: MediaQuery.of(context).size.width/1.1,
                    //     decoration: kBoxDecorationWithGradient,
                    //     child: Padding(
                    //         padding: const EdgeInsets.all(18.0),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text('IBC Progress',
                    //                 style:kMediumBoldTextStyle),
                    //             const SizedBox(height:30),
                    //             Column(
                    //               children: [Row(
                    //                 children: [
                    //                   const Text(''),
                    //
                    //                   Column(
                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                    //                       children:[
                    //                         const Text('Transfer'),
                    //                         const SizedBox(height:10),
                    //                         Container(
                    //                           decoration: BoxDecoration (
                    //                             border: Border.all(
                    //                               color: Colors.lightGreenAccent,
                    //                               width: 1.0,
                    //                             ),
                    //                             color: Colors.lightGreenAccent.withOpacity(.1),
                    //                             borderRadius: const BorderRadius.all(Radius.circular(15.0),
                    //
                    //                             ),
                    //                             boxShadow: [
                    //                               BoxShadow(
                    //                                 color: Colors.lightGreenAccent.withOpacity(.05),
                    //                                 spreadRadius: 1,
                    //                                 blurRadius: 1,
                    //                                 offset: const Offset(-2, -2), // changes position of shadow
                    //                               ),],),
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                    //                             child: Padding(
                    //                               padding: const EdgeInsets.all(8.0),
                    //                               child: Column(
                    //                                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                                 children: [
                    //                                   Text('COMDEX',
                    //                                       style:kMediumBoldTextStyle),
                    //                                   const SizedBox(height: 5,),
                    //                                   Text('CA07HYYGYG12....12334HGGVGG',
                    //                                       style:kExtraSmallTextStyle),
                    //                                   const SizedBox(height: 5,),
                    //
                    //                                   Text('2h ago (2022-08-10 21:34:42)',
                    //                                       style:kExtraSmallTextStyle),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         const SizedBox(height: 20,),
                    //                         const Text('Reciever'),
                    //                         const SizedBox(height:10),
                    //                         Container(
                    //                           decoration: BoxDecoration (
                    //                             border: Border.all(
                    //                               color: Colors.lightGreenAccent,
                    //                               width: 1.0,
                    //                             ),
                    //                             color: Colors.lightGreenAccent.withOpacity(.1),
                    //                             borderRadius: const BorderRadius.all(Radius.circular(15.0),
                    //
                    //                             ),
                    //                             boxShadow: [
                    //                               BoxShadow(
                    //                                 color: Colors.grey.withOpacity(.05),
                    //                                 spreadRadius: 1,
                    //                                 blurRadius: 1,
                    //                                 offset: const Offset(-2, -2), // changes position of shadow
                    //                               ),],),
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                    //                             child: Padding(
                    //                               padding: const EdgeInsets.all(8.0),
                    //                               child: Column(
                    //                                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                                 children: [
                    //                                   Text('JUNO',
                    //                                       style:kMediumBoldTextStyle),
                    //                                   const SizedBox(height: 5,),
                    //                                   Text('CA07HYYGYG12....12334HGGVGG',
                    //                                       style:kExtraSmallTextStyle),
                    //                                   const SizedBox(height: 5,),
                    //
                    //                                   Text('2h ago (2022-08-10 21:34:42)',
                    //                                       style:kExtraSmallTextStyle),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         const SizedBox(height:20),
                    //                         const Text('Acknowledgement'),
                    //                         const SizedBox(height:10),
                    //                         Container(
                    //                           decoration: BoxDecoration (
                    //                             border: Border.all(
                    //                               color: Colors.lightGreenAccent,
                    //                               width: 1.0,
                    //                             ),
                    //                             color: Colors.lightGreenAccent.withOpacity(.1),
                    //                             borderRadius: const BorderRadius.all(Radius.circular(15.0),
                    //
                    //                             ),
                    //                             boxShadow: [
                    //                               BoxShadow(
                    //                                 color: Colors.grey.withOpacity(.05),
                    //                                 spreadRadius: 1,
                    //                                 blurRadius: 1,
                    //                                 offset: const Offset(-2, -2), // changes position of shadow
                    //                               ),],),
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                    //                             child: Padding(
                    //                               padding: const EdgeInsets.all(8.0),
                    //                               child: Column(
                    //                                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                                 children: [
                    //                                   Text('COMDEX',
                    //                                       style:kMediumBoldTextStyle),
                    //                                   const SizedBox(height: 5,),
                    //                                   Text('CA07HYYGYG12....12334HGGVGG',
                    //                                       style:kExtraSmallTextStyle),
                    //                                   const SizedBox(height: 5,),
                    //                                   Text('2h ago (2022-08-10 21:34:42)',
                    //                                       style:kExtraSmallTextStyle),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ]
                    //                   )
                    //                 ],
                    //               )],
                    //             ),
                    //           ],)))
                  ],
                )
                    : Container(
                  margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: kBoxDecorationWithGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('d',
                              style: kMediumBoldTextStyle)
                        ]),
                  ),
                );
              }),

            ]
        ),
      );
  }
}
