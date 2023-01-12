import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenscape_app/constants/constants.dart';
import '../../backend_files/blocksModel.dart';
import 'package:http/http.dart' as http;

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
      BlockDetailScreen(blockModel: widget.blockModel);
  }
}

class BlockDetailScreen extends StatefulWidget {
  BlockDetailScreen({
    Key? key,
    required this.blockModel,

  }) : super(key: key);

  var blockModel;

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
    final response = await http.get(Uri.parse('http://167.235.151.252:3005/validatorDescription/${widget.blockModel!.proposerAddress}'));

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
                                Row(
                                  children: [
                                    Text('Block Height', style: kSmallTextStyle),
                                    InkWell(
                                      onTap: () =>
                                          Clipboard.setData(ClipboardData(
                                            text: widget.blockModel!.height,
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Block Height Copied to your clipboard !')));
                                          }),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.copy,
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
                                Text(widget.blockModel!.height!, style: kMediumBoldTextStyle),

                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text('Hash', style: kSmallTextStyle),
                                    InkWell(
                                      onTap: () =>
                                          Clipboard.setData(ClipboardData(
                                            text: widget.blockModel!.hash,
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Hash Copied to your clipboard !')));
                                          }),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.copy,
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
                                Row(
                                  children: [
                                    Text('Proposer Address', style: kSmallTextStyle),
                                    InkWell(
                                      onTap: () =>
                                          Clipboard.setData(ClipboardData(
                                            text: widget.blockModel!.proposerAddress!,
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Proposer Address Copied to your clipboard !')));
                                          }),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.copy,
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
                                Text(widget.blockModel!.proposerAddress!, style: kMediumBoldTextStyle),

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
