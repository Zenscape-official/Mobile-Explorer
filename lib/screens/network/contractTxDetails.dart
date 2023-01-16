import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/constants/functions.dart';
import 'package:zenscape_app/screens/network/searchDetailsScreen.dart';
import '../../backend_files/contractTxModel.dart';
import '../../controller/txToggleController.dart';
import '../../widgets/searchBarWidget.dart';

class ContractTxDetails extends StatefulWidget {
  final ContractTxModel? contractTxModel;
  ContractTxDetails({Key? key,this.contractTxModel}) : super(key: key);
  @override
  State<ContractTxDetails> createState() => _ContractTxDetailsState();
}

class _ContractTxDetailsState extends State<ContractTxDetails> {
  var isLoaded;
  int summarySelected=0;


  @override
  void initState() {
    super.initState();

    //getData();
  }
  final TxToggleController txToggleController =Get.put(TxToggleController());
  TextEditingController nameController =TextEditingController();

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
                'Contract Transactions Details',
                style: kMediumBoldTextStyle,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(nameController:nameController),
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
                          InkWell(
                            onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: SearchScreen(nameController: widget.contractTxModel!.height!),
                              withNavBar: true,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            ),
                            child: Text(addComma(widget.contractTxModel!.height!), style: kMediumBlueBoldTextStyle),),


                          const SizedBox(
                            height: 20,
                          ),
                          Text('Hash', style: kSmallTextStyle),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(widget.contractTxModel!.txhash!, style: kMediumBoldTextStyle),

                          const SizedBox(
                            height: 20,
                          ),

                          widget.contractTxModel!.info!.isNotEmpty?
                          Column(
                            children: [
                              Text('Information', style: kSmallTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(widget.contractTxModel!.info!, style: kMediumBoldTextStyle),

                            ],
                          ):
                          Container(),


                          const SizedBox(
                            height: 20,
                          ),
                          Text('Time', style: kSmallTextStyle),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(dateTime(widget.contractTxModel!.timestamp!), style: kMediumBoldTextStyle),


                          const SizedBox(
                            height: 20,
                          ),
                          Text('Code', style: kSmallTextStyle),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(widget.contractTxModel!.code.toString(), style: kMediumBoldTextStyle),


                          const SizedBox(
                            height: 20,
                          ),
                          Text('Gas Used/Gas Wanted', style: kSmallTextStyle),
                          const SizedBox(
                            height: 4,
                          ),
                          Text('${addComma(widget.contractTxModel!.gasUsed!)} / ${addComma(widget.contractTxModel!.gasWanted!)}' , style: kMediumBoldTextStyle),


                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          widget.contractTxModel!.tx!.body!.memo!.isNotEmpty? Column(
                            children: [
                              Text('Memo', style: kSmallTextStyle),
                              const SizedBox(
                                height: 4,
                              ),
                              Text('${(widget.contractTxModel!.tx!.body!.memo!)}' , style: kMediumBoldTextStyle),

                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ):Container(),

                          Text('Sender', style: kSmallTextStyle),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: SearchScreen(nameController: widget.contractTxModel!.tx!.body!.messages![0].sender!),
                              withNavBar: true,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            ),
                            child: Text(widget.contractTxModel!.tx!.body!.messages![0].sender!, style: kMediumBlueBoldTextStyle),),
                          Text('${(widget.contractTxModel!.tx!.body!.messages![0].sender)}', style: kMediumBoldTextStyle),

                          const SizedBox(
                            height: 20,
                          ),
                          Text('Type', style: kSmallTextStyle),
                          const SizedBox(
                            height: 4,
                          ),
                          Text('${getType(widget.contractTxModel!.tx!.body!.messages![0].type!)}', style: kMediumBoldTextStyle),

                          const SizedBox(
                            height: 20,
                          ),
                          Text('Contract', style: kSmallTextStyle),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap:()=> PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: SearchScreen(nameController: widget.contractTxModel!.tx!.body!.messages![0].contract!),
                              withNavBar: true,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            ),
                            child: Text((widget.contractTxModel!.tx!.body!.messages![0].contract!), style: kMediumBlueBoldTextStyle),),


                          const SizedBox(
                            height: 20,
                          ),
                          Text('Data', style: kSmallTextStyle),
                          const SizedBox(
                            height: 4,
                          ),
                          Text('${(widget.contractTxModel!.data)}', style: kMediumBoldTextStyle),

                          const SizedBox(
                            height: 20,
                          ),
                          Text('Logs', style: kSmallTextStyle),
                          const SizedBox(
                            height: 4,
                          ),
                          Text('${(widget.contractTxModel!.logs![0].log)}', style: kMediumBoldTextStyle),
                        ]
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,)
            ],
          ),
        ),
      );
  }
}
