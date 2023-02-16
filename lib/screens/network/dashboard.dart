import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/backend_files/proposalsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/constants/functions.dart';
import 'package:zenscape_app/controller/dashboardController.dart';
import 'package:zenscape_app/controller/proposalsFunc.dart';
import 'package:zenscape_app/controller/toggleController.dart';
import 'package:zenscape_app/screens/network/proposalDetails.dart';
import '../../Screens/network/blockDetails.dart';
import '../../Screens/network/blocks.dart';
import '../../Screens/network/transactionDetails.dart';
import '../../backend_files/blocksModel.dart';
import '../../backend_files/txModel.dart';
import '../../constants/constString.dart';
import '../../controller/blocksController.dart';
import '../../controller/navController.dart';
import '../../controller/networklistController.dart';
import '../../controller/txController.dart';
import '../../widgets/navigationDrawerWidget.dart';
import '../../widgets/searchBarWidget.dart';
import '../homeScreen.dart';
import 'package:http/http.dart' as http;

class NetworkDashBoard extends StatefulWidget {
  final double? APR;
  final NetworkList? networkData;
  const NetworkDashBoard({this.networkData,this.APR});
  @override
  State<NetworkDashBoard> createState() => _NetworkDashBoardState();
}
class _NetworkDashBoardState extends State<NetworkDashBoard> {
  var details = ['0', '0', '0', '0', '0', '0'];
  final BlocksController _blocksController = Get.put(BlocksController());
  final NetworkController networkController = Get.put(NetworkController());
  final ProposalController proposalController = Get.put(ProposalController());
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final TxController _txController = Get.put(TxController());
  final ToggleController toggleController = Get.put(ToggleController());
  TextEditingController nameController = TextEditingController();
  NavController navController = Get.put(NavController());
  String fullName = '';
  var pageIndex = 0;
  var blockTime='0';
  var txNum;
  var bondedToken;
  var communityPool;
  var inflation = '';
  var height = '0';
  var bankTotal;
  var blocks;
  var tx;
  var blockDashList = [];
  var txDashList = [];
  double APR = 0;
  bool isLoaded = false;
  bool isProposalActive = false;
  var result;
  var timer;
  var epoch_provision;
  var curr_supply;
  List<BannerObject> banner=[];
  List<ProposalsModel>? activeProposal;
  List<ProposalsModel> activeProposalsList = [];
  String logoImage = '';
  void initstate() {
    super.initState();
    getData();
    navController.updatePage(1);
  }
  getData() async {
    result =
        await _blocksController.fetchBlocks(widget.networkData!.blocksUrl!);
    tx = await _txController.fetchTx(widget.networkData!.transactionsUrl!);
     banner=widget.networkData!.dashboardPageUrl!;
    txNum = (await _dashboardController.fetchdata(
        widget.networkData!.transaction!, 'count'));
    blockTime = (await _dashboardController.fetchdata(
        widget.networkData!.blocktime!, 'average_time'));
    bondedToken = await _dashboardController.fetchdata(
        widget.networkData!.bondedTokens!, 'bonded_tokens');
    inflation = (await _dashboardController.fetchdata(
        widget.networkData!.inflation!, 'value'));
    if(widget.networkData!.uDenom!='uosmo') {
      inflation = (await _dashboardController.fetchdata(
          widget.networkData!.inflation!, 'value'));
    }
    else{
      epoch_provision=await _dashboardController.fetchSingleData('https://lcd-osmosis.whispernode.com/osmosis/mint/v1beta1/epoch_provisions', 'epoch_provisions');
      curr_supply=await _dashboardController.fetchSingleData('https://api-osmosis.imperator.co/supply/v1/osmo', 'amount');
      inflation=(((double.parse(epoch_provision) * 365 + double.parse(curr_supply))/double.parse(curr_supply))/1000000).toString();
    }
    communityPool = await _dashboardController.fetchdata(
        widget.networkData!.communityPool!, 'coins');
    details = [
      BlocksController.blockList[BlocksController.blockList.length - 1].height!,
      txNum,
      k_m_b_generator(double.parse(bondedToken) / 1000000),
      k_m_b_generator((getValueFromBracket(findBracketByToken(communityPool,widget.networkData!.uDenom!)!)) / 1000000),
      '${truncateToDecimalPlaces(double.parse(inflation) * 100, 2)}%'
          .toString(),
     '${widget.APR!.toStringAsFixed(2)}%'
    ];

    blockDashList = [
      BlocksController.blockList[BlocksController.blockList.length - 1],
      BlocksController.blockList[BlocksController.blockList.length - 2]
    ];
    txDashList = [
      TxController.txList[TxController.txList.length - 1],
      TxController.txList[TxController.txList.length - 2]
    ];
    activeProposal = await proposalController
        .fetchProducts(widget.networkData!.proposalsUrl!);
    if (activeProposalsList.isEmpty)
      for (int i = 0; i < activeProposal!.length; i++) {
        if (activeProposal![i].status == 'PROPOSAL_STATUS_VOTING_PERIOD') {
          activeProposalsList.add(activeProposal![i]);
        }
        activeProposalsList.sort((b, a) => b.id!.compareTo(a.id!));
      }
      if (height!=0||txNum!=null||bondedToken!=null||blocks!=null) {
        setState(() {
          isLoaded = true;
        }
        );
      } else {
        isLoaded = false;
      }
      if (activeProposalsList.isNotEmpty) {
        isProposalActive = true;
      } else {
        isProposalActive = false;
      }
  }
  getDialogue(var result) {
    if (result['success'] == false) {
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
    return widget.networkData!.isActive == '1'
        ? Scaffold(
            drawer: NavDraw(
              networkData: widget.networkData,
              logoUrl:
                widget.networkData!.logUrl,
              pageIndex: pageIndex,
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
                        // onTap: () => Navigator.of(context)
                        //     .popUntil((route) => route.isFirst),
                        child: CachedNetworkImage(
                          imageUrl:
                              widget.networkData!.logUrl!,
                          height: 40,
                          width: 40,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      backgroundColor: Colors.transparent),
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
                    SearchBar(nameController: nameController,hintText: 'Enter Block Height, Tx Hash, Address..',networkList: widget.networkData!,),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: Container(
                          decoration: kBoxDecorationWithGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 15,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  widget.networkData!.logUrl!,
                                              height: 40,
                                              width: 40,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            backgroundColor:
                                                Colors.transparent),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            widget.networkData!.denom!,
                                            style: TextStyle(
                                                color:
                                                    Colors.black.withOpacity(1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    'MontserratRegular'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.access_time,color: Colors.blue.withOpacity(.8),
                                          size: 18,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Text(
                                              'BLOCK TIME ',
                                              style: kExtraSmallTextStyle,
                                            ),
                                          ),
                                           Text(
                                                  '${truncateToDecimalPlaces(
                                            double.parse(blockTime), 2).toString()} secs',
                                                  style:
                                                      kExtraSmallBoldTextStyle)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Price',style: kMediumTextStyle,),
                                      Row(
                                        children: [
                                          Text('\$'+'${widget.networkData!.price??'0'}',style: kMediumBoldTextStyle,),
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: double.parse(widget
                                                .networkData!
                                                .percChangeInPrice??'0') >
                                                0
                                                ? SvgPicture.asset(
                                                'assets/svgfiles/trending_up_FILL0_wght400_GRAD0_opsz48.svg',
                                                color: const Color(
                                                    0xFF15BE46))
                                                : SvgPicture.asset(
                                              'assets/svgfiles/trending_down_FILL0_wght400_GRAD0_opsz48.svg',
                                              color: Colors
                                                  .red
                                                  .withOpacity(
                                                  .8),
                                            ),),
                                          Text(
                                            ' (${truncateToDecimalPlaces(double.parse(widget.networkData!.percChangeInPrice ?? '0'), 2)}%)'
                                                .toString(),
                                            style: (double.parse(widget
                                                .networkData!
                                                .percChangeInPrice??'0') >
                                                0
                                                ? const TextStyle(
                                                color: Color(
                                                    0xFF15BE46))
                                                : const TextStyle(
                                                color: Colors
                                                    .red)),
                                          ),
                                        ],
                                      ),
                                    ],
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
                                                  '\$${k_m_b_generator(double.parse(widget.networkData!.marketCap??'0'))}',
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
                                              double.parse(widget.networkData!.the24HrVol??'0') >
                                                          0
                                                      ? Text(
                                                          '\$${truncateToDecimalPlaces(double.parse(widget.networkData!.the24HrVol!), 2).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                                          style: double.parse(widget.networkData!.the24HrVol!) > 0
                                                              ? const TextStyle(
                                                                  fontFamily:
                                                                      'MontserratBold',
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xFF15BE46))
                                                              : TextStyle(
                                                                  fontFamily:
                                                                      'MontserratBold',
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .red
                                                                      .withOpacity(
                                                                          .8)))
                                                      : Text(
                                                          '\$${addComma(truncateToDecimalPlaces((double.parse(widget.networkData!.the24HrVol??'0') * (-1)), 2).toString())}',
                                                          style: double.parse(widget.networkData!.the24HrVol??'0') > 0
                                                              ? const TextStyle(
                                                                  fontFamily:
                                                                      'MontserratBold',
                                                                  fontSize: 17,
                                                                  color:
                                                                      Color(0xFF15BE46))
                                                              :
                                                          TextStyle(
                                                              fontFamily:
                                                              'MontserratBold',
                                                              fontSize: 17,
                                                              color: Colors.red.withOpacity(.8)))
                                                  ,
                                              SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: double.parse(widget
                                                              .networkData!
                                                              .the24HrVol??'0') >
                                                          0
                                                      ? SvgPicture.asset(
                                                          'assets/svgfiles/trending_up_FILL0_wght400_GRAD0_opsz48.svg',
                                                          color: const Color(0xFF15BE46),
                                                  )
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
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: StaggeredGridView.countBuilder(
                          padding: EdgeInsets.zero,
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
                          },
                          staggeredTileBuilder: (index) =>
                              const StaggeredTile.fit(1)),
                    ),
                    banner.isNotEmpty? CarouselSlider.builder(
                        options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false),
                        itemCount: 2,
                        itemBuilder: (context, index, realIndex) {
                          final pngImage = banner[index].urlForBanner!;
                          return buildPngPicture(
                              pngImage,
                              index,
                              banner[index].urlForWebsite!,
                              context,
                              90);
                        }):Container(),
                    isProposalActive
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                                child: ListView.builder(

                                    // controller: _scrollController,
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: activeProposalsList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return ProposalCardDash(activeProposalsList.reversed
                                          .toList()[index],
                                          widget.networkData!,

                                         );
                                    })
                            )
                    )
                        : SizedBox(
                            height: .1,
                          ),
                    isLoaded
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 12),
                            child: Container(
                                // height: 350,
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithoutGradient,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 18),
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
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) => Blocks(
                                                    networkData:
                                                        widget.networkData,valDescUrl:widget.networkData!.blocksMoniker),
                                              ),
                                            );
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
                                            valDesc: widget.networkData!.blocksMoniker!,
                                            blockModel: blockDashList.reversed
                                                .toList()[index], networkList: widget.networkData!,
                                          );
                                        }),
                                  ),
                                  SizedBox(height: 25)
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
                            ),
                          ),
                    SizedBox(height: 15),
                    isLoaded
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
                            child: Container(
                              decoration: kBoxDecorationWithoutGradient,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        18.0, 4, 18, 0),
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        Blocks(
                                                            networkData: widget
                                                                .networkData)));
                                            toggleController.updateData(1);
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
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 8, 8, 30),
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
                                            networkList: widget.networkData!,
                                            txModel: txDashList.reversed
                                                .toList()[index],
                                            heightSearchUrl: widget.networkData!.txTimestamp,
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
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Coming Soon',
                    style: kMediumBoldTextStyle,
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    child: Text(
                        'This Explorer is currently active for Comdex chain only. ',
                        textAlign: TextAlign.center,
                        style: kSmallTextStyle),
                  ),
                ],
              ),
            ),
          );
  }
}

