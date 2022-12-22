import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/txModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/toggleController.dart';
import 'package:http/http.dart' as http;
import '../../controller/txToggleController.dart';

class TxDetails extends StatefulWidget {
  final TxModel? txModel;
  var txTime;
   TxDetails({Key? key,this.txModel,this.txTime}) : super(key: key);
  @override
  State<TxDetails> createState() => _TxDetailsState();
}
 class _TxDetailsState extends State<TxDetails> {
  var raw;
  var isLoaded;
  int summarySelected=0;


  @override
  void initState() {
    super.initState();

    getData();
  }
  final TxToggleController txToggleController =Get.put(TxToggleController());
  var type;var timestampTx;
  var txLoaded=false;


  getData()async{

    final response = await http.get(Uri.parse('https://meteor.rpc.comdex.one/block?height=${widget.txModel!.height!.toString()}'));
    if (response.statusCode == 200) {

      timestampTx =  jsonDecode(response.body)['result']['block']['header']['time'];

      setState(() {
        if (timestampTx!=null){
          txLoaded=true;
        }
        else{
          txLoaded=false;
        }
      });
    }
    else{
      // print(response.statusCode);
      // print('+errorr');
      // print('https://meteor.rpc.comdex.one/block?height=${widget.txModel!.height!.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    type=getType(widget.txModel!.messages![0].type!);
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
              'Transaction Details',
              style: kBigBoldTextStyle,
            ),
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
                            summarySelected = index!;
                            txToggleController.updateData(index);
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
                                      onTap:()=> Clipboard.setData ( ClipboardData(text: widget.txModel!.hash!,)).then((_){
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
                                      Text((widget.txModel!.hash!),
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
                                    widget.txModel!.success == true
                                        ? 'Success'
                                        : 'Fail',
                                    style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Height', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(widget.txModel!.height!,
                                    style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Time', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                               txLoaded? Text(dateTime(DateTime.parse(timestampTx).toLocal()), style: kMediumBoldTextStyle):
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
                                Text(
                                    '${widget.txModel!.fee!.amount![0].amount!} ${widget.txModel!.fee!.amount![0].denom!}',
                                    style: kMediumBoldTextStyle),
                                const SizedBox(height: 20),
                                Text('Gas (used/wanted)', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                    '${widget.txModel!.gasUsed!}/${widget.txModel!.gasWanted!}',
                                    style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Memo', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(widget.txModel!.memo!,
                                    style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]),
                        ),
                      ),
                    ( widget.txModel!.messages![0].header==null || widget.txModel!.messages![0].packet==null)? Container():Container(
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
                              Text(widget.txModel!.messages![0].signer??' ',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Client ID',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].clientId?? ' ',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Block',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.version!.block!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('App',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.version!.app!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Height',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.height!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Time',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(dateTime(widget.txModel!.messages![0].header!.signedHeader!.header!.time!),
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
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.lastBlockId!.partSetHeader!.total!.toString(),
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Last Commit Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.lastCommitHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Data Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.lastCommitHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Validator Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.validatorsHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Next Validator Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.nextValidatorsHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Consensus Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.consensusHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('App Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.appHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Last Result Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.lastResultsHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Evidence Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.evidenceHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Proposer Address',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(widget.txModel!.messages![0].header!.signedHeader!.header!.proposerAddress!,
                                  style:kMediumBoldTextStyle),

                            ]
                        ),
                      ),
                    ),
                    ( widget.txModel!.messages![0].header==null || widget.txModel!.messages![0].packet==null)? Container(): Container(margin: const EdgeInsets.only(right: 10,top: 10,left: 10),
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
                                Text(widget.txModel!.messages![0].packet!.sequence!,
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
                                Text(widget.txModel!.messages![1].packet!.sourcePort!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Source Channel',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text(widget.txModel!.messages![1].packet!.sourceChannel!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Destination Port',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text(widget.txModel!.messages![1].packet!.destinationPort!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Destination Channel',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text(widget.txModel!.messages![1].packet!.destinationChannel!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Signer',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text(widget.txModel!.messages![1].signer!,
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
                            widget.txModel!.rawLog!=null? Text((widget.txModel!.rawLog!)
                                .replaceAll(RegExp(r'')
                                , '')
                                ,
                                style: kMediumBoldTextStyle):Text('No Logs Available',style: kMediumBoldTextStyle)
                          ]),
                    ),
                  );
          }),

              ]
              ),

      ),
    );
  }
}
