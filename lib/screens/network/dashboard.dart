import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/main.dart';
import '../../backend_files/blocksModel.dart';
import '../../backend_files/txModel.dart';
import '../../constants/constString.dart';
import '../../controller/blocksController.dart';
import '../../controller/txController.dart';
import '../../widgets/navigationDrawerWidget.dart';
import '../homeScreen.dart';
import 'package:http/http.dart' as http;

class NetworkDashBoard extends StatefulWidget {
  final NetworkList? networkData;
  const NetworkDashBoard({this.networkData});

  @override
  State<NetworkDashBoard> createState() => _NetworkDashBoardState();
}
class _NetworkDashBoardState extends State<NetworkDashBoard> {

  List<String> details = [];
  final BlocksController _blocksController = Get.put(BlocksController());
  final TxController _txController = Get.put(TxController());
  TextEditingController nameController = TextEditingController();
  String fullName = '';
  var blocktime;
  var bondedtoken;
  var communityPool='33934';
  var inflation;
  var height;
  var bankTotal;
  var blocks;
  var tx;
  double APR = 0;
  bool isLoaded = false;
  void initstate() {
    super.initState();
    getData();
  }

  static Future<String> fetchdata(String input, String json) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body)[0][json]);
      return await jsonDecode(response.body)[0][json];
    } else {
      return '';
    }
  }

  static Future<String> fetchSingleData(String input, String json) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body)[json]);
      return await jsonDecode(response.body)[json];
    } else {
      return '';
    }
  }

  static Future<String> fetchBankData(String input) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {
     // print(jsonDecode(response.body)['result']['supply'][20]['amount']);
      return await jsonDecode(response.body)['result']['supply'][21]['amount'];
    } else {
      return '';
    }
  }

  void getData() async {
    height = (await fetchSingleData(widget.networkData!.height!, 'height'));
    bankTotal = (await fetchBankData(widget.networkData!.height!));
    blocktime =
        (await fetchdata(widget.networkData!.blocktime!, 'average_time'));
    inflation = (await fetchdata(widget.networkData!.inflation!, 'value'));
    // communityPool =
    //     await fetchdata(widget.networkData!.communityPool!, 'coins');
    bondedtoken =
        await fetchdata(widget.networkData!.bondedTokens!, 'bonded_tokens');
      //print('INF $inflation');print('BT $bondedtoken');
    APR = ((double.parse(inflation) * double.parse(bankTotal)) /
            double.parse(bondedtoken)) * 100;
    //print('APR $APR');

    details = [
      height!,
      widget.networkData!.transaction!,
      k_m_b_generator(double.parse(bondedtoken)),
      (communityPool),
      truncateToDecimalPlaces(double.parse(inflation!), 2).toString(),
      "${truncateToDecimalPlaces((APR), 2).toString()}%"
    ];
    tx= await _txController.fetchTx(widget.networkData!.transactionsUrl!);
    blocks= await _blocksController.fetchBlocks(widget.networkData!.blocksUrl!);
    setState(() {
      if (blocktime != null &&
          inflation != null &&
          bondedtoken != null&&
          blocks!=null &&
      tx!=null) {
        isLoaded = true;
      } else {
        isLoaded = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return isLoaded
        ? Scaffold(
            drawer: NavDraw(
              networkData: widget.networkData,
              logoUrl:
                  widget.networkData!.logoUrl ?? widget.networkData!.logUrl,
            ),
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratBold',
                      fontSize: 20,
                    ),
                  ),
                  CircleAvatar(
                      radius: 15,
                      child: InkWell(
                        onTap:()=>
                        Navigator.of(context).popUntil((route) => route.isFirst)
                        ,
                        child: Image.network(widget.networkData!.logoUrl ??
                            widget.networkData!.logUrl!),
                      ),
                      backgroundColor: Colors.transparent
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 40,
                      decoration: kBoxDecorationWithoutGradient,
                      margin: const EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 8.0, bottom: 8.0, top: 8.0),
                            filled: true,
                            fillColor: Colors.transparent,
                            focusedBorder: InputBorder.none,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Select a chain',
                            prefixIcon: const Icon(Icons.search),
                          ),
                          onChanged: (text) {
                            setState(() {
                              fullName = text;
                            });
                          },
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.4,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        // height:MediaQuery.of(context).size.height/1.2,
                        decoration: kBoxDecorationWithGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 15,
                                          child: Image.network(
                                              widget.networkData!.logoUrl ??
                                                  widget.networkData!.logUrl!),
                                          backgroundColor: Colors.transparent),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          widget.networkData!.denom!,
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(1),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'MontserratRegular'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: kBoxBorder,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'BLOCK TIME ',
                                            style: kExtraSmallTextStyle,
                                          ),
                                          Text(
                                              truncateToDecimalPlaces(
                                                      double.parse(blocktime!),
                                                      2)
                                                  .toString(),
                                              style: kExtraSmallBoldTextStyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(200.0)),
                                  border: Border.all(
                                    color:
                                        Colors.lightBlueAccent.withOpacity(.3),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: (
                                      Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(150.0)),
                                      border: Border.all(
                                        color: Colors.lightBlueAccent
                                            .withOpacity(.5),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                  '\$' +
                                                      truncateToDecimalPlaces(
                                                              double.parse(widget
                                                                  .networkData!
                                                                  .price!),
                                                              2)
                                                          .toString(),
                                                  style: kBigBoldTextStyle),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              SizedBox(
                                                width:65,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${
                                                        truncateToDecimalPlaces(
                                                            double.parse(widget
                                                                .networkData!
                                                                .percChangeInPrice!),
                                                            2)
                                                      } %'.toString(),
                                                      style: (double.parse(widget
                                                                  .networkData!
                                                                  .percChangeInPrice!) >
                                                              0
                                                          ? const TextStyle(
                                                              color:
                                                                  Color(0xFF15BE46))
                                                          : const TextStyle(
                                                              color: Colors.red)),
                                                    ),
                                                    SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child: SvgPicture.asset('assets/svgfiles/trending_up_FILL0_wght400_GRAD0_opsz48.svg',
                                                        color: (double.parse(widget
                                                            .networkData!
                                                            .percChangeInPrice!) >
                                                            0
                                                            ?
                                                            const Color(0xFF15BE46)
                                                            :  Colors.red)))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(250.0)),
                                          border: Border.all(
                                            color: Colors.lightBlueAccent,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Market Cap',
                                          style: kMediumTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          k_m_b_generator(double.parse(
                                              widget.networkData!.marketCap!)),
                                          style: kMediumBoldTextStyle,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '24h Vol',
                                          style: kMediumTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: SvgPicture.asset('assets/svgfiles/trending_up_FILL0_wght400_GRAD0_opsz48.svg',
                                                color:  double.parse(widget
                                                    .networkData!
                                                    .the24HrVol!) >
                                                    0?const Color(0xFF15BE46):Colors.red.withOpacity(.8))),
                                            Text(double.parse(widget.networkData!.the24HrVol!).toString()
                                            ,
                                                style: double.parse(widget
                                                            .networkData!
                                                            .the24HrVol!) >
                                                        0
                                                    ? const TextStyle(
                                                        fontFamily:
                                                            'MontserratBold',
                                                        fontSize: 17,
                                                        color: Color(0xFF15BE46))
                                                    :  TextStyle(
                                                        fontFamily:
                                                            'MontserratBold',
                                                        fontSize: 17,
                                                        color: Colors.red.withOpacity(.8))),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: StaggeredGridView.countBuilder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return InfoCard(
                              title1: par[index],
                              icon1: image[index],
                              titleValue1: details[index]);
                        },
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(1)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: kBoxDecorationWithoutGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.how_to_vote_outlined),
                              const SizedBox(height: 6),
                              Text(
                                'Voting Period',
                                style: kSmallTextStyle,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '3/4',
                                style: kBigTextStyle,
                              )
                            ],
                          ),
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
                      child: ListView.builder(
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: BlocksController.blockList.length < 2
                              ? BlocksController.blockList.length
                              : 2,
                          itemBuilder: (BuildContext context, int index) {
                            return BlockContDash(
                              blockModel: BlocksController.blockList[index],
                            );
                          })),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
                      child: ListView.builder(
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: TxController.txList.length < 2
                              ? TxController.txList.length
                              : 2,
                          itemBuilder: (BuildContext context, int index) {
                            return TxContDash(
                              txModel: TxController.txList[index],
                            );
                          })),
                ],
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}

