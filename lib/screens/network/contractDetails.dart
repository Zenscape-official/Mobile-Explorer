import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/backend_files/contractTxModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zenscape_app/screens/network/contractTxDetails.dart';
import 'package:zenscape_app/screens/network/searchDetailsScreen.dart';
import '../../backend_files/contractBalanceModel.dart';
import '../../backend_files/contractModel.dart';
import '../../backend_files/ibcDenomModel.dart';
import '../../backend_files/networkList.dart';
import '../../constants/functions.dart';

class ContractDetails extends StatefulWidget {
  final NetworkList? networkList;
  final ContractModel? contractModel;
  ContractDetails({Key? key, this.contractModel,this.networkList}) : super(key: key);
  @override
  State<ContractDetails> createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  int summarySelected = 0;
  var tx;
  var balance;

  List<Balance> balanceList = [];
  List<ContractTxModel>? txList;
  var balanceLoaded = false;
  var txListLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final response = await http.get(Uri.parse(
        '${widget.networkList!.contractDetailsBalances}${widget.contractModel!.contractAddress!}'));
    final txResponse = await http.get(Uri.parse(
        '${widget.networkList!.contractTxs!}'   ));

    if (response.statusCode == 200) {
      balance = jsonDecode(response.body)['balances'];
      balanceList = List<Balance>.from(balance.map((x) => Balance.fromMap(x)));
      setState(() {
        if (balance != null) {
          balanceLoaded = true;
        } else {
          balanceLoaded = false;
        }
      });
    }
    if (txResponse.statusCode == 200) {
      tx = jsonDecode(txResponse.body)['tx_responses'];
      txList = List.from(tx.map((x) => ContractTxModel.fromJson(x)));
      setState(() {
        if (txList != null) {
          txListLoaded = true;
        } else {
          txListLoaded = false;
        }
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contract Details',
                style: kBigBoldTextStyle,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                width: MediaQuery.of(context).size.width / 1.1,
                // height:MediaQuery.of(context).size.height/ 1.1,
                decoration: kBoxDecorationWithGradient,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Information', style: kMediumBoldTextStyle),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Code Id', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(widget.contractModel!.codeId!,
                            style: kMediumBoldTextStyle),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Label', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(widget.contractModel!.label!,
                            style: kMediumBoldTextStyle),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Contract Address', style: kMediumTextStyle),
                            InkWell(
                              onTap: () => Clipboard.setData(ClipboardData(
                                text: widget.contractModel!.contractAddress!,
                              )).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Contract Address Copied to your clipboard !')));
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
                        InkWell(
                          onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: SearchScreen(nameController: widget.contractModel!.contractAddress!,networkList: widget.networkList,),
                            withNavBar: true,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          ),
                          child: Text(widget.contractModel!.contractAddress!, style: kMediumBlueBoldTextStyle),),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Height', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: SearchScreen(nameController: widget.contractModel!.height!,networkList: widget.networkList,),
                            withNavBar: true,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          ),
                          child: Text(addComma(widget.contractModel!.height!), style: kMediumBlueBoldTextStyle),),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Creator Address', style: kMediumTextStyle),
                            InkWell(
                              onTap: () => Clipboard.setData(ClipboardData(
                                text: widget.contractModel!.creator!,
                              )).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Creator Address Copied to your clipboard !')));
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
                        InkWell(
                          onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: SearchScreen(nameController: widget.contractModel!.creator! ,networkList: widget.networkList,),
                            withNavBar: true,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          ),
                          child: Text(widget.contractModel!.creator!, style: kMediumBlueBoldTextStyle),),

                        const SizedBox(
                          height: 20,
                        ),
                        Text('Instantiated At', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(dateTime(widget.contractModel!.instantiatedAt!),
                            style: kMediumBoldTextStyle),
                        const SizedBox(
                          height: 20,
                        ),
                        // Text('Init Message', style: kSmallTextStyle),
                        //
                        // widget.contractModel!.contractStates!.config == null
                        //     ? Text('No Message', style: kMediumBoldTextStyle)
                        //     : Text(
                        //         (widget.contractModel!.contractStates!.config!)
                        //             .toString()
                        //             .replaceAll(RegExp(r'{'), '\n')
                        //             .replaceAll(RegExp(r'}'), '')
                        //             .replaceAll(RegExp(r','), ',\n')
                        //             .replaceAll(RegExp(r':'), ' : '),
                        //         style: kMediumBoldTextStyle),
                      ]),
                ),
              )),
          (balanceList.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 10, 18, 12),
                  child: Container(
                      // height: 350,
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: kBoxDecorationWithoutGradient,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Balance',
                                  style: TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: Colors.black.withOpacity(.7),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                          child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: balanceList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BalanceCont(
                                  balance: balanceList[index],
                                );
                              }),
                        ),
                        SizedBox(height: 25)
                      ])))
              : Container(),
          Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 10, 18, 12),
              child: Container(
                  // height: 350,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: kBoxDecorationWithoutGradient,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Transactions',
                              style: TextStyle(
                                fontFamily: 'MontserratBold',
                                color: Colors.black.withOpacity(.7),
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    txListLoaded
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                            child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: txList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TxCont(
                                    contractTxModel: txList![index], networkList: widget.networkList!,
                                  );
                                }),
                          )
                        : CircularProgressIndicator(),
                    SizedBox(height: 25)
                  ]))),
          SizedBox(
            height: 25,
          )
        ])));
  }
}

class BalanceCont extends StatefulWidget {
  final Balance? balance;
  const BalanceCont({Key? key, this.balance}) : super(key: key);

  @override
  State<BalanceCont> createState() => _BalanceContState();
}

class _BalanceContState extends State<BalanceCont> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  var _items;
  List<Token> ibcDenom = [];
  String? denom;

  getData() async {
    final String response =
        await rootBundle.loadString('assets/jsonFiles/testnet_ibc_asset.json');
    final data = await json.decode(response)["tokens"];
    _items = data;
    ibcDenom = List.from((_items).map((x) => Token.fromJson(x)));
    if (ibcDenom.isNotEmpty) {
      setState(() {});
    }
  }
  mapDenom(String input) {
    for (int i = 0; i < ibcDenom.length; i++) {
      if (input == ibcDenom[i].ibcDenomHash) {
        denom = ibcDenom[i].coinDenom!;
        return denom;
      } else {
        denom = input;
        return denom;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    denom = mapDenom(widget.balance!.denom??'');
    return Padding(
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 85,
                      height: 18,
                      child: denom != null
                          ? Text((removeFirstChar(denom!)).toUpperCase())
                          : CircularProgressIndicator(),
                    ),
                  ),
                  Text(
                    addComma((double.parse(widget.balance!.amount??'0') / 1000000)
                        .toString()),
                    style: kSmallBoldTextStyle,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TxCont extends StatelessWidget {
  final ContractTxModel? contractTxModel;
  NetworkList networkList;
  TxCont({Key? key, this.contractTxModel, required this.networkList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  ContractTxDetails(contractTxModel: contractTxModel,networkList: networkList,))),
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
                              text: contractTxModel!.txhash!,
                            )).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Transaction Hash Copied to your clipboard !')));
                            }),
                            child: Row(
                              children: [
                                Text(
                                    dotRefactorFunction(
                                        contractTxModel!.txhash!),
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
                    Text(
                      timeDifferenceFunction(
                          dateTime(contractTxModel!.timestamp!)),
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
                      'Type',
                      style: kSmallTextStyle,
                    ),
                    Text(
                      getType(contractTxModel!.tx!.type!),
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
                    Text(
                      dateTime(contractTxModel!.timestamp!),
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
