import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:simple_rich_text/simple_rich_text.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/txModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zenscape_app/constants/functions.dart';
import 'package:zenscape_app/screens/network/searchDetailsScreen.dart';
import '../../backend_files/networkList.dart';
import '../../controller/txToggleController.dart';
import '../../widgets/searchBarWidget.dart';

class TxDetails extends StatefulWidget {
  final TxModel? txModel;
  var txTime;
  String? heightSearchUrl;
  NetworkList networkList;
  TxDetails(
      {Key? key,
      this.txModel,
      this.txTime,
      this.heightSearchUrl,
      required this.networkList})
      : super(key: key);
  @override
  State<TxDetails> createState() => _TxDetailsState();
}

class _TxDetailsState extends State<TxDetails> {
  var raw;
  var isLoaded;
  int summarySelected = 0;

  @override
  void initState() {
    super.initState();

    getData();
  }

  TextEditingController nameController = TextEditingController();

  final TxToggleController txToggleController = Get.put(TxToggleController());
  var type;
  var timestampTx;
  var txLoaded = false;
  var response;

  getData() async {
    response = await http.get(Uri.parse(
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

  @override
  Widget build(BuildContext context) {
    type = getType(widget.txModel!.messages![0].type!);
    //toggleController.updateData(0);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Details',
              style: kBigBoldTextStyle,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SearchBar(
            nameController: nameController,
            hintText: 'Enter Block Height,Tx hash, Address..',
            networkList: widget.networkList,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GetBuilder<TxToggleController>(builder: (txToggleController) {
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
                    initialLabelIndex:
                        txToggleController.isBlockSelected == 0 ? 0 : 1,
                    totalSwitches: 2,
                    labels: const ['Summary', 'JSON'],
                    radiusStyle: true,
                    onToggle: (index) {
                      summarySelected = index!;
                      txToggleController.updateData(index);
                    },
                  );
                })
              ],
            ),
          ),
          GetBuilder<TxToggleController>(builder: (txToggleController) {
            return txToggleController.isBlockSelected == 0
                ? Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(right: 10, top: 10, left: 10),
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: kBoxDecorationWithGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Information',
                                    style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Text('Chain Id', style: kSmallTextStyle),
                                // const SizedBox(
                                //   height: 2,
                                // ),
                                // Text('comdex-1', style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Type', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                    truncateBeforeLastDot(
                                        widget.txModel!.messages![0].type ??
                                            ''),
                                    style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Tx Hash',
                                    textAlign: TextAlign.start,
                                    style: kMediumTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                InkWell(
                                  onTap: () =>
                                      PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: SearchScreen(
                                      nameController: widget.txModel!.hash!,
                                      networkList: widget.networkList,
                                    ),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  ),
                                  child: Text(widget.txModel!.hash ?? '',
                                      style: kMediumBlueBoldTextStyle),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Status', style: kSmallTextStyle),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                    widget.txModel!.success == true
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
                                InkWell(
                                  onTap: () =>
                                      PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: SearchScreen(
                                      nameController: widget.txModel!.height!,
                                      networkList: widget.networkList,
                                    ),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  ),
                                  child: Text(
                                      addComma(widget.txModel!.height ?? ''),
                                      style: kMediumBlueBoldTextStyle),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                widget.networkList.uDenom == ''
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Time', style: kSmallTextStyle),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          txLoaded
                                              ? Text(
                                                  '${dateTime(DateTime.parse(timestampTx).toLocal())} (${timeDifferenceFunction(timestampTx)})',
                                                  style: kMediumBoldTextStyle)
                                              : SizedBox(
                                                  height: 10,
                                                  width: 15,
                                                  child: Container()),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),

                                Text('Status', style: kMediumTextStyle),
                                const SizedBox(
                                  width: 70,
                                ),
                                Text(
                                    widget.txModel!.success == true
                                        ? 'Success'
                                        : 'Fail',
                                    style: TextStyle(
                                      fontFamily: 'MontserratRegular',
                                      color: widget.txModel!.success == true
                                          ? Colors.green
                                          : Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Fee', style: kSmallTextStyle),
                                const SizedBox(height: 2),
                                widget.txModel!.fee!.amount!.length != 0
                                    ? Text(
                                        '${addComma(widget.txModel!.fee!.amount![0].amount!)} ${widget.txModel!.fee!.amount![0].denom!}',
                                        style: kMediumBoldTextStyle)
                                    : Text('0', style: kMediumBoldTextStyle),
                                const SizedBox(height: 20),
                                Text('Gas (used/wanted)',
                                    style: kSmallTextStyle),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                    '${addComma(widget.txModel!.gasUsed!)} / ${addComma(widget.txModel!.gasWanted!)} ${(widget.networkList.uDenom)}',
                                    style: kMediumBoldTextStyle),
                                const SizedBox(
                                  height: 20,
                                ),
                                widget.txModel!.memo!.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Memo', style: kSmallTextStyle),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(widget.txModel!.memo!,
                                              style: kMediumBoldTextStyle),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ]),
                        ),
                      ),

                      //auction
                      if (type == 'Place Surplus Bid Request')
                        Container()
                      else if (type == 'Place Debt Bid Request')
                        Container()
                      else if (type == 'Place Dutch Lend Bid Request')
                        Container()
                      else if (type == 'Fetch Price Data Response')
                        Container()
                      //ESM
                      else if (type == 'Deposit ESM Response')
                        Container()
                      else if (type == 'Execute ESM Response')
                        Container()
                      else if (type == 'Kill Response')
                        Container()
                      else if (type == 'Collateral Redemption Response')
                        Container()
                      //Lend
                      else if (type == 'Lend')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0].amount
                                                        .amount +
                                                    ' ' +
                                                    widget.txModel!.messages![0]
                                                        .amount.denom ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pool ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Asset ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .assetId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Lender', style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Lender Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .lender ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Withdraw Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages![0].poolCoins !=
                                            null
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolCoins!.amount! +
                                                ' ' +
                                                widget.txModel!.messages![0]
                                                    .poolCoins!.denom!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pool ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Withdrawer',
                                            style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .withDrawer ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Withdrawer Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .lender ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Deposit Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Deposit Coins',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    // widget.txModel!.messages![0].depositCoins != null
                                    //     ?
                                    for (int i = 0;
                                        i <
                                            widget.txModel!.messages![0]
                                                .depositCoins!.length;
                                        i++)
                                      Column(
                                        children: [
                                          Text(
                                              addComma(widget
                                                      .txModel!
                                                      .messages![0]
                                                      .depositCoins![i]
                                                      .amount!) +
                                                  '  ' +
                                                  widget.txModel!.messages![0]
                                                      .depositCoins![i].denom!,
                                              style: kMediumBoldTextStyle),
                                          SizedBox(height: 20)
                                        ],
                                      ),
                                    // : Text(''),

                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pool ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Depositor',
                                            style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Depositor Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Close Lend Response')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Lend ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .lendId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Lender', style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .lender ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Lender Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .lender ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Borrow Response')
                        Container()
                      else if (type == 'Repay Response')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .amount ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('User Vault Id',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .userVaultId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .extendedPairVaultId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Deposit Borrow Response')
                        Container()
                      else if (type == 'Draw Response')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0].amount
                                                        .amount ??
                                                    '') +
                                                ' ' +
                                                (widget.txModel!.messages![0]
                                                        .amount.denom ??
                                                    ''),
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Borrower', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget.txModel!
                                                .messages![0].borrower ??
                                            '',
                                        copyTextName: 'Borrower'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Borrow Id', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .borrowId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Close Borrow Response')
                        Container()
                      else if (type == 'Borrow Alternate Response')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount In', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                        .amountIn.amount ??
                                                    '') +
                                                ' ' +
                                                (widget.txModel!.messages![0]
                                                        .amountIn.denom ??
                                                    ''),
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Amount Out', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                        .amountOut.amount ??
                                                    '') +
                                                '  ' +
                                                (widget.txModel!.messages![0]
                                                        .amountOut.denom ??
                                                    ''),
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Lender', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!.messages![0].lender ??
                                            '',
                                        copyTextName: 'Lender'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App Id', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pair Id', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .pairId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pool Id', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Asset Id', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .assetId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Fund Module Accounts Response')
                        Container()
                      else if (type == 'Calculate Interest And Rewards')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Borrower', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget.txModel!
                                                .messages![0].borrower ??
                                            '',
                                        copyTextName: 'Borrower'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))

                      //liquidation
                      else if (type == 'Liquidate Vault Response')
                        Container()
                      else if (type == 'Liquidate Borrow Response')
                        Container()
                      //liquidity
                      else if (type == 'Create Pair')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        getType(
                                            widget.txModel!.messages![0].type!),
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty ?
                                    // Text(widget.txModel!.messages![0].offerCoin!.amount ?? '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('Creator', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                .txModel!.messages![0].creator!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0].appId!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Base Coin Denom',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .baseCoinDenom!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Quote Coin Denom',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .quoteCoinDenom!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Create Pool')
                        Container()
                      else if (type == 'Deposit')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            '${widget.txModel!.messages![0].depositCoins![0].amount.toString()} ${widget.txModel!.messages![0].depositCoins![0].denom.toString()}',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pool ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Depositor',
                                            style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Depositor Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Withdraw')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            '${widget.txModel!.messages![0].poolCoins!.amount.toString()} ${widget.txModel!.messages![0].poolCoins!.denom.toString()}',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pool ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Withdrawer',
                                            style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .withDrawer ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Depositor Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .withDrawer ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Limit Order')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        getType(
                                            widget.txModel!.messages![0].type!),
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Price', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            truncateToDecimalPlaces(
                                                    double.parse(widget.txModel!
                                                        .messages![0].price!),
                                                    2)
                                                .toString(),
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty || widget.txModel!.messages![0].amount!.isNotEmpty?
                                    // Text(widget.txModel!.messages![0].amount![0].amount ?? '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('Orderer', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                .txModel!.messages![0].orderer!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pair ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                .txModel!.messages![0].pairId!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Direction', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .direction!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Order Lifespan',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .orderLifespan!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Demand Coin Denom',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .demandCoinDenom!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Market Order')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        getType(
                                            widget.txModel!.messages![0].type!),
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty ?
                                    // Text(widget.txModel!.messages![0].offerCoin!.amount ?? '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('Orderer', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                .txModel!.messages![0].orderer!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0].appId!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pair ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                .txModel!.messages![0].pairId!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Direction', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .direction!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Order Lifespan',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .orderLifespan!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Offer Coin', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            '${widget.txModel!.messages![0].offerCoin!.amount ?? ''}'
                                            ' ${widget.txModel!.messages![0].offerCoin!.denom ?? ''}',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Demand Coin Denom',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .demandCoinDenom!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Cancel Order')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        getType(
                                            widget.txModel!.messages![0].type!),
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty ?
                                    // Text(widget.txModel!.messages![0].offerCoin!.amount ?? '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('Orderer', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                .txModel!.messages![0].orderer!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0].appId!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pair ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                .txModel!.messages![0].pairId!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Order ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                .txModel!.messages![0].orderId!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Cancel ALl Orders')
                        Container()
                      else if (type == 'Farm')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            '${widget.txModel!.messages![0].farmingPoolCoin!.amount.toString()} ${widget.txModel!.messages![0].farmingPoolCoin!.denom.toString()}',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pool ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Farmer', style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .farmer ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Farmer Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .farmer ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'UnFarm')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(height: 20),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(height: 2),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            '${widget.txModel!.messages![0].unfarmingPoolCoin!.amount.toString()} ${widget.txModel!.messages![0].unfarmingPoolCoin!.denom.toString()}',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pool ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Farmer', style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .farmer ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Farmer Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .farmer ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))

                      //locker
                      else if (type == 'Create Locker Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amount??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Asset ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .assetId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Depositor Address',
                                            style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Depositor Address Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Deposit Asset Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amount??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Asset ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .assetId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Locker ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .lockerId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Depositor Address',
                                            style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Depositor Address Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Withdraw Asset Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amount??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Asset ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .assetId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Locker ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .lockerId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Depositor Address',
                                            style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Depositor Address Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Close Locker Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amount??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Asset ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .assetId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Locker ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .lockerId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text('Depositor Address',
                                            style: kSmallTextStyle),
                                        InkWell(
                                          onTap: () =>
                                              Clipboard.setData(ClipboardData(
                                            text: widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                          )).then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Depositor Address Copied to your clipboard !')));
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
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .depositor ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Locker Reward Calc Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('From', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .address!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amount??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('Locker ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .lockerId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))

                      //rewards
                      else if (type == 'Create Gauge')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Start Time', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            dateTime(widget.txModel!
                                                .messages![0].startTime!),
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Gauge Type ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                .gaugeTypeId!),
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Total Deposit Amount',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .depositAmount!.amount ??
                                                '' +
                                                    ' ' +
                                                    widget.txModel!.messages![0]
                                                        .depositAmount!.denom!,
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Total Triggers ',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .totalTriggers ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Triggers Duration',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .triggerDuration ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Liquidity Metadata Pool ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget
                                                    .txModel!
                                                    .messages![0]
                                                    .liquidityMetaData!
                                                    .poolId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Is Master Pool',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                .liquidityMetaData!.isMasterPool
                                                .toString(),
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Activate External Rewards Lockers')
                        Container()
                      else if (type == 'Activate External Rewards Vault')
                        Container()
                      else if (type == 'Activate External Rewards Lend')
                        Container()

                      //tokenMint
                      else if (type == 'Mint New Tokens Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))

                      //vault
                      else if (type == 'Create Response')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .extendedPairVaultId!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Amount In', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .amountIn ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Amount Out', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .amountOut ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Deposit Response')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('User Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .userVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amountIn??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Withdraw Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('User Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .userVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amountIn??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Draw Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('User Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .userVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .amount ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextName: 'From Address',
                                        copyTextValue: widget.txModel!
                                                .messages![0].address ??
                                            ''),
                                  ]),
                            ))
                      else if (type == 'Repay Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('User Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .userVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amountIn??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Close Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('User Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .userVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amountIn??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Deposit And Draw Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('User Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .userVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amountIn??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Create Stable Mint Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Text('User Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .userVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amountIn??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),s
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Deposit Stable Mint Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Withdraw Stable Mint Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Extended Pair Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .extendedPairVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Stable Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .stableVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Vault Interest Calc Request')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('User Vault ID',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            (widget.txModel!.messages![0]
                                                    .userVaultId) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Text('Amount', style: kSmallTextStyle),
                                    // const SizedBox(
                                    //   height: 2,
                                    // ),
                                    // widget.txModel!.messages!.isNotEmpty?Text(
                                    //     widget.txModel!.messages![0].amountIn??
                                    //         '',
                                    //     style: kMediumBoldTextStyle):Text(''),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('App ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .appId ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('From Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            widget.txModel!.messages![0]
                                                    .address ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))

                      //cosmos
                      //authz
                      else if (type == 'Grant')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Grantee ', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0].grantee ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Granter', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0].granter ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Authorisation Type',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget
                                                .txModel!
                                                .messages![0]
                                                .grant!
                                                .authorization!
                                                .authorizationType ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Expiration', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        dateTime(widget.txModel!.messages![0]
                                            .grant!.expiration!),
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Max Tokens', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        (widget.txModel!.messages![0].grant!
                                            .authorization!.maxTokens
                                            .toString()),
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Revoke')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Grantee ', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                      copyTextValue: widget
                                              .txModel!.messages![0].grantee ??
                                          '',
                                      copyTextName: 'Grantee Address',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Granter', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                      copyTextValue: widget
                                              .txModel!.messages![0].granter ??
                                          '',
                                      copyTextName: 'Granter Address',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Msg Type URL',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0]
                                                .msgTypeUrl ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      //bank
                      else if (type == 'Send')
                        widget.txModel!.messages!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        widget.txModel!.messages!.isNotEmpty
                                            ? Text(
                                                getType(widget.txModel!
                                                        .messages![0].type!) ??
                                                    '',
                                                style: kMediumBoldTextStyle)
                                            : Text(''),
                                        const SizedBox(height: 20),
                                        Text('Amount', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            '${widget.txModel!.messages![0].amount![0].amount.toString()} ${widget.txModel!.messages![0].amount![0].denom.toString()}',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('To Address ',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget.txModel!
                                                    .messages![0].toAddress ??
                                                '',
                                            copyTextName: 'Address'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('From Address',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget.txModel!
                                                    .messages![0].fromAddress ??
                                                '',
                                            copyTextName: 'Address'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                ))
                            : Container()

                      //distribution
                      else if (type == 'Set Withdraw Address')
                        widget.txModel!.messages!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        widget.txModel!.messages!.isNotEmpty
                                            ? Text(
                                                getType(widget.txModel!
                                                        .messages![0].type!) ??
                                                    '',
                                                style: kMediumBoldTextStyle)
                                            : Text(''),
                                        const SizedBox(height: 20),
                                        Text('Withdraw Address ',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                    .txModel!
                                                    .messages![0]
                                                    .withdrawAddress ??
                                                '',
                                            copyTextName: 'Address'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Delegator Address',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                    .txModel!
                                                    .messages![0]
                                                    .delegatorAddress ??
                                                '',
                                            copyTextName: 'Address'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                ))
                            : Container()
                      else if (type == 'Withdraw Delegator Reward')
                        widget.txModel!.messages!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        widget.txModel!.messages!.isNotEmpty
                                            ? Text(
                                                getType(widget.txModel!
                                                        .messages![0].type!) ??
                                                    '',
                                                style: kMediumBoldTextStyle)
                                            : Text(''),
                                        const SizedBox(height: 20),
                                        Text('Validator Address ',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                    .txModel!
                                                    .messages![0]
                                                    .validatorAddress ??
                                                '',
                                            copyTextName: 'Address'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Delegator Address',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                    .txModel!
                                                    .messages![0]
                                                    .delegatorAddress ??
                                                '',
                                            copyTextName: 'Address'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                ))
                            : Container()
                      else if (type == 'Withdraw Validator Commission')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Validator Address ',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!
                                                .messages![0]
                                                .validatorAddress ??
                                            '',
                                        copyTextName: 'Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Delegator Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!
                                                .messages![0]
                                                .delegatorAddress ??
                                            '',
                                        copyTextName: 'Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))

                      //gov
                      else if (type == 'Submit Proposal')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Proposal Type ',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0].content!
                                                .type ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Proposer', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget.txModel!
                                                .messages![0].proposer ??
                                            '',
                                        copyTextName: 'Proposer'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Description', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    SimpleRichText(
                                        formatString(widget
                                                .txModel!
                                                .messages![0]
                                                .content!
                                                .description ??
                                            ''),
                                        style: kSmallTextStyle),
                                  ]),
                            ))
                      else if (type == 'Vote')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Proposal ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0]
                                                .proposalId ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Option', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0].option ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Voter', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!.messages![0].voter ??
                                            '',
                                        copyTextName: 'Voter'),
                                  ]),
                            ))
                      else if (type == 'Vote Weighted')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Proposal ID', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0]
                                                .proposalId ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Option', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0].option ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Voter', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!.messages![0].voter ??
                                            '',
                                        copyTextName: 'Voter'),
                                  ]),
                            ))
                      //staking
                      else if (type == 'Create Validator')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Value', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0].value!
                                                .amount ??
                                            '' +
                                                '  ' +
                                                '${widget.txModel!.messages![0].value!.denom!}',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Moniker', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!
                                                .messages![0]
                                                .description!
                                                .moniker ??
                                            '',
                                        copyTextName: 'Proposer'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Commission Rate',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        (double.parse(widget
                                                            .txModel!
                                                            .messages![0]
                                                            .commission!
                                                            .rate ??
                                                        '0') *
                                                    100)
                                                .toString() +
                                            '%',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Description', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0]
                                                .description!.details ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pub Key', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages![0].pubkey != null
                                        ? SimpleRichText(
                                            formatString(widget.txModel!
                                                    .messages![0].pubkey!.key ??
                                                ''),
                                            style: kMediumBoldTextStyle)
                                        : Container(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Validator Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: (widget
                                                .txModel!
                                                .messages![0]
                                                .validatorAddress ??
                                            ''),
                                        copyTextName: 'Validator Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Delegator Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: (widget
                                                .txModel!
                                                .messages![0]
                                                .delegatorAddress ??
                                            ''),
                                        copyTextName: 'Delegator Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Edit Validator')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Details', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0]
                                                .description!.details ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Moniker', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!
                                                .messages![0]
                                                .description!
                                                .moniker ??
                                            '',
                                        copyTextName: 'Proposer'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Commission Rate',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0]
                                            .commissionRate
                                            .toString(),
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Identity', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        widget.txModel!.messages![0]
                                                .description!.identity ??
                                            '',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Pub Key', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages![0].pubkey != null
                                        ? SimpleRichText(
                                            formatString(widget.txModel!
                                                    .messages![0].pubkey!.key ??
                                                ''),
                                            style: kMediumBoldTextStyle)
                                        : Container(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Validator Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: (widget
                                                .txModel!
                                                .messages![0]
                                                .validatorAddress ??
                                            ''),
                                        copyTextName: 'Validator Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Min Self Delegation',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        (widget.txModel!.messages![0]
                                                .minSelfDelegation ??
                                            ''),
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Execute')
                        for (int i = 0;
                            i < widget.txModel!.messages![0].msgs!.length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Delegate',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        widget.txModel!.messages!.isNotEmpty
                                            ? Text(
                                                getType(widget
                                                        .txModel!
                                                        .messages![0]
                                                        .msgs![i]
                                                        .type!
                                                        .toString()) ??
                                                    '',
                                                style: kMediumBoldTextStyle)
                                            : Text(''),
                                        const SizedBox(height: 20),
                                        Text('Amount', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            (widget
                                                        .txModel!
                                                        .messages![0]
                                                        .msgs![i]
                                                        .amount!
                                                        .amount ??
                                                    '') +
                                                (' ') +
                                                (widget
                                                        .txModel!
                                                        .messages![0]
                                                        .msgs![i]
                                                        .amount!
                                                        .denom ??
                                                    ''),
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Validator Address',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                    .txModel!
                                                    .messages![0]
                                                    .msgs![i]
                                                    .validatorAddress ??
                                                '',
                                            copyTextName: 'Validator Address'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Delegator Address',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                    .txModel!
                                                    .messages![0]
                                                    .msgs![i]
                                                    .delegatorAddress ??
                                                '',
                                            copyTextName: 'Delegator Address'),
                                      ]),
                                )),
                          )
                      else if (type == 'Begin Redelegate')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        addComma(widget.txModel!.messages![0]
                                                .amount.amount) +
                                            " " +
                                            widget.txModel!.messages![0].amount
                                                .denom,
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Delegator Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget.txModel!
                                            .messages![0].delegatorAddress!,
                                        copyTextName: 'Delegator Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Validator DST Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!
                                                .messages![0]
                                                .validatorDstAddress ??
                                            '',
                                        copyTextName: 'Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Validator SRC Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget
                                                .txModel!
                                                .messages![0]
                                                .validatorSrcAddress ??
                                            '',
                                        copyTextName: 'Address'),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ]),
                            ))
                      else if (type == 'Delegate')
                        Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, left: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: kBoxDecorationWithGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Message',
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Type', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.txModel!.messages!.isNotEmpty
                                        ? Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle)
                                        : Text(''),
                                    const SizedBox(height: 20),
                                    Text('Amount', style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        addComma(widget.txModel!.messages![0]
                                                .amount.amount) +
                                            " " +
                                            widget.txModel!.messages![0].amount
                                                .denom,
                                        style: kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Delegator Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: widget.txModel!
                                            .messages![0].delegatorAddress!,
                                        copyTextName: 'Delegator Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Validator Address',
                                        style: kSmallTextStyle),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextWithCopyIcon(
                                        copyTextValue: (widget
                                                .txModel!
                                                .messages![0]
                                                .validatorAddress ??
                                            ''),
                                        copyTextName: 'Validator Address'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                      else if (type == 'Update Client')
                        widget.txModel!.messages!.isNotEmpty
                            ? Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 10, left: 10),
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: kBoxDecorationWithGradient,
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Message',
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Type',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  getType(widget
                                                          .txModel!
                                                          .messages![0]
                                                          .type!) ??
                                                      '',
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(height: 20),
                                              Text('Header',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  (widget.txModel!.messages![0]
                                                          .header!.type) ??
                                                      '',
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(height: 20),
                                              Text('Signer',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              TextWithCopyIcon(
                                                copyTextValue: widget.txModel!
                                                        .messages![0].signer ??
                                                    '',
                                                copyTextName: 'Signer',
                                              ),
                                              const SizedBox(height: 20),
                                              Text('Client ID',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  widget.txModel!.messages![0]
                                                          .clientId ??
                                                      '',
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Height',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  widget
                                                          .txModel!
                                                          .messages![0]
                                                          .header!
                                                          .signedHeader!
                                                          .header!
                                                          .height ??
                                                      '',
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Time',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  dateTime(widget
                                                      .txModel!
                                                      .messages![0]
                                                      .header!
                                                      .signedHeader!
                                                      .header!
                                                      .time!),
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Hash',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  (widget
                                                          .txModel!
                                                          .messages![0]
                                                          .header!
                                                          .signedHeader!
                                                          .header!
                                                          .lastBlockId!
                                                          .partSetHeader!
                                                          .hash ??
                                                      ''),
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Consensus Hash',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  (widget
                                                          .txModel!
                                                          .messages![0]
                                                          .header!
                                                          .signedHeader!
                                                          .header!
                                                          .consensusHash ??
                                                      ''),
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Validator Hash',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  (widget
                                                          .txModel!
                                                          .messages![0]
                                                          .header!
                                                          .signedHeader!
                                                          .header!
                                                          .validatorsHash ??
                                                      ''),
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Last Commit Hash',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  (widget
                                                          .txModel!
                                                          .messages![0]
                                                          .header!
                                                          .signedHeader!
                                                          .header!
                                                          .lastCommitHash ??
                                                      ''),
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Proposer Address',
                                                  style: kSmallTextStyle),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  (widget
                                                          .txModel!
                                                          .messages![0]
                                                          .header!
                                                          .signedHeader!
                                                          .header!
                                                          .proposerAddress ??
                                                      ''),
                                                  style: kMediumBoldTextStyle),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ]),
                                      )),
                                  widget.txModel!.messages!.length > 1
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              right: 10, top: 10, left: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          decoration:
                                              kBoxDecorationWithGradient,
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('IBC Acknowledgement',
                                                      style:
                                                          kMediumBoldTextStyle),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text('Sequence',
                                                      style: kSmallTextStyle),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                      getType(widget
                                                              .txModel!
                                                              .messages![1]
                                                              .packet!
                                                              .sequence!) ??
                                                          '',
                                                      style:
                                                          kMediumBoldTextStyle),
                                                  const SizedBox(height: 20),
                                                  Text('Source Port',
                                                      style: kSmallTextStyle),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                      widget
                                                              .txModel!
                                                              .messages![1]
                                                              .packet!
                                                              .sourcePort ??
                                                          '',
                                                      style:
                                                          kMediumBoldTextStyle),
                                                  const SizedBox(height: 20),
                                                  Text('Source Channel',
                                                      style: kSmallTextStyle),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                      widget
                                                              .txModel!
                                                              .messages![1]
                                                              .packet!
                                                              .sourceChannel ??
                                                          '',
                                                      style:
                                                          kMediumBoldTextStyle),
                                                  const SizedBox(height: 20),
                                                  Text('Destination Port',
                                                      style: kSmallTextStyle),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                      widget
                                                              .txModel!
                                                              .messages![1]
                                                              .packet!
                                                              .destinationPort ??
                                                          '',
                                                      style:
                                                          kMediumBoldTextStyle),
                                                  const SizedBox(height: 20),
                                                  Text('Destination Channel',
                                                      style: kSmallTextStyle),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                      widget
                                                              .txModel!
                                                              .messages![1]
                                                              .packet!
                                                              .destinationChannel ??
                                                          '',
                                                      style:
                                                          kMediumBoldTextStyle),
                                                  const SizedBox(height: 20),
                                                ]),
                                          ))
                                      : Container(),
                                ],
                              )
                            : Container()
                      else if (type == 'Swap Exact Amount In')
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Pool ID', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            (widget.txModel!.messages![0]
                                                    .routes![0].poolId) ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Token Out Denom',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            '${widget.txModel!.messages![0].routes![0].tokenOutDenom}',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Sender', style: kMediumTextStyle),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                .txModel!.messages![0].sender!,
                                            copyTextName: 'Sender'),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        const SizedBox(height: 20),
                                        Text('Token In',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            '${addComma(widget.txModel!.messages![0].tokenIn!.amount!)}' +
                                                '  ${addComma(widget.txModel!.messages![0].tokenIn!.denom!)}',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                )),
                            widget.txModel!.messages!.length > 1
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 10, left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    decoration: kBoxDecorationWithGradient,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('IBC Acknowledgement',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text('Sequence',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                getType(widget
                                                        .txModel!
                                                        .messages![1]
                                                        .packet!
                                                        .sequence!) ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                            Text('Source Port',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                widget.txModel!.messages![1]
                                                        .packet!.sourcePort ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                            Text('Source Channel',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                widget
                                                        .txModel!
                                                        .messages![1]
                                                        .packet!
                                                        .sourceChannel ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                            Text('Destination Port',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                widget
                                                        .txModel!
                                                        .messages![1]
                                                        .packet!
                                                        .destinationPort ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                            Text('Destination Channel',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                widget
                                                        .txModel!
                                                        .messages![1]
                                                        .packet!
                                                        .destinationChannel ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                          ]),
                                    ))
                                : Container(),
                          ],
                        )
                      else if (type == 'Swap Exact Amount Out')
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Pool ID', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            (widget.txModel!.messages![0]
                                                    .routes![0].poolId) ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Token In Denom',
                                            style: kSmallTextStyle),
                                        const SizedBox(height: 2),
                                        Text(
                                            '${widget.txModel!.messages![0].routes![0].tokenInDenom}',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Sender', style: kMediumTextStyle),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                .txModel!.messages![0].sender!,
                                            copyTextName: 'Sender'),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        const SizedBox(height: 20),
                                        Text('Token Out',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            '${addComma(widget.txModel!.messages![0].tokenOut!.amount!)}' +
                                                '\n${addComma(widget.txModel!.messages![0].tokenOut!.denom!)}',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                )),
                            widget.txModel!.messages!.length > 1
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 10, left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    decoration: kBoxDecorationWithGradient,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('IBC Acknowledgement',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text('Sequence',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                getType(widget
                                                        .txModel!
                                                        .messages![1]
                                                        .packet!
                                                        .sequence!) ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                            Text('Source Port',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                widget.txModel!.messages![1]
                                                        .packet!.sourcePort ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                            Text('Source Channel',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                widget
                                                        .txModel!
                                                        .messages![1]
                                                        .packet!
                                                        .sourceChannel ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                            Text('Destination Port',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                widget
                                                        .txModel!
                                                        .messages![1]
                                                        .packet!
                                                        .destinationPort ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                            Text('Destination Channel',
                                                style: kSmallTextStyle),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                widget.txModel!.messages![1].packet!.destinationChannel ??
                                                    '',
                                                style: kMediumBoldTextStyle),
                                            const SizedBox(height: 20),
                                          ]),
                                    ))
                                : Container(),
                          ],
                        )
                      else if (type == 'Join Pool')
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Pool ID', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            widget
                                                .txModel!.messages![0].poolId!,
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Token In Maxs',
                                            style: kSmallTextStyle),
                                        const SizedBox(height: 2),
                                        Text(
                                            addComma(widget
                                                    .txModel!
                                                    .messages![0]
                                                    .tokenInMaxs![0]
                                                    .amount!) +
                                                '  ' +
                                                widget.txModel!.messages![0]
                                                    .tokenInMaxs![0].denom!,
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Sender', style: kMediumTextStyle),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                .txModel!.messages![0].sender!,
                                            copyTextName: 'Sender'),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        const SizedBox(height: 20),
                                        Text('Share Out Amount',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            addComma(widget.txModel!
                                                .messages![0].shareOutAmount!),
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                ))
                          ],
                        )
                      else if (type == 'Execute Contract')
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                      Text(type,style:kMediumBoldTextStyle),
                                        const SizedBox(height: 20),


                                        Text('Sender',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(widget.txModel!.messages![0].sender??'',style:kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Contract',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(widget.txModel!.messages![0].contract??'',style:kMediumBoldTextStyle),
                                      ]),
                                )),
                          )
                      else if (type == 'IBC Transfer')
                        widget.txModel!.messages!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(height: 2),
                                        Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type ??
                                                ''),
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Token', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            '${addComma(widget.txModel!.messages![0].token!.amount!)} ${widget.txModel!.messages![0].token!.denom}',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Sender', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget
                                                .txModel!.messages![0].sender!,
                                            copyTextName: 'Sender'),
                                        const SizedBox(height: 20),
                                        Text('Receiver',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        TextWithCopyIcon(
                                            copyTextValue: widget.txModel!
                                                .messages![0].receiver!,
                                            copyTextName: 'Receiver'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Source Channel',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            widget.txModel!.messages![0]
                                                    .sourceChannel ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Source Port',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            widget.txModel!.messages![0]
                                                    .sourcePort ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Revision Height',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            widget
                                                    .txModel!
                                                    .messages![0]
                                                    .timeoutHeight!
                                                    .revisionHeight ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Revision Number',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            addComma(widget
                                                    .txModel!
                                                    .messages![0]
                                                    .timeoutHeight!
                                                    .revisionNumber ??
                                                ''),
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Timeout Timestamp ',
                                            style: kSmallTextStyle),
                                        const SizedBox(height: 2),
                                        Text(
                                            (widget.txModel!.messages![0]
                                                    .timeoutTimestamp ??
                                                ''),
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                ))
                            : Container()
                      else if (type == 'IBC Transfer')
                        widget.txModel!.messages!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                width: MediaQuery.of(context).size.width / 1.1,
                                decoration: kBoxDecorationWithGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Message',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Type', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            getType(widget.txModel!.messages![0]
                                                    .type!) ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Token', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            '${widget.txModel!.messages![0].token!.amount} ${widget.txModel!.messages![0].token!.denom}',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Sender', style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            widget.txModel!.messages![0]
                                                    .sender ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(height: 20),
                                        Text('Receiver',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            widget.txModel!.messages![0]
                                                    .receiver ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Source Channel',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            widget.txModel!.messages![0]
                                                    .sourceChannel ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text('Source Port',
                                            style: kSmallTextStyle),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            widget.txModel!.messages![0]
                                                    .sourcePort ??
                                                '',
                                            style: kMediumBoldTextStyle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                ))
                            : Container()
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
                            widget.txModel!.rawLog != null
                                ? SelectableText(
                                    //jsonDecode
                                    (widget.txModel!.rawLog!)
                                        .toString()
                                        .replaceAll(RegExp(r'{'), '\n')
                                        .replaceAll(RegExp(r'}'), '')
                                        .replaceAll(RegExp(r','), ',\n')
                                        .replaceAll(RegExp(r':'), ' : '),
                                    style: kMediumTextStyle)
                                : Text('No Logs Available',
                                    style: kMediumBoldTextStyle)
                          ]),
                    ),
                  );
          }),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }
}