class BlockContDash extends StatelessWidget {
  final BlockModel? blockModel;
  const BlockContDash({Key? key, this.blockModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4, 8, 8),
        child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: kBoxDecorationWithoutGradient,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Blocks',
                      style: kSmallBoldTextStyle,
                    ),
                  ),
                  const TextButton(
                    onPressed: null,
                    child: Text('See more'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                  child: Card(
                      color: const Color(0xFFF9FAFC),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  blockModel!.height!,
                                  style: kSmallBoldTextStyle,
                                ),
                                Text(
                                  '${
                                      blockModel!.timestamp!
                                        .difference(timestamp)
                                        .inSeconds
                                  }s ago',
                                  style: kSmallBoldTextStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Txs',
                                  style: kSmallTextStyle,
                                ),
                                Text(
                                  blockModel!.numTxs!.toString(),
                                  style: kSmallBoldTextStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Time',
                                  style: kSmallTextStyle,
                                ),
                                Text(
                                  '${dateTime(blockModel!.timestamp!)} ${(blockModel!.timestamp!.timeZoneName)}'.toString(),
                                  style: kSmallBoldTextStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ])));
  }
}

class TxContDash extends StatelessWidget {
  final TxModel? txModel;
  const TxContDash({
    Key? key,
    this.txModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4, 8, 8),
        child: Container(
          decoration: kBoxDecorationWithoutGradient,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Transaction',
                      style: kSmallBoldTextStyle,
                    ),
                  ),
                  const TextButton(
                    onPressed: null,
                    child: Text('See more'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                  child: Card(
                      color: const Color(0xFFF9FAFC),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                 function(txModel!.hash!),
                                  style: kSmallBoldTextStyle,
                                ),
                                Text(
                                  '10s Ago',
                                  style: kSmallBoldTextStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amount',
                                  style: kSmallTextStyle,
                                ),
                                Text(
                                  txModel!.fee!.amount![0].amount!,
                                  style: kSmallBoldTextStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Time',
                                  style: kSmallTextStyle,
                                ),
                                Text(
                                  '',
                                  style: kSmallBoldTextStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
