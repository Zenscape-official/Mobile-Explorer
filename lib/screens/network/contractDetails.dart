import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/txModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/toggleController.dart';
import 'package:http/http.dart' as http;
import '../../backend_files/contractBalanceModel.dart';
import '../../backend_files/contractModel.dart';
import '../../controller/txToggleController.dart';

class ContractDetails extends StatefulWidget {
final ContractModel? contractModel;
  ContractDetails({Key? key,this.contractModel}) : super(key: key);
  @override
  State<ContractDetails> createState() => _ContractDetailsState();
}
class _ContractDetailsState extends State<ContractDetails> {
 int summarySelected=0;
 var balance;
 List<Balance>? balanceList;
 var balanceLoaded=false;
  @override
  void initState() {
    super.initState();
    getData();
  }

 getData()async{

   final response = await http.get(Uri.parse('https://meteor.rest.comdex.one/cosmos/bank/v1beta1/balances/${widget.contractModel!.contractAddress!}'));
   if (response.statusCode == 200) {

      balance =  jsonDecode(response.body)['balances'];
      print(balance);
      balanceList=List<Balance>.from(balance.map((x) => Balance.fromMap(x)));
      print(balanceList);
     setState(() {
       if (balance!=null){
         balanceLoaded=true;
       }
       else{
         balanceLoaded=false;
       }
     });
   }
   else{
     // print(response.statusCode);
     // print('+errorr');
     // print('https://meteor.rpc.comdex.one/block?height=${widget.txModel!.height!.toString()}');
   }
 }
  @override
  Widget build(BuildContext context) {
   // print(widget.contractModel!.contractStates!.config);

    return
      Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contract Details',
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
                  Text('Code Id', style: kSmallTextStyle),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(widget.contractModel!.codeId!, style: kMediumBoldTextStyle),

                        const SizedBox(
                          height: 20,
                        ),
                        Text('Label', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(widget.contractModel!.label!, style: kMediumBoldTextStyle),


                        const SizedBox(
                          height: 20,
                        ),
                        Text('Contract Address', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(widget.contractModel!.contractAddress!, style: kMediumBoldTextStyle),


                        const SizedBox(
                          height: 20,
                        ),
                        Text('Height', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(widget.contractModel!.height!, style: kMediumBoldTextStyle),


                        const SizedBox(
                          height: 20,
                        ),
                        Text('Creator', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(widget.contractModel!.creator!, style: kMediumBoldTextStyle),


                        const SizedBox(
                          height: 20,
                        ),
                        Text('Height', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(widget.contractModel!.height!, style: kMediumBoldTextStyle),

                        const SizedBox(
                          height: 20,
                        ),
                        Text('Instantiated At', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(dateTime(widget.contractModel!.instantiatedAt!), style: kMediumBoldTextStyle),


                        const SizedBox(
                          height: 20,
                        ),
                        Text('Init Message', style: kSmallTextStyle),
                        const SizedBox(
                          height: 2,
                        ),
                        widget.contractModel!.contractStates!.config==null?
                        Text('null', style: kMediumBoldTextStyle):
                        Text((widget.contractModel!.contractStates!.config!), style: kMediumBoldTextStyle),
                      ]
          ),
        ),
      )
                ),
          balanceLoaded? Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 10, 18, 12),
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
                      padding:
                      const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                      child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          reverse: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: balanceList!.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            return BalanceContDash(balance: balanceList![index],
                            );
                          }),
                    ),
                    SizedBox(height:25)
                  ]))):CircularProgressIndicator()
              ]
          )
        )
      );
  }
}
class BalanceContDash extends StatelessWidget {
final Balance? balance;
const BalanceContDash({Key? key, this.balance}) : super(key: key);
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
                      balance!.denom!
                  ),
                  Text(
                    balance!.amount!,
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