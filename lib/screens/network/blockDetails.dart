import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/constants/functions.dart';
import 'package:zenscape_app/screens/network/validatorDetails.dart';
import '../../backend_files/blocksModel.dart';
import 'package:http/http.dart' as http;
import '../../backend_files/networkList.dart';
import '../../backend_files/validatorsModel.dart';

class BlockDetails extends StatefulWidget {
  final BlockModel? blockModel;
  final String? valDesc;
  final NetworkList networkList;
  BlockDetails({Key? key,this.blockModel,this.valDesc, required this.networkList}) : super(key: key);
  @override
  State<BlockDetails> createState() => _BlockDetailsState();
}
class _BlockDetailsState extends State<BlockDetails> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      BlockDetailScreen(blockModel: widget.blockModel,networkList: widget.networkList,);
  }
}

class BlockDetailScreen extends StatefulWidget {
  BlockDetailScreen({
    Key? key,
    required this.blockModel, this.valDesc, required this.networkList
  }) : super(key: key);

  var blockModel;
  String? valDesc;
  NetworkList networkList;

  @override
  State<BlockDetailScreen> createState() => _BlockDetailScreenState();
}

class _BlockDetailScreenState extends State<BlockDetailScreen> {
  var valMoniker;
  var monikerLoaded=false;
  List<ValidatorModel>? validatorModel;


  @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    final response = await http.get(Uri.parse('${widget.networkList.blocksMoniker}${widget.blockModel!.proposerAddress}'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)[0]);
      validatorModel = validatorModelFromJson(response.body); jsonDecode(response.body)[0];
      setState(() {
        if (validatorModel!=null){
          monikerLoaded=true;
        }
        else{
          monikerLoaded=false;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
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
            child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                        width: MediaQuery.of(context).size.width / 1.1,
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

                                TextWithCopyIcon(copyTextValue: addComma(widget.blockModel!.height), copyTextName: 'BlockHeight'),
                                const SizedBox(
                                  height: 2,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Block Hash', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                TextWithCopyIcon(copyTextValue:widget.blockModel!.hash!,copyTextName: 'Block Hash'),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Number Of Transactions', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(widget.blockModel!.numTxs!.toString(), style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Time', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text('${dateTime(widget.blockModel!.timestamp!)} (${timeDifferenceFunction(dateTime(widget.blockModel!.timestamp!))})', style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),

                                Text('Proposer Address', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(widget.blockModel!.proposerAddress!, style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                              widget.networkList.uDenom=='uatom'?Container():  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Proposer',
                                        style:kSmallTextStyle),
                                    monikerLoaded? InkWell(
                                      onTap:monikerLoaded?
                                          () {
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: ValidatorDetails(
                                            networkList: widget.networkList,
                                            validatorModel: validatorModel![0],
                                            denom: widget.networkList.uDenom,
                                          ),
                                          withNavBar: true,
                                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                        );

                                      }: null,
                                      child: Text((validatorModel![0].moniker!)
                                          ,style:kMediumBlueBoldTextStyle),
                                    ):SizedBox(height:10,width:10,child: LinearProgressIndicator()),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                //const SizedBox(width:99),

                                Text('Total Gas', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text('${addComma(widget.blockModel!.totalGas) }${widget.networkList.uDenom}', style: kMediumBoldTextStyle),
                              ]
                          ),
                        ),
                      ),
                  ),
                ],
            ),
        ),
    );
  }
}
