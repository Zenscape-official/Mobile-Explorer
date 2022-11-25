import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/txModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/rawLogController.dart';
class TxDetails extends StatefulWidget {
  final TxModel? txModel;
  const TxDetails({Key? key,this.txModel}) : super(key: key);

  @override
  State<TxDetails> createState() => _TxDetailsState();
}

 class _TxDetailsState extends State<TxDetails> {
  var raw;
  var isLoaded;
  @override
  void initState() {
    super.initState();
    rawData();
  }
  final RawLogController rawLogController=Get.put(RawLogController());
  void rawData() async {
    // raw =
    // await rawLogController.fetchTx(widget.txModel!.rawLog);
    setState(() {
      if(raw!=null){
        isLoaded=true;
      }
      else {
        isLoaded=false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
   print(raw);
    return widget.txModel!.messages![0].header==null?Scaffold(body:Center(child:Text('No Data Found!'))): Scaffold(
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
                // ToggleButton(leftTitle: 'Summary',rightTitle: 'JSON',)
              ],),
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
                          Text('Information',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Chain Id',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text('' ,
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('TxHash',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text(widget.txModel!.hash!,
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Status',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text(widget.txModel!.success==true?'Success':'Fail',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Height',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text(widget.txModel!.height!,
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Time',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text(

                          '',
                          style:kMediumBoldTextStyle
                      ),
                      const SizedBox(height: 20,),
                      Text('Fee',
                          style:kSmallTextStyle),
                      const SizedBox(
                        height: 2,),
                      Text(
                          '${widget.txModel!.fee!.amount![0].amount!} ${widget.txModel!.fee!.amount![0].denom!}',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20),
                      Text('Gas (used/wanted)',
                          style:kSmallTextStyle),
                      const SizedBox(height: 3,),
                      Text('${widget.txModel!.gasUsed!}/${widget.txModel!.gasWanted!}',
                          style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
                      Text('Memo',
                          style:kSmallTextStyle),
                      const SizedBox(height: 2,),
                      Text(widget.txModel!.memo!,
                          // ,
                        style:kMediumBoldTextStyle),
                      const SizedBox(height: 20,),
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

                    ]),
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
                      Text(widget.txModel!.messages![1].packet!.sequence!,
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
            Container(margin: const EdgeInsets.only(right: 10,top: 10,left: 10),
                width: MediaQuery.of(context).size.width/1.1,
                decoration: kBoxDecorationWithGradient,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('IBC Progress',
                    style:kMediumBoldTextStyle),
                      const SizedBox(height:30),
                    Column(
                      children: [Row(
                        children: [
                          const Text(''),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              const Text('Transfer'),
                              const SizedBox(height:10),
                              Container(
                                decoration: BoxDecoration (
                                  border: Border.all(
                                    color: Colors.lightGreenAccent,
                                    width: 1.0,
                                  ),
                                  color: Colors.lightGreenAccent.withOpacity(.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(15.0),

                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.lightGreenAccent.withOpacity(.05),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(-2, -2), // changes position of shadow
                                    ),],),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('COMDEX',
                                            style:kMediumBoldTextStyle),
                                        const SizedBox(height: 5,),
                                        Text('CA07HYYGYG12....12334HGGVGG',
                                            style:kExtraSmallTextStyle),
                                        const SizedBox(height: 5,),

                                        Text('2h ago (2022-08-10 21:34:42)',
                                            style:kExtraSmallTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              const Text('Reciever'),
                              const SizedBox(height:10),
                              Container(
                                decoration: BoxDecoration (
                                  border: Border.all(
                                    color: Colors.lightGreenAccent,
                                    width: 1.0,
                                  ),
                                  color: Colors.lightGreenAccent.withOpacity(.1),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('JUNO',
                                            style:kMediumBoldTextStyle),
                                        const SizedBox(height: 5,),
                                        Text('CA07HYYGYG12....12334HGGVGG',
                                            style:kExtraSmallTextStyle),
                                        const SizedBox(height: 5,),

                                        Text('2h ago (2022-08-10 21:34:42)',
                                            style:kExtraSmallTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height:20),
                              const Text('Acknowledgement'),
                              const SizedBox(height:10),
                              Container(
                                decoration: BoxDecoration (
                                  border: Border.all(
                                    color: Colors.lightGreenAccent,
                                    width: 1.0,
                                  ),
                                  color: Colors.lightGreenAccent.withOpacity(.1),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('COMDEX',
                                            style:kMediumBoldTextStyle),
                                        const SizedBox(height: 5,),
                                        Text('CA07HYYGYG12....12334HGGVGG',
                                            style:kExtraSmallTextStyle),
                                        const SizedBox(height: 5,),
                                        Text('2h ago (2022-08-10 21:34:42)',
                                            style:kExtraSmallTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          )
                        ],
                      )],
                    ),
                  ],)))
              ]
              ),

      ),
    );
  }
}
