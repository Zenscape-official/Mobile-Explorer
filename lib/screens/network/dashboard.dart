import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/constants/functions.dart';
import 'package:zenscape_app/controller/dashboardController.dart';
import 'package:zenscape_app/controller/toggleController.dart';
import '../../Screens/network/blocks.dart';
import '../../backend_files/bankTotalModal.dart';
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
  var details=['0','0','0','0','0','0'];
  final BlocksController _blocksController = Get.put(BlocksController());
  final DashboardController _dashboardController =
  Get.put(DashboardController());
  final TxController _txController = Get.put(TxController());
  final ToggleController toggleController =Get.put(ToggleController());
  String fullName = '';
  var blockTime;
  var txNum;
  var bondedToken;
  var communityPool;
  var inflation = '';
  var height;
  var bankTotal;
  var blocks;
  var tx;
  List<dynamic>? supply;
  double APR = 0;
  bool isLoaded = false;
  bool isListLoaded = false;
  var result;
  void initstate() {
    super.initState();
    getData();
  }

  getData() async {
    result =
    await _blocksController.fetchBlocks(widget.networkData!.blocksUrl!);
    //getDialogue(result);
    height = (await _dashboardController.fetchSingleData(
        widget.networkData!.height!, 'height'));
    txNum = (await _dashboardController.fetchdata(
        widget.networkData!.transaction!, 'count'));
    blockTime = (await _dashboardController.fetchdata(
        widget.networkData!.blocktime!, 'average_time'));
    supply =
    (await _dashboardController.fetchBankData(widget.networkData!.height!));
    print(supply);

    bondedToken = await _dashboardController.fetchdata(
        widget.networkData!.bondedTokens!, 'bonded_tokens');

    inflation = (await _dashboardController.fetchdata(
        widget.networkData!.inflation!, 'value'));
    communityPool = await _dashboardController.fetchdata(
        widget.networkData!.communityPool!, 'coins');
    for(int i=0;i<supply!.length;i++){
      print(supply![i].denom);
      if(supply![i].denom=='ucmdx'){
        bankTotal=supply![i].amount;
        print(bankTotal);
      }
    }
        print(bankTotal);
    APR = ((double.parse(inflation) * double.parse(bankTotal)) /
        double.parse(bondedToken)) *
        100;

    details = [
      height,
      txNum,
      k_m_b_generator(double.parse(bondedToken)),
      k_m_b_generator(double.parse(removeAllChar(communityPool))),
      '${truncateToDecimalPlaces(double.parse(inflation) * 100, 2)}%'
          .toString(),
      "${truncateToDecimalPlaces((APR), 2).toString()}%"
    ];
    tx = await _txController.fetchTx(widget.networkData!.transactionsUrl!);
    blocks =
    await _blocksController.fetchBlocks(widget.networkData!.blocksUrl!);
    setState(() {
      if (blocks != null && tx != null) {
        isLoaded = true;
      } else {
        isLoaded = false;
      }
      if (height != null && txNum != null && communityPool != null) {
        isListLoaded = true;
      } else {
        isListLoaded = false;
      }
    });
  }

  getDialogue(var result) {
    if (result['success'] == false) {
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: kMediumTextStyle,
            ),
            content: Text(result['response'], style: kMediumBoldTextStyle),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                      () =>
                      Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return widget.networkData!.id=='comdex'? Scaffold(
        drawer: NavDraw(
          networkData: widget.networkData,
          logoUrl: widget.networkData!.logoUrl ?? widget.networkData!.logUrl,
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
              // CircleAvatar(
              //     radius: 15,
              //     child: InkWell(
              //       onTap: () => Navigator.of(context)
              //           .popUntil((route) => route.isFirst),
              //       child: Image.network(widget.networkData!.logoUrl ??
              //           widget.networkData!.logUrl!),
              //     ),
              //     backgroundColor: Colors.transparent),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await getData();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Container(
                //     width: MediaQuery.of(context).size.width / 1.1,
                //     height: 40,
                //     decoration: kBoxDecorationWithoutGradient,
                //     margin: const EdgeInsets.all(20),
                //     child: Padding(
                //       padding: const EdgeInsets.all(0.0),
                //       child: TextField(
                //         controller: nameController,
                //         decoration: InputDecoration(
                //           contentPadding: const EdgeInsets.only(
                //               left: 8.0, bottom: 8.0, top: 8.0),
                //           filled: true,
                //           fillColor: Colors.transparent,
                //           focusedBorder: InputBorder.none,
                //           border: OutlineInputBorder(
                //               borderSide: const BorderSide(
                //                 width: 0,
                //                 style: BorderStyle.none,
                //               ),
                //               borderRadius: BorderRadius.circular(20)),
                //           hintText: 'Select a chain',
                //           prefixIcon: const Icon(Icons.search),
                //         ),
                //         onChanged: (text) {
                //           setState(() {
                //             fullName = text;
                //           });
                //         },
                //       ),
                //     )),
                SizedBox(
                  //height: MediaQuery.of(context).size.height / 2.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15,10,15,5),
                    child: Container(
                      // height:MediaQuery.of(context).size.height/1.2,
                      decoration: kBoxDecorationWithGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            color: Colors.black.withOpacity(1),
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
                                        isLoaded
                                            ? Text(
                                            truncateToDecimalPlaces(
                                                double.parse(blockTime),
                                                2)
                                                .toString(),
                                            style: kExtraSmallBoldTextStyle)
                                            : SizedBox(
                                            height: 5,
                                            width: 15,
                                            child:
                                            LinearProgressIndicator()),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 150,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(200.0)),
                                border: Border.all(
                                  color: Colors.lightBlueAccent.withOpacity(.3),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (Container(
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
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${truncateToDecimalPlaces(double.parse(widget.networkData!.percChangeInPrice ?? '0'), 2)} %'
                                                        .toString(),
                                                    style: (double.parse(widget
                                                        .networkData!
                                                        .percChangeInPrice!) >
                                                        0
                                                        ? const TextStyle(
                                                        color: Color(
                                                            0xFF15BE46))
                                                        : const TextStyle(
                                                        color: Colors.red)),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: double.parse(widget
                                                        .networkData!
                                                        .percChangeInPrice!) >
                                                        0
                                                        ? SvgPicture.asset(
                                                        'assets/svgfiles/trending_up_FILL0_wght400_GRAD0_opsz48.svg',
                                                        color: const Color(
                                                            0xFF15BE46))
                                                        : SvgPicture.asset(
                                                      'assets/svgfiles/trending_down_FILL0_wght400_GRAD0_opsz48.svg',
                                                      color: Colors.red
                                                          .withOpacity(
                                                          .8),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(250.0),
                                        ),
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
                                      isLoaded
                                          ? Text(
                                        '\$${k_m_b_generator(double.parse(widget.networkData!.marketCap!))}',
                                        style: kMediumBoldTextStyle,
                                      )
                                          : SizedBox(
                                          height: 5,
                                          width: 15,
                                          child: LinearProgressIndicator()),
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
                                          isLoaded
                                              ? double.parse(widget.networkData!.the24HrVol!) >
                                              0
                                              ? Text(
                                              '\$ ${truncateToDecimalPlaces(double.parse(widget.networkData!.the24HrVol!), 2).toString()}',
                                              style: double.parse(widget.networkData!.the24HrVol!) > 0
                                                  ? const TextStyle(
                                                  fontFamily:
                                                  'MontserratBold',
                                                  fontSize: 17,
                                                  color: Color(
                                                      0xFF15BE46))
                                                  : TextStyle(
                                                  fontFamily:
                                                  'MontserratBold',
                                                  fontSize: 17,
                                                  color: Colors.red
                                                      .withOpacity(
                                                      .8)))
                                              : Text(
                                              '\$${truncateToDecimalPlaces((double.parse(widget.networkData!.the24HrVol!) * (-1)), 2).toString()}',
                                              style: double.parse(widget.networkData!.the24HrVol!) > 0
                                                  ? const TextStyle(
                                                  fontFamily:
                                                  'MontserratBold',
                                                  fontSize: 17,
                                                  color:
                                                  Color(0xFF15BE46))
                                                  : TextStyle(fontFamily: 'MontserratBold', fontSize: 17, color: Colors.red.withOpacity(.8)))
                                              : SizedBox(height: 5, width: 15, child: LinearProgressIndicator()),
                                          SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: double.parse(widget
                                                  .networkData!
                                                  .the24HrVol!) >
                                                  0
                                                  ? SvgPicture.asset(
                                                  'assets/svgfiles/trending_up_FILL0_wght400_GRAD0_opsz48.svg',
                                                  color: const Color(
                                                      0xFF15BE46))
                                                  : SvgPicture.asset(
                                                'assets/svgfiles/trending_down_FILL0_wght400_GRAD0_opsz48.svg',
                                                color: Colors.red
                                                    .withOpacity(.8),
                                              )),
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
                  padding: const EdgeInsets.fromLTRB(20,20,20,6),
                  child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,

                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return
                         // isListLoaded ?
                        InfoCard(
                            title1: par[index],
                            icon1: image[index],
                            titleValue1: details[index]);
                        // : SizedBox(
                        //     height: 10,
                        //     width: 10,
                        //     child: LinearProgressIndicator());
                      },
                      staggeredTileBuilder: (index) =>
                      const StaggeredTile.fit(1)
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                //   child: Container(
                //       width: MediaQuery.of(context).size.width / 1.1,
                //       decoration: kBoxDecorationWithoutGradient,
                //       child: Padding(
                //         padding: const EdgeInsets.all(14.0),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             const Icon(Icons.how_to_vote_outlined),
                //             const SizedBox(height: 6),
                //             Text(
                //               'Voting Period',
                //               style: kSmallTextStyle,
                //             ),
                //             const SizedBox(height: 3),
                //             Text(
                //               '3/4',
                //               style: kBigTextStyle,
                //             )
                //           ],
                //         ),
                //       )),
                // ),
                isLoaded
                    ? Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 12),
                    child: Container(
                       // height: 350,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: kBoxDecorationWithoutGradient,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 18),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Blocks',
                                  style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Colors.black.withOpacity(.7),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                                ),
                                TextButton(
                                  onPressed: ()
                                  { Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              Blocks(
                                                  networkData:
                                                  widget.networkData)));
                                    toggleController.updateData(0);

                                    },
                                  child: const Text(
                                    'See more',
                                    style: TextStyle(
                                        decoration:
                                        TextDecoration.underline,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                            child: ListView.builder(
                              padding: EdgeInsets.all(0),
                                reverse: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: BlocksController
                                    .blockList.length <
                                    2
                                    ? BlocksController.blockList.length
                                    : 2,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return BlockContDash(
                                    blockModel: BlocksController
                                        .blockList.reversed.toList()[index],
                                  );
                                }),
                          ),
                          SizedBox(height:25)
                        ])))
                    : SizedBox(
                    height: 15,
                    width: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator()),
                    )),
                SizedBox(height:15),
                isLoaded
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
                  child: Container(
                    decoration: kBoxDecorationWithoutGradient,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 18),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Transactions',
                                style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: (){ Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Blocks(
                                            networkData:
                                            widget.networkData)));
                                toggleController.updateData(1);},
                                child: const Text(
                                  'See more',
                                  style: TextStyle(
                                      decoration:
                                      TextDecoration.underline,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                          child: ListView.builder(
                              reverse: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                              TxController.txList.length < 2
                                  ? TxController.txList.length
                                  : 2,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return TxContDash(
                                  txModel: TxController.txList[index],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        )):
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
        body:
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text('Coming Soon',

              style: kMediumBoldTextStyle,),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10,horizontal: 40),
              child: Text('This Explorer is currently active for Comdex chain only. ',textAlign: TextAlign.center,style: kSmallTextStyle),
            ),
          ],
        )));
  }
}

