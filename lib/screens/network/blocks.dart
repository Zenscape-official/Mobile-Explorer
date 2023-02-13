import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/backend_files/blocksModel.dart';
import 'package:zenscape_app/backend_files/txModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/navController.dart';
import 'package:zenscape_app/controller/toggleController.dart';
import 'package:zenscape_app/controller/txController.dart';
import 'package:zenscape_app/controller/txToggleController.dart';
import '../../backend_files/networkList.dart';
import '../../backend_files/validatorsModel.dart';
import '../../constants/constants.dart';
import '../../Screens/network/transactionDetails.dart';
import '../../constants/functions.dart';
import '../../controller/blocksController.dart';
import '../../controller/networklistController.dart';
import '../../widgets/navigationDrawerWidget.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../widgets/searchBarWidget.dart';
import 'blockDetails.dart';
import 'package:flutter/cupertino.dart';

class Blocks extends StatefulWidget {
  final NetworkList? networkData;
  final String? valDescUrl;
 const Blocks({this.networkData,this.valDescUrl});
  @override
  State<Blocks> createState() => _BlocksState();
}
class _BlocksState extends State<Blocks> {
  var AppBar1='Blocks';
  var AppBar2='Transactions';
  ToggleController toggleController=Get.put(ToggleController());
  final NetworkController networkController = Get.put(NetworkController());
  final TxController _txController=Get.put(TxController());
  Rx<List<BlockModel>> foundBlock = Rx<List<BlockModel>>([]);
  NavController navController=Get.put(NavController());
  var blocks;
  var tx;
  int pageIndex=2;
  bool isLoaded=false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    getData();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => getData());
    navController.updatePage(3);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
    });
  }
  getData() async{
    final result = await networkController.fetchList(widget.networkData!.blocksUrl!);
    if (result ['success'] == false) {
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(result['response']),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          );
        },
      );
    }
    if(result['success'] == true) {
     blocks = List.from(result['response'])
          .map((e) => BlockModel.fromJson(e))
         .toList()
         .reversed
         .toList()
         .obs;
    }
    tx= await _txController.fetchTx(widget.networkData!.transactionsUrl!);
    setState(() {
      if (blocks!=null){
        isLoaded=true;
      }
      else{
        isLoaded=false;
      }
    });
  }
  int blockSelected=0;
  TextEditingController nameController=TextEditingController();
  String txHash='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDraw(networkData: widget.networkData,pageIndex: pageIndex,),
      appBar: AppBar(
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<ToggleController>(builder: (blockController){
              return blockController.isBlockSelected==0?
              Text(AppBar1,
                style: kBigBoldTextStyle,):
              Text(AppBar2,
                style: kBigBoldTextStyle,);}),
            CircleAvatar(
                radius:15,
                child: InkWell(
                    //onTap: ()=> Navigator.of(context).popUntil((route) => route.isFirst),
                    child: Image.network(widget.networkData!.logoUrl??widget.networkData!.logUrl!)),
                backgroundColor: Colors.transparent),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await getData();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 0),
              SearchBar(
                nameController:nameController,
                hintText: 'Enter Block Height, Tx Hash, Address..',
                networkList: widget.networkData!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                GetBuilder<ToggleController>(builder: (blockController){
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
                      initialLabelIndex: blockController.isBlockSelected == 0 ?0:1,
                      totalSwitches: 2,
                      labels: const ['Blocks', 'Transactions'],
                      radiusStyle: true,
                      onToggle: (index) {
                        blockSelected = index!;
                        toggleController.updateData(index);
                      },
                    );
                }
                )
                  ]
                ),
              ),
              isLoaded?
              GetBuilder<ToggleController>(builder: (blockController){
                 return blockController.isBlockSelected==0?
                 GetBuilder<BlocksController>(builder: (blocksController){
                        return ListView.builder(
                         reverse: true,
                         physics: const NeverScrollableScrollPhysics(),
                         scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                         itemCount: blocks.length,
                         itemBuilder: (BuildContext context, int index) {
                           return
                             BlockContainer(blockModel: blocks[index],valDescUrl: widget.valDescUrl,networkList: widget.networkData!,);
                         }
                 );
                      }
                    ):
                 Obx(
                    () {
                     return ListView.builder(
                         reverse: true,
                         physics: const NeverScrollableScrollPhysics(),
                         scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                         itemCount: TxController.txList.length,
                         itemBuilder: (BuildContext context, int index) {
                           return
                             TxContainer(txModel: TxController.txList[index],heightSearchUrl: widget.networkData!.txTimestamp,networkList: widget.networkData!,);
                         }
                         );
                   }
                 );
               }
               ):const Center(child: CircularProgressIndicator()),
              SizedBox(height:30),
            ],
          ),
        ),
      ),
    );
  }
}

