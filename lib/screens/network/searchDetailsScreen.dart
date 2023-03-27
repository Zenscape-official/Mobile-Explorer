import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/controller/txToggleController.dart';
import 'package:zenscape_app/screens/network/blockDetails.dart';
import 'package:zenscape_app/screens/network/contractDetails.dart';
import 'package:zenscape_app/screens/network/dashboard.dart';
import '../../backend_files/contractBalanceModel.dart';
import '../../backend_files/ibcDenomModel.dart';
import '../../backend_files/txModel.dart';
import '../../constants/constants.dart';
import '../../backend_files/blocksModel.dart';
import '../../constants/functions.dart';
import '../../backend_files/delegationModel.dart';
import '../../controller/networklistController.dart';
class SearchScreen extends StatefulWidget {
  var nameController;
  final NetworkList? networkList;
  final String? blockSearch,txSearch,txFromAddress,balanceFromAddress,delegationFromAddress,rewardsFromAddress;
 SearchScreen({Key? key,

   this.nameController,
   this.networkList,
   this.blockSearch,
   this.txSearch,
   this.balanceFromAddress,
   this.delegationFromAddress,
   this.txFromAddress,
   this.rewardsFromAddress}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  NetworkController networkController = Get.put(NetworkController());
  List<BlockModel>? blockDetails=[];
  List<TxModel>? txModel=[];
  var blockLoaded=0;
  var txLoaded=0;
  var addressLoaded=0;
  var summarySelected=0;
  var loading=false;
  var balance;
  var reward;
  var rewardList=[];
  var rewardLoaded;
  var delegation;
  var delegationList=[];
  List<Balance> balanceList=[];
  var balanceLoaded=false;
  var delegationLoaded=false;
  ScrollController? _controller;
  @override
  void initState() {
    super.initState();
    getData();
    _controller = ScrollController();
  }
  getData()async{
    loading=true;
    //for blockheight search
    if(isNumeric(widget.nameController)) {
      final response = await http.get(Uri.parse(
          '${widget.networkList!.blockSearch}${widget.nameController.toString()}'));
      if (response.statusCode == 200) {
        blockDetails =
        List<BlockModel>.from(json.decode(response.body).map((x) => BlockModel.fromJson(x)));
        setState(() {
          if (blockDetails!.isNotEmpty ) {
            blockLoaded = 1;
          } else {
            blockLoaded = 0;
          }
        });
      } else {
     // print(response.statusCode);
      }
    }
    //for txHash Search
    else if(widget.nameController.length==64){
      final response = await http.get(Uri.parse(
          '${widget.networkList!.transactionSearch}${widget.nameController.toString()}'
      )
      );
      if (response.statusCode == 200) {
        txModel = List<TxModel>.from(json.decode(response.body).map((x) => TxModel.fromJson(x)));

        setState(() {
          if (txModel!.isNotEmpty) {
            txLoaded = 1;
          } else {
            txLoaded = 0;
          }
        });
      }}
    else if(widget.nameController.length==52){}
     else  if(widget.nameController.length==43||widget.nameController.length==45){

        final tx_response = await http.get(Uri.parse(
            '${widget.networkList!.txFromAddress}${widget.nameController.toString()}'));
        final balance_response = await http.get(Uri.parse(
            '${widget.networkList!.contractDetailsBalances}${widget.nameController.toString()}'));
        final delegate_response = await http.get(Uri.parse(
            '${widget.networkList!.delegationFromAddress}${widget.nameController.toString()}'));
        final reward_response = await http.get(Uri.parse(
            '${widget.networkList!.rewardFromAddress}${widget.nameController.toString()}/rewards'));
        if (tx_response.statusCode == 200) {
          txModel = List<TxModel>.from(json.decode(tx_response.body).map((x) => TxModel.fromJson(x)));
          setState(() {
            if (txModel!.isNotEmpty) {
              addressLoaded =1;
            }
            else {
              addressLoaded = 0;
            }
          });
        }
        if(balance_response.statusCode==200){

          balance =  jsonDecode(balance_response.body)['balances'];
          balanceList=List<Balance>.from(balance.map((x) => Balance.fromMap(x)));
          setState(() {
            if (balance!=null){
              balanceLoaded=true;
              addressLoaded =1;
            }
            else{
              balanceLoaded=false;
              addressLoaded = 0;
            }
          }
          );
        }
        else{
          //print(balance_response.statusCode);
        }
        if(delegate_response.statusCode==200){
          delegation =  jsonDecode(delegate_response.body)["delegation_responses"];
          delegationList= List<DelegationResponse>.from(delegation.map((x) => DelegationResponse.fromMap(x)));
          setState(() {
            if (delegationList.isNotEmpty){
              delegationLoaded=true;
              addressLoaded =1;
            }
            else{
              delegationLoaded=false;
              addressLoaded=0;
            }
          });
        }
        else{
        }
        if(reward_response.statusCode==200){
          reward =  jsonDecode(reward_response.body)['rewards'];
          rewardList=List<Balance>.from(reward.map((x) => Balance.fromMap(x)));
          setState(() {
            if (rewardList!=null){
              rewardLoaded=true;
              addressLoaded =1;
            }
            else{
              rewardLoaded=false;
              addressLoaded = 0;
            }
          });
        }
        else{
         // print(delegate_response.statusCode);
        }
      }
    loading=false;
  }
  @override
  Widget build(BuildContext context) {
    if(blockLoaded==1){
      return BlockDetailScreen(blockModel:blockDetails![0],valDesc: widget.networkList!.blocksMoniker!,networkList: widget.networkList!,);
    }
    else if(txLoaded==1){
      return
        Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Details',
              style: kBigBoldTextStyle,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GetBuilder<TxToggleController>(
                        builder: (txToggleController) {
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
                            initialLabelIndex: txToggleController.isBlockSelected == 0 ?0:1,
                            totalSwitches: 2,
                            labels: const ['Summary','JSON'],
                            radiusStyle: true,
                            onToggle: (index) {
                              summarySelected = index!;
                              txToggleController.updateData(index);
                            },
                          );
                        }
                    )
                  ],
                ),
              ),
              GetBuilder<TxToggleController>(builder:(txToggleController) {
                return txToggleController.isBlockSelected == 0
                    ?
                      Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                      width: MediaQuery.of(context).size.width / 1.1,
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
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text('TxHash', style: kSmallTextStyle),
                                  InkWell(
                                    onTap:()=> Clipboard.setData ( ClipboardData(text: txModel![0].hash!,)).then((_){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(content: Text('Transaction Hash Copied to your clipboard !')
                                      )
                                      );
                                    }),
                                    child: Row(
                                      children: [
                                        const SizedBox(width:4),
                                        const Icon(Icons.copy,
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
                              Text((txModel![0].hash!),
                                  textAlign: TextAlign.start
                                  ,style:kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Status', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                  txModel![0].success == true
                                      ? 'Success'
                                      : 'Fail',
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text('Height', style: kSmallTextStyle),
                                  InkWell(
                                    onTap:()=> Clipboard.setData ( ClipboardData(text: txModel![0].hash!,)).then((_){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(content: Text('Height Copied to your clipboard !')
                                      )
                                      );
                                    }),
                                    child: Row(
                                      children: [
                                        const SizedBox(width:4),
                                        const Icon(Icons.copy,
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
                              Text(addComma(txModel![0].height!),
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Fee', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              txModel![0].fee!.amount!.isNotEmpty? Text(
                                  '${addComma(txModel![0].fee!.amount![0].amount!)} ${txModel![0].fee!.amount![0].denom!}',
                                  style: kMediumBoldTextStyle):Container(),
                              const SizedBox(height: 20),
                              Text('Gas (used/wanted)', style: kSmallTextStyle),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                  '${addComma(txModel![0].gasUsed!)} / ${addComma(txModel![0].gasWanted!)} ${widget.networkList!.uDenom}',
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                              Text('Memo', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(txModel![0].memo!,
                                  style: kMediumBoldTextStyle),
                              const SizedBox(
                                height: 20,
                              ),
                            ]
                        ),
                      ),
                    ),
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
                          txModel![0].rawLog!=null? SelectableText(
                    //jsonDecode
                    (txModel![0].rawLog!)
                        .toString()
                        .replaceAll(RegExp(r'{'), '\n')
                        .replaceAll(RegExp(r'}'), '')
                        .replaceAll(RegExp(r','), ',\n')
                        .replaceAll(RegExp(r':'), ' : '),
                      style: kMediumTextStyle)
                              :Text('No Logs Available',style: kMediumBoldTextStyle)
                        ]),
                  ),
                );
              }),

            ]
        ),
      ),
    );
    }
    else if(addressLoaded==1){
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Account Details',
                style: kBigBoldTextStyle,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(height:5),
                Container(
                  margin:EdgeInsets.all(12),
                  padding: EdgeInsets.all(12),
                    decoration: kBoxDecorationWithoutGradient,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Account Address', style: kMediumBoldTextStyle),
                                      InkWell(
                                        onTap: () =>
                                            Clipboard.setData(ClipboardData(
                                              text: widget.nameController,
                                            )).then((_) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Address Copied to your clipboard !')));
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
                                  SizedBox(height: 4),
                                  Text(widget.nameController,style: kMediumTextStyle,),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height:10),
                          ( balanceList.isNotEmpty)? Container(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 18),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Balances',
                                        style: kMediumBoldTextStyle
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
                                      itemCount: balanceList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return BalanceCont(balance: balanceList[index]
                                        );
                                      }),
                                ),
                                SizedBox(height:25)
                              ])):Container(),
                          SizedBox(height:10),
                          ( delegationList.isNotEmpty)? Container(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 18),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Delegations',
                                          style: kMediumBoldTextStyle

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
                                      itemCount: delegationList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return DelegatesContainer(delegationResponse: delegationList[index],
                                        );
                                      }),
                                ),
                                SizedBox(height:25)
                              ])):Container(),
                          ( rewardList.isNotEmpty)? Container(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 18),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Rewards',
                                          style: kMediumBoldTextStyle

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
                                      itemCount: rewardList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return BalanceCont(balance: rewardList[index],
                                        );
                                      }),
                                ),
                                SizedBox(height:25)
                              ])):Container(),


                        txModel!.length!=0 ? Padding(
                            padding:
                            const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(12.0,6,2,6),
                                  child: Text('Transactions',
                                      style: kMediumBoldTextStyle),
                                ),
                                ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    reverse: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: txModel!.length>100?100:txModel!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return TxContDash(txModel: txModel![index],
                                        networkList: widget.networkList!,
                                      );
                                    }),
                              ],
                            ),
                          ):Container()
                        ],
                      ),
                    )
                ),
              ]
          ),
        ),
      );
    }

    else if(loading==true){
      return Scaffold(body: Center(child: CircularProgressIndicator()));}
    else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body:
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No Data Found',
              style: kMediumBoldTextStyle,),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10,horizontal: 40),
              child: Text('''Sorry, we couldn't find any results for ${widget.nameController}. Please input the correct block number, transaction hash, account address''',textAlign: TextAlign.center,style: kSmallTextStyle),
            ),
          ],
        ),
        ),
      );
    }

  }
}