class BlockContDash extends StatelessWidget {
  final BlockModel? blockModel;
  final String valDesc;
  final NetworkList networkList;
  const BlockContDash({Key? key, this.blockModel,required this.valDesc,required this.networkList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => BlockDetails(
                valDesc:valDesc,
                blockModel: blockModel,
                networkList:networkList
                  ))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.7),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.05),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(-2, -2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
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
                              text: blockModel!.height!,
                            )).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Block Height Copied to your clipboard!')));
                            }),
                            child: Row(
                              children: [
                                Text(addComma(blockModel!.height!),
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
                    Text(timeDifferenceFunction(blockModel!.timestamp!.toString()),
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
      ),
    );
  }
}

class TxContDash extends StatefulWidget {
  final TxModel? txModel;
  final String? heightSearchUrl;
  NetworkList networkList;
  TxContDash({Key? key, this.txModel,this.heightSearchUrl,required this.networkList}) : super(key: key);

  @override
  State<TxContDash> createState() => _TxContDashState();
}

class _TxContDashState extends State<TxContDash> {
  var timestampTx;
  var txLoaded = false;

  getData() async {
    final response = await http.get(Uri.parse(
        '${widget.networkList.txTimestamp}${widget.txModel!.height!.toString()}'));
    if (response.statusCode == 200) {
      timestampTx =
          jsonDecode(response.body)['result']['block']['header']['time'];
      setState(() {
        if (timestampTx != null) {
          txLoaded = true;
        } else {
          txLoaded = false;
        }
      });
    } else {}
  }
  var type = '';
  @override
  Widget build(BuildContext context) {
    getData();
    type = truncateBeforeLastDot(widget.txModel!.messages![0].type!);
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => TxDetails(txModel: widget.txModel,networkList:widget.networkList, heightSearchUrl: '',))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.7),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.05),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(-2, -2), // changes position of shadow
              ),
            ],
          ),
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
                   widget.networkList.uDenom==''? Container():Row(
                          children: [
                            txLoaded
                                ? Text(
                                timeDifferenceFunction(timestampTx).toString(),
                                style: kSmallBoldTextStyle,
                              ) : SizedBox(
                                height: 15,
                                width: 15,
                                child: Container()),
                          ],
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
                widget.networkList.uDenom!=''? Row(
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
                            child: Container())
                  ],
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProposalCardDash extends StatelessWidget {
  final ProposalsModel product;
  NetworkList networkList;
  ProposalCardDash(this.product, this.networkList);
  var status = '';
  bool ispassed = true;

  @override
  Widget build(BuildContext context) {
    // fun();
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ProposalDetails(
                    proposalProduct: product,networkData:networkList
                  ))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            margin: EdgeInsets.all(4),
            decoration: kBoxDecorationWithoutGradient,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 15,
                          child:
                              Image.asset('assets/images/votingPeriod.png')),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(200.0),
                            ),
                            color: Color(0xFFD4F1FF)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child:
                              Text('#${product.id!}', style: kSmallTextStyle),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('Voting Period'),
                  SizedBox(height: 12),
                  Text(
                    '${product.title!} ',
                    style: kMediumBoldTextStyle,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