class BlockContainer extends StatefulWidget {
  final BlockModel? blockModel;
  final String? valDescUrl;
  final NetworkList networkList;

 BlockContainer({
    Key? key, this.blockModel,this.valDescUrl,required this.networkList,
  }) : super(key: key);

  @override
  State<BlockContainer> createState() => _BlockContainerState();
}

class _BlockContainerState extends State<BlockContainer> {
  var valMoniker;
  var monikerLoaded=false;
  ValidatorModel? validatorModel;

  @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    final response = await http.get(Uri.parse('${widget.networkList.blocksMoniker}${widget.blockModel!.proposerAddress}'));

    if (response.statusCode == 200) {
      if(widget.networkList.uDenom!='uatom')
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
   getData();
    return InkWell(
      onTap:()=> Navigator.push(context, CupertinoPageRoute(builder: (context) => BlockDetails(blockModel: widget.blockModel,networkList:widget.networkList))),
      child: Container(
        decoration: kBoxDecorationWithGradient,
        margin: const EdgeInsets.all(14),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        InkWell(
                          onTap:()=> Clipboard.setData ( ClipboardData(text: widget.blockModel!.height!)).then((_){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text('BlockHeight Copied to your clipboard !')));
                          }),
                          child: Row(
                            children: [
                              Text(addComma(widget.blockModel!.height!)
                                  ,style:kMediumBoldTextStyle),
                              const SizedBox(width:4),
                              const Icon(Icons.copy,
                                color: Colors.black54,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                     Container(
                          decoration: BoxDecoration (
                            border: Border.all(
                              color: Colors.lightBlueAccent.withOpacity(.5),
                              width: 1.0,
                            ),
                            color: const Color(0xFF8CDAFF).withOpacity(.5),
                            borderRadius: const BorderRadius.all(Radius.circular(15.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.05),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(-2, -2), // changes position of shadow
                              ),],),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                            child:   Text(timeDifferenceFunction(widget.blockModel!.timestamp!.toString()).toString(),
                              style: kExtraSmallTextStyle,
                            )
                          ),
                        )
                      ]
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Block Hash',
                            style:kSmallTextStyle),
                      //  const SizedBox(width: 90),
                        SelectableText(dotRefactorFunction(widget.blockModel!.hash!),
                            style:kSmallTextStyle)
                      ]
                  ),
                ),
               widget.networkList.uDenom!='uatom'? Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Proposer',
                            style:kSmallTextStyle),
                        //const SizedBox(width:99),
                        monikerLoaded? Text((valMoniker)
                             ,style:kSmallTextStyle):
                        SizedBox(
                            height:10,
                            width:10,
                            child: LinearProgressIndicator()
                        ),
                      ]
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('No of Transactions',
                            style:kSmallTextStyle),
                        Text(widget.blockModel!.numTxs.toString(),
                            style:kSmallTextStyle)
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text('Time',
                            style:kSmallTextStyle),
                        Text(dateTime(widget.blockModel!.timestamp!.toLocal()).toString(),
                            style:kSmallTextStyle)
                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class TxContainer extends StatefulWidget {
  final TxModel? txModel;
  final String? heightSearchUrl;
  NetworkList networkList;
   TxContainer({
    Key? key,
    this.txModel,
     this.heightSearchUrl,
     required this.networkList
  }) : super(key: key);

  @override
  State<TxContainer> createState() => _TxContainerState();
}

class _TxContainerState extends State<TxContainer> {
  NetworkController networkController=Get.put(NetworkController());
  TxToggleController txToggleController=Get.put(TxToggleController());
 var type='';
 var timestampTx;
 var txLoaded=false;

