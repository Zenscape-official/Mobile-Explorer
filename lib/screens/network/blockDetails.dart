import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/txModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/toggleController.dart';
import 'package:http/http.dart' as http;
import '../../backend_files/blocksModel.dart';
import '../../backend_files/contractModel.dart';
import '../../controller/txToggleController.dart';

class BlockDetails extends StatefulWidget {
  final BlockModel? blockModel;
  BlockDetails({Key? key,this.blockModel}) : super(key: key);
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
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.blockModel!.height!, style: kMediumBoldTextStyle),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Hash', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.blockModel!.hash!, style: kMediumBoldTextStyle),

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
                                  Text('TimeStamp', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(dateTime(widget.blockModel!.timestamp!), style: kMediumBoldTextStyle),


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
                                  Text('Total Gas', style: kSmallTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.blockModel!.totalGas!, style: kMediumBoldTextStyle),

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
