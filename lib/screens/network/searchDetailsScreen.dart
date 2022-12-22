import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/controller/txToggleController.dart';
import '../../backend_files/networkList.dart';
import '../../backend_files/txModel.dart';
import '../../constants/constants.dart';
import '../../backend_files/blocksModel.dart';
import '../../constants/functions.dart';
import '../../controller/networklistController.dart';
import '../../controller/txController.dart';

class SearchScreen extends StatefulWidget {
  var nameController;
 SearchScreen({Key? key,this.nameController}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TxToggleController _txController=Get.put(TxToggleController());
  NetworkController networkController = Get.put(NetworkController());
  List<BlockModel>? blockDetails;
  List<TxModel>? txModel;
  var blockLoaded=0;
  var txLoaded=0;
  var summarySelected=0;
  var loading=false;

  @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    loading=true;
    if(isNumeric(widget.nameController)) {

      final response = await http.get(Uri.parse(
          'http://167.235.151.252:3005/block/${widget.nameController.toString()}'));
      if (response.statusCode == 200) {
        blockDetails =
        List<BlockModel>.from(json.decode(response.body).map((x) => BlockModel.fromJson(x)));
        print(blockDetails);

        setState(() {
          if (blockDetails!.isNotEmpty ) {
            blockLoaded = 1;
          } else {
            blockLoaded = 0;
          }
        });
      } else {
        // print(response.statusCode);
        // print('+errorr');
        // print('https://meteor.rpc.comdex.one/block?height=${widget.txModel!.height!.toString()}');
      }
    }
    else if(widget.nameController==null){

    }
    else{
      final response = await http.get(Uri.parse(
          'http://167.235.151.252:3005/transaction/${widget.nameController.toString()}'));
      if (response.statusCode == 200) {
        txModel = List<TxModel>.from(json.decode(response.body).map((x) => TxModel.fromJson(x)));
        print(txModel);

        setState(() {
          if (txModel!.isNotEmpty) {
            txLoaded =1;
          } else {
            txLoaded = 0;
          }
        });
      }
      else {
         print(response.statusCode);
        // print('+errorr');
        // print('https://meteor.rpc.comdex.one/block?height=${widget.txModel!.height!.toString()}');
      }
    }
    loading=false;
  }
  @override
  Widget build(BuildContext context) {
    if(blockLoaded==1){
      return Scaffold(
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
        body: SingleChildScrollView(
            child:
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                    width: MediaQuery.of(context).size.width / 1.1,
                    // height:MediaQuery.of(context).size.height/ 1.1,
                    decoration: kBoxDecorationWithGradient,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Information', style: kMediumBoldTextStyle),


                            const SizedBox(
                              height: 20,
                            ),
                            Text('Block Height', style: kSmallTextStyle),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(blockDetails![0].height!, style: kMediumBoldTextStyle),

                            const SizedBox(
                              height: 20,
                            ),
                            Text('Hash', style: kSmallTextStyle),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(blockDetails![0].hash!, style: kMediumBoldTextStyle),

                            const SizedBox(
                              height: 20,
                            ),
                            Text('Number Of Transactions', style: kSmallTextStyle),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(blockDetails![0].numTxs!.toString(), style: kMediumBoldTextStyle),


                            const SizedBox(
                              height: 20,
                            ),
                            Text('TimeStamp', style: kSmallTextStyle),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(dateTime(blockDetails![0].timestamp!), style: kMediumBoldTextStyle),


                            const SizedBox(
                              height: 20,
                            ),
                            Text('Proposer Address', style: kSmallTextStyle),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(blockDetails![0].proposerAddress!, style: kMediumBoldTextStyle),

                            const SizedBox(
                              height: 20,
                            ),
                            Text('Total Gas', style: kSmallTextStyle),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(blockDetails![0].totalGas!, style: kMediumBoldTextStyle),

                          ]
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      );
    }
    else if(txLoaded==1){
      return
      //   Scaffold(
      //   appBar: AppBar(
      //         foregroundColor: Colors.black,
      //         backgroundColor: Colors.transparent,
      //         elevation: 0,
      //     title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               'Transaction Details',
      //               style: kBigBoldTextStyle,
      //             ),
      //           ],
      //         ),
      //         ),
      // body:   Column(
      //   children: [
      //
      //     Container(
      //       margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
      //       width: MediaQuery.of(context).size.width / 1.1,
      //       decoration: kBoxDecorationWithGradient,
      //       child: Padding(
      //         padding: const EdgeInsets.all(18.0),
      //         child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Text('Information', style: kMediumBoldTextStyle),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //               Text('Chain Id', style: kSmallTextStyle),
      //               const SizedBox(
      //                 height: 2,
      //               ),
      //               Text('comdex-1', style: kMediumBoldTextStyle),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //               Row(
      //                 children: [
      //                   Text('TxHash', style: kSmallTextStyle),
      //                   InkWell(
      //                     onTap:()=> Clipboard.setData ( ClipboardData(text: txModel![0].hash!,)).then((_){
      //                       ScaffoldMessenger.of(context)
      //                           .showSnackBar(const SnackBar(content: Text('Transaction Hash Copied to your clipboard !')
      //                       )
      //                       );
      //                     }),
      //                     child: Row(
      //                       children: [
      //                         const SizedBox(width:4),
      //                         const Icon(Icons.copy,
      //                           color: Colors.black54,
      //                           size: 15,
      //
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(
      //                 height: 2,
      //               ),
      //               Text((txModel![0].hash!),
      //                   textAlign: TextAlign.start
      //                   ,style:kMediumBoldTextStyle),
      //
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //               Text('Status', style: kSmallTextStyle),
      //               const SizedBox(
      //                 height: 2,
      //               ),
      //               Text(
      //                   txModel![0].success == true
      //                       ? 'Success'
      //                       : 'Fail',
      //                   style: kMediumBoldTextStyle),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //               Text('Height', style: kSmallTextStyle),
      //               const SizedBox(
      //                 height: 2,
      //               ),
      //               Text(txModel![0].height!,
      //                   style: kMediumBoldTextStyle),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //               Text('Time', style: kSmallTextStyle),
      //               const SizedBox(
      //                 height: 2,
      //               ),
      //               txLoaded==1? Text('dateTime(DateTime.parse(timestampTx).toLocal())', style: kMediumBoldTextStyle):
      //               SizedBox(
      //                   height:10,width:15,
      //                   child: LinearProgressIndicator()),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //               Text('Fee', style: kSmallTextStyle),
      //               const SizedBox(
      //                 height: 2,
      //               ),
      //               Text(
      //                   '${txModel![0].fee!.amount![0].amount!} ${txModel![0].fee!.amount![0].denom!}',
      //                   style: kMediumBoldTextStyle),
      //               const SizedBox(height: 20),
      //               Text('Gas (used/wanted)', style: kSmallTextStyle),
      //               const SizedBox(
      //                 height: 3,
      //               ),
      //               Text(
      //                   '${txModel![0].gasUsed!}/${txModel![0].gasWanted!}',
      //                   style: kMediumBoldTextStyle),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //               Text('Memo', style: kSmallTextStyle),
      //               const SizedBox(
      //                 height: 2,
      //               ),
      //               Text(txModel![0].memo!,
      //                   style: kMediumBoldTextStyle),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //             ]),
      //       ),
      //     ),
      //   ],
      // ),
      // );
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
                  ],
                ),
              ),
              GetBuilder<TxToggleController>(builder:(txToggleController) {
                return txToggleController.isBlockSelected == 0
                    ?
                      Column(
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
                                    onTap:()=> Clipboard.setData ( ClipboardData(text: txModel![0].hash!,)).then((_){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(content: Text('Transaction Hash Copied to your clipboard !')
                                      )
                                      );
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
                              Text((txModel![0].hash!),
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
                                  txModel![0].success == true
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
                              Text(txModel![0].height!,
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Time', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              txLoaded==1? Text('dateTime(DateTime.parse(timestampTx).toLocal())', style: kMediumBoldTextStyle):
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
                                  '${txModel![0].fee!.amount![0].amount!} ${txModel![0].fee!.amount![0].denom!}',
                                  style: kMediumBoldTextStyle),
                              const SizedBox(height: 20),
                              Text('Gas (used/wanted)', style: kSmallTextStyle),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                  '${txModel![0].gasUsed!}/${txModel![0].gasWanted!}',
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Memo', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(txModel![0].memo!,
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                            ]),
                      ),
                    ),
                    ( txModel![0].messages![0].header==null || txModel![0].messages![0].packet==null)? Container():Container(
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
                              Text(txModel![0].messages![0].signer??' ',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Client ID',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].clientId?? ' ',
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Block',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.version!.block!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('App',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.version!.app!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Height',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.height!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Time',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(dateTime(txModel![0].messages![0].header!.signedHeader!.header!.time!),
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
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.lastBlockId!.partSetHeader!.total!.toString(),
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Last Commit Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.lastCommitHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Data Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.lastCommitHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Validator Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.validatorsHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Next Validator Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.nextValidatorsHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Consensus Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.consensusHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('App Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.appHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Last Result Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.lastResultsHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Evidence Hash',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.evidenceHash!,
                                  style:kMediumBoldTextStyle),
                              const SizedBox(height: 20,),
                              Text('Proposer Address',
                                  style:kSmallTextStyle),
                              const SizedBox(height: 2,),
                              Text(txModel![0].messages![0].header!.signedHeader!.header!.proposerAddress!,
                                  style:kMediumBoldTextStyle),

                            ]
                        ),
                      ),
                    ),
                    ( txModel![0].messages![0].header==null || txModel![0].messages![0].packet==null)? Container(): Container(margin: const EdgeInsets.only(right: 10,top: 10,left: 10),
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
                                Text(txModel![0].messages![0].packet!.sequence!,
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
                                Text(txModel![0].messages![1].packet!.sourcePort!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Source Channel',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text(txModel![0].messages![1].packet!.sourceChannel!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Destination Port',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text(txModel![0].messages![1].packet!.destinationPort!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Destination Channel',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text(txModel![0].messages![1].packet!.destinationChannel!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Signer',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text(txModel![0].messages![1].signer!,
                                    style:kMediumBoldTextStyle ),
                                const SizedBox(height: 20,),
                                Text('Effected',
                                    style:kSmallTextStyle),
                                const SizedBox(height: 2,),
                                Text('--',
                                    style:kMediumBoldTextStyle ),
                              ]
                          ),
                        ),
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
                          txModel![0].rawLog!=null? Text(txModel![0].rawLog!.replaceAll(RegExp('/'), ''),
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
    // else if(txLoaded==0&&blockLoaded==0){
    //   return Scaffold(
    //     appBar: AppBar(
    //       foregroundColor: Colors.black,
    //       backgroundColor: Colors.transparent,
    //       elevation: 0,
    //       title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             'Transaction Details',
    //             style: kBigBoldTextStyle,
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: Text('No data Found'),
    //   );}
    else if(loading==true){
      return Scaffold(body: Center(child: CircularProgressIndicator()));}
    else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body:
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No Data Found',
              style: kMediumBoldTextStyle,),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10,horizontal: 40),
              child: Text('''Sorry, we couldn't find any results for ${widget.nameController}. Please input the correct block number, transaction hash''',textAlign: TextAlign.center,style: kSmallTextStyle),
            ),
          ],
        ),
        ),
      );
    }

  }
}