 @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
 //    final response = await http.get(Uri.parse('${widget.heightSearchUrl}${widget.txModel!.height!.toString()}'));
 //    if (response.statusCode == 200) {
 //
 //      timestampTx =  jsonDecode(response.body)['result']['block']['header']['time'];
 //        setState(() {
 //          if (timestampTx!=null){
 //            txLoaded=true;
 //          }
 //          else{
 //            txLoaded=false;
 //          }
 //        });
 //  }
 // else{
 //    }
    try{
      var response = await http.get(Uri.parse(
          '${widget.heightSearchUrl}${widget.txModel!.height!.toString()}')
      );
      switch(response.statusCode){
        case 200:
          timestampTx =  jsonDecode(response.body)['result']['block']['header']['time'];
          setState(() {
            if (timestampTx!=null){
              txLoaded=true;
            }
            else{
              txLoaded=false;
            }
          });
          break;
        case 201:
          final result = jsonDecode(response.body);
          final jsonResponse = {'success': true, 'response': result};
          txLoaded=false;
          print(response.statusCode);
          return jsonResponse;
        case 400:
          final result = jsonDecode(response.body);
          final jsonResponse = {'success': false, 'response': result};
          txLoaded=false;
          print(response.statusCode);
          return jsonResponse;
        case 401:
          final jsonResponse = {'success': false, 'response': 'UNAUTHORIZED'};
          txLoaded=false;
          print(response.statusCode);
          return jsonResponse;
        case 403:
          final jsonResponse = {'success': false, 'response': 'UNAUTHORIZED'};
          txLoaded=false;
          print(response.statusCode);
          return jsonResponse;
        case 500:
        case 501:
        case 502:
          final jsonResponse = {
            'success': false,
            'response': 'SOMETHING WRONG ${response.statusCode}'
          };
          txLoaded=false;
          print(response.statusCode);
          return jsonResponse;
        default:
          final jsonResponse = {
            'success': false,
            'response': 'SOMETHING WRONG ${response.statusCode}'
          };
          txLoaded=false;
          return jsonResponse;
      }
    } on SocketException {
      final jsonResponse = {
        'success': false,
        'response': 'No Internet or Connection Failure '
      };
      txLoaded=false;
      return jsonResponse;
    } on FormatException {
      final jsonResponse = {'success': false, 'response': 'Bad Response'};
      return jsonResponse;
    } on HttpException {
      final jsonResponse = {
        'success': false,
        'response': 'SOMETHING_WRONG' //Server not responding
      };
      txLoaded=false;
      return jsonResponse;
    }
    }

  @override
  Widget build(BuildContext context) {
   getData();
   type=truncateBeforeLastDot(widget.txModel!.messages![0].type!);

    return InkWell(

        onTap:()
        {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: TxDetails(
            networkList: widget.networkList,
            txModel: widget.txModel,
            heightSearchUrl: widget.heightSearchUrl!,
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
        txToggleController.updateData(0);
      },
      child: Container(
        decoration: kBoxDecorationWithGradient,
        margin: const EdgeInsets.all(14),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        InkWell(
                          onTap:()=> Clipboard.setData ( ClipboardData(text: widget.txModel!.hash!,)).then((_){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text('Transaction Hash Copied to your clipboard !')));
                          }),
                          child: Row(
                            children: [
                              Text(dotRefactorFunction(widget.txModel!.hash!)
                                  ,style:kMediumBoldTextStyle),
                              const SizedBox(width:4),
                              const Icon(Icons.copy,
                                color: Colors.black54,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        txLoaded? Container(
                          decoration: BoxDecoration (
                            border: Border.all(
                              color: Colors.lightBlueAccent.withOpacity(.5),
                              width: 1.0,
                            ),
                            color: const Color(0xFF8CDAFF).withOpacity(.5),
                            borderRadius: const BorderRadius.all(Radius.circular(15.0),
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
                            padding: const EdgeInsets.fromLTRB(12,2,12,2.0),
                            child: Text(
                              timeDifferenceFunction(timestampTx).toString(),
                              style: kExtraSmallTextStyle,
                            )
                          ),
                        ):Container()
                      ]
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fee',
                            style:kSmallTextStyle),
                        widget.txModel!.fee!.amount!.isNotEmpty?Text(widget.txModel!.fee!.amount![0].amount!+' '+widget.txModel!.fee!.amount![0].denom!,
                            style:kSmallTextStyle):Container()
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text('Height',
                            style:kSmallTextStyle),
                        Text(widget.txModel!.height!,
                            style:kSmallTextStyle)
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Type',
                            style:kSmallTextStyle),
                    const SizedBox(width: 70,),
                        Flexible(
                        child: RichText(
                        overflow: TextOverflow.ellipsis,
                        strutStyle: const StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                            style: kSmallTextStyle,
                            text:type,
                      ),
                        )
                        )
                      ]
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Time',
                            style:kSmallTextStyle),
                        const SizedBox(width: 70,),
                   txLoaded? Text(
                     (dateTime
                       (DateTime.parse(timestampTx).toLocal()
                   )
                     ),
                     style: kSmallTextStyle,):
                       SizedBox(
                           height:10,
                           width:15,
                           child:Container(),
                       )
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status',
                            style:kSmallTextStyle),
                        const SizedBox(width: 70,),
                         Text(
                          widget.txModel!.success==true?'Success':'Fail',
                          style:TextStyle(
                            fontFamily: 'MontserratRegular',
                            color: widget.txModel!.success==true?Colors.green:Colors.redAccent,
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                          )
                         )
                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
