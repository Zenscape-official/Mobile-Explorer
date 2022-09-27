import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend%20files/blocksModel.dart';
import 'package:zenscape_app/backend%20files/txModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/toggleController.dart';
import 'package:zenscape_app/controller/txController.dart';
import '../../backend files/networkList.dart';
import '../../constants/constants.dart';
import '../../Screens/network/transactionDetails.dart';
import '../../controller/blocksController.dart';
import '../../widgets/navigationDrawerWidget.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/services.dart';


class Blocks extends StatefulWidget {
  final NetworkList? networkData;
 const Blocks({this.networkData});
  @override
  State<Blocks> createState() => _BlocksState();
}

class _BlocksState extends State<Blocks> {
  ToggleController toggleController=Get.put(ToggleController());
  final BlocksController _blocksController= Get.put(BlocksController());
  final TxController _txController=Get.put(TxController());
  var blocks;
  var tx;
  bool isLoaded=false;
  @override
  void initState() {
    super.initState();
    blockData();
    txData();
  }
  blockData() async{
    blocks= await _blocksController.fetchBlocks(widget.networkData!.blocksUrl!);
    setState(() {
      if (blocks!=null){
        isLoaded=true;
      }
      else{
        isLoaded=false;
      }
    });
  }
  txData() async{
    tx= await _txController.fetchTx(widget.networkData!.transactionsUrl!);
    setState(() {
      if (blocks!=null){
        isLoaded==true;
      }
      else{
        isLoaded=false;
      }
    });
  }
  int blockSelected=0;
  TextEditingController nameController=TextEditingController();
  String txHash='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDraw(networkData: widget.networkData),
      appBar: AppBar(
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            GetBuilder<ToggleController>(builder: (blockController){

              return blockController.isBlockSelected==0?

              Text('Blocks',
                style: kBigBoldTextStyle,):

              Text('Transactions',
                style: kBigBoldTextStyle,);}),
            CircleAvatar(
                radius:15,
                child: Image.network(widget.networkData!.logoUrl??widget.networkData!.logUrl!),
                backgroundColor: Colors.transparent),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        txHash = text;
                        //you can access nameController in its scope to get
                        // the value of text entered as shown below
                        //fullName = nameController.text;
                      });
                    },
                  ),
                )),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ToggleSwitch(
                    borderWidth: 1,
                    minHeight: 30,
                    borderColor: [Colors.grey.shade400],
                    minWidth: 110.0,
                    cornerRadius: 20.0,
                    activeBgColors:  [[const Color(0xFF12BFFF).withOpacity(.1)], [const Color(0xFF12BFFF).withOpacity(.1)]],
                    activeFgColor: Colors.lightBlueAccent,
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: Colors.grey,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: const ['Blocks', 'Transactions'],
                    radiusStyle: true,
                    onToggle: (index) {
                        blockSelected=index!;
                        toggleController.updateData(index);
                    },
                  ),
                ]
              ),
            ),
            isLoaded?
            GetBuilder<ToggleController>(builder: (blockController){
               return blockController.isBlockSelected==0?
              ( ListView.builder(
                   reverse: true,
                   physics: const NeverScrollableScrollPhysics(),
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   itemCount: BlocksController.blockList.length,
                   itemBuilder: (BuildContext context, int index) {
                     return
                       BlockContainer(blockModel: BlocksController.blockList[index],);
                   }
               )):
               ListView.builder(
                   reverse: true,
                   physics: const NeverScrollableScrollPhysics(),
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   itemCount: TxController.txList.length,
                   itemBuilder: (BuildContext context, int index) {
                     return
                       TxContainer(txModel: TxController.txList[index],);
                   }
                   );
             }
             ):Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

class TxContainer extends StatelessWidget {
  final TxModel? txModel;
  const TxContainer({
    Key? key,
    this.txModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> Get.to(() => TxDetails(txModel:txModel)),
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
                        Text(txModel!.header!.id.toString(),
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
                        Text('Amount',
                            style:kSmallTextStyle),
                        Text('',
                            style:kSmallBoldTextStyle)
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fee',
                            style:kSmallTextStyle),
                        Text(txModel!.data!.tx!.authInfo!.fee!.amount![0].amount!+ ' '+txModel!.data!.tx!.authInfo!.fee!.amount![0].denom!.toUpperCase(),
                            style:kSmallBoldTextStyle)
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text('Height',
                            style:kSmallTextStyle),
                        Text(txModel!.data!.height!,
                            style:kSmallBoldTextStyle)
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Type',
                            style:kSmallTextStyle),
                        Text(txModel!.data!.logs![0].events![0].type.toString(),
                            style:kSmallBoldTextStyle)
                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class BlockContainer extends StatelessWidget {
  final BlockModel? blockModel;
  const BlockContainer({
    Key? key, this.blockModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Text(blockModel!.height!.toString(),
                          style:kMediumBoldTextStyle),
                      Container(
                        decoration: BoxDecoration (
                          border: Border.all(
                            color: Colors.lightBlueAccent.withOpacity(.5),
                            width: 1.0,
                          ),
                          color: const Color(0xFF8CDAFF).withOpacity(.5),
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
                    children: [
                      Text('Block Hash',
                          style:kSmallTextStyle),
                      const SizedBox(width: 90),
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: const StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                              style: kSmallTextStyle,
                              text: blockModel!.blockHash!,),
                        ),
                      ),
                      InkWell(
                        onTap:()=> Clipboard.setData (ClipboardData(text: blockModel!.blockHash!,)).then((_){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text('BlockHash to your clipboard !')));
                        }),
                          child: Icon(Icons.copy,
                            color: Colors.black54,),
                        ),
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
                      const SizedBox(width:99),
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: const StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                            style: kSmallTextStyle,
                            text: blockModel!.moniker,),
                        ),
                      ),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Transaction',
                          style:kSmallTextStyle),
                      Text(blockModel!.numTxs.toString(),
                          style:kSmallTextStyle)
                    ]
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,4.0,8,12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Time',
                          style:kSmallTextStyle),
                      Text(blockModel!.timestamp.toString(),
                          style:kSmallTextStyle)
                    ]
                ),

              ),

            ]
        ),
      ),
    );
  }
}