class BlockContDash extends StatelessWidget {
  final BlockModel? blockModel;
  const BlockContDash({Key? key, this.blockModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 8),
      child: Container(
        decoration: BoxDecoration (
          color:  Colors.white.withOpacity(.7),
          borderRadius: const BorderRadius.all(Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(-2, -2), // changes position of shadow
            ),],),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
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
                    '${new DateTime.now().toLocal().difference(blockModel!.timestamp!.toLocal()).inSeconds}secs ago',
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
                    '${dateTime(blockModel!.timestamp!.toLocal())} '
                        .toString(),
                    style: kSmallBoldTextStyle,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TxContDash extends StatefulWidget {
  final TxModel? txModel;
  TxContDash({Key? key, this.txModel}) : super(key: key);

  @override
  State<TxContDash> createState() => _TxContDashState();
}

class _TxContDashState extends State<TxContDash> {
  var timestampTx;
  var txLoaded = false;
  getData() async {
    final response = await http.get(Uri.parse(
        'https://meteor.rpc.comdex.one/block?height=${widget.txModel!.height!.toString()}'));
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body)['result']['block']['header']['time']);

      timestampTx =
      jsonDecode(response.body)['result']['block']['header']['time'];

      setState(() {
        if (timestampTx != null) {
          txLoaded = true;
        } else {
          print(response.statusCode);
          txLoaded = false;
        }
      });
    } else {
      // print(response.statusCode);
      // print('+errorr');
      // print('https://meteor.rpc.comdex.one/block?height=${widget.txModel!.height!.toString()}');
    }
  }

  var type = '';

  @override
  Widget build(BuildContext context) {
    getData();
    type = getType(widget.txModel!.messages![0].type!);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 8),
      child: Container(
        decoration: BoxDecoration (
          color:  Colors.white.withOpacity(.7),
          borderRadius: const BorderRadius.all(Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(-2, -2), // changes position of shadow
            ),],),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Clipboard.setData(ClipboardData(
                            text: widget.txModel!.hash!,
                          )).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Transaction Hash Copied to your clipboard !')));
                          }),
                          child: Row(
                            children: [
                              Text(dotRefactorFunction(widget.txModel!.hash!),
                                  style: kSmallBoldTextStyle),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.copy,
                                color: Colors.black54,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ]),
                  txLoaded
                      ? Text(
                    timeDifferenceFunction(timestampTx),
                    style: kSmallBoldTextStyle,
                  )
                      : SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator())
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Type',
                    style: kSmallTextStyle,
                  ),
                  Text(
                    type,
                    style: kSmallBoldTextStyle,
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time',
                    style: kSmallTextStyle,
                  ),
                  txLoaded
                      ? Text(
                    (dateTime(DateTime.parse(timestampTx).toLocal())),
                    style: kSmallBoldTextStyle,
                  )
                      : SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