class DelegatesContainer extends StatefulWidget {
  final DelegationResponse? delegationResponse;
  const DelegatesContainer({Key? key, this.delegationResponse}) : super(key: key);

  @override
  State<DelegatesContainer> createState() => _DelegatesContainerState();
}

class _DelegatesContainerState extends State<DelegatesContainer> {
  @override
  void initState() {
    super.initState();

    getData();
  }
  var _items;
  List<Token> ibcDenom=[];
  String denom='';

  getData() async {
    final String response = await rootBundle.loadString('assets/jsonFiles/testnet_ibc_asset.json');
    final data = await json.decode(response)["tokens"];

    _items = data;
    ibcDenom=List.from((_items).map((x) => Token.fromJson(x)));
    if(ibcDenom.isNotEmpty){
      setState(() {
      });
    }
  }
  mapDenom(String input){
    var denom='';
    for(int i=0;i<ibcDenom.length;i++){
      if(input==ibcDenom[i].ibcDenomHash){
        denom=ibcDenom[i].coinDenom!;
        return denom;
      }
      else{
        // print(input);
        denom=input;
        return denom;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    denom=mapDenom(widget.delegationResponse!.balance!.denom??'');
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
                  Text(
                      (removeFirstChar(widget.delegationResponse!.balance!.denom!)).toUpperCase()
                  ),
                  Text(
                    addComma((double.parse(widget.delegationResponse!.balance!.amount!)/1000000).toString()),
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
