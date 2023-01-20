import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/constants/functions.dart';
import 'package:zenscape_app/screens/network/searchDetailsScreen.dart';
import '../../backend_files/blocksModel.dart';
import 'package:http/http.dart' as http;

class BlockDetails extends StatefulWidget {
  final BlockModel? blockModel;
  final String? valDesc;
  BlockDetails({Key? key,this.blockModel,this.valDesc}) : super(key: key);
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
      BlockDetailScreen(blockModel: widget.blockModel,valDesc: widget.valDesc!);
  }
}

class BlockDetailScreen extends StatefulWidget {
  BlockDetailScreen({
    Key? key,
    required this.blockModel,required this.valDesc,

  }) : super(key: key);

  var blockModel;
  String valDesc;

  @override
  State<BlockDetailScreen> createState() => _BlockDetailScreenState();
}

class _BlockDetailScreenState extends State<BlockDetailScreen> {
  var valMoniker;
  var monikerLoaded=false;

  @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    final response = await http.get(Uri.parse('${widget.valDesc}${widget.blockModel!.proposerAddress}'));

    if (response.statusCode == 200) {
      valMoniker =  jsonDecode(response.body)[0]['moniker'];
      setState(() {
        if (valMoniker!=null){
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
                                InkWell(
                                    onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: SearchScreen(nameController: widget.blockModel!.proposerAddress! ),
                                      withNavBar: true,
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    ),
                                    child: Text(widget.blockModel!.proposerAddress!, style: kMediumBlueBoldTextStyle),),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Proposer',
                                    style:kSmallTextStyle),
                                //const SizedBox(width:99),
                                monikerLoaded? Text((valMoniker)
                                    ,style:kMediumBoldTextStyle):SizedBox(height:10,width:10,child: LinearProgressIndicator()),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Total Gas', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(addComma(widget.blockModel!.totalGas??''), style: kMediumBoldTextStyle),
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
