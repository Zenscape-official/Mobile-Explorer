import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/backend_files/validatorsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/networklistController.dart';
import 'package:zenscape_app/screens/network/validatorDetails.dart';
import 'package:zenscape_app/widgets/navigationDrawerWidget.dart';
import '../../controller/valToggleController.dart';
import '../../controller/validatorsController.dart';

class Validators extends StatefulWidget {
  final NetworkList? networkList;
  const Validators({Key? key, this.networkList}) : super(key: key);
  @override
  State<Validators> createState() => _ValidatorsState();
}

class _ValidatorsState extends State<Validators> {
  final ValidatorController _validatorController =
      Get.put(ValidatorController());
  final NetworkController networkController=Get.put(NetworkController());
  final ValToggleController _valToggleController =Get.put(ValToggleController());
  TextEditingController nameController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  String fullName = '';
  var validators;
  var activeVal;
  var inactiveVal;
  bool isLoaded=false;
  int activeValSelected=0;

  @override
  void initState() {
    super.initState();
    valData();
  }
  void valData() async {
    final result = await networkController.fetchList(widget.networkList!.validatorsUrl!);

    if (result['success'] == false) {
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error",
            style: kMediumTextStyle,),
            content: Text(result['response'],style:kMediumBoldTextStyle),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
    if(result['success'] == true) {

      validators = List.from(result['response'])
          .map((e) => ValidatorModel.fromJson(e))
          .toList()
          .reversed
          .toList()
          .obs;
    }

    validators =
        await _validatorController.fetchVal(widget.networkList!.validatorsUrl!);
   setState(() {
     if(validators!=null){
       isLoaded=true;
     }
     else {
       isLoaded=false;
     }
   }
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDraw(networkData: widget.networkList),
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Validators',
                  style: kBigBoldTextStyle),
              CircleAvatar(
                  radius:15,
                  child: InkWell(
                      onTap: ()=> Navigator.of(context).popUntil((route) => route.isFirst),
                      child: Image.network(widget.networkList!.logoUrl??widget.networkList!.logUrl!)),
                  backgroundColor: Colors.transparent),
            ],
          ),
        ),
        body: Column(children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GetBuilder<ValToggleController>(
                  builder: (valController) {
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
                      activeFgColor: Colors.blue,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: Colors.grey,
                      initialLabelIndex: valController.isActiveSelected == 0 ?0:1,
                      totalSwitches: 2,
                      labels: const ['Active', 'Inactive'],
                      radiusStyle: true,
                      onToggle: (index) {
                        activeValSelected = index!;
                      _valToggleController.updateData(index);
                      },
                    );
                  }
                ),
              ],
            ),
          ),
          isLoaded?
          GetBuilder<ValToggleController>(

            builder: (valController) {
              return valController.isActiveSelected==0?
              Expanded(
                child: ListView.builder(
                    // reverse: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    //controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ValidatorController.activeValidatorsList.length,
                    itemBuilder: (BuildContext context, int index) {

                      return  ValidatorContainer (validatorModel: ValidatorController.activeValidatorsList[index]);
                    }),
              ):Expanded(
                child: ListView.builder(
                // reverse: true,
                physics: const AlwaysScrollableScrollPhysics(),
                //controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ValidatorController.inActiveValidatorsList.length,
                itemBuilder: (BuildContext context, int index) {


                  return  ValidatorContainer (validatorModel: ValidatorController.inActiveValidatorsList[index]);
                }),
              );
            }
          ):
          Center(child: const CircularProgressIndicator())
        ]));
  }
}

class ValidatorContainer extends StatelessWidget {
  final ValidatorModel? validatorModel;
  const ValidatorContainer({
    Key? key, this.validatorModel
  }) : super(key: key);

  @override

  Widget build(BuildContext context) {
    validatorModel!.jailedUntil;
    return InkWell(
      onTap: ()=> Get.to(() =>ValidatorDetails(validatorModel: validatorModel,)),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20)),
        //height: MediaQuery.of(context).size.height/2.6,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: kBoxDecorationWithGradient,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(

                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius:15,
                              child:Image.asset('assets/images/groups_FILL0_wght400_GRAD0_opsz48.png'),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(width:10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width:150,
                                child: Text(validatorModel!.moniker!,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: kBigBoldTextStyle),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(200.0)),
                          border: Border.all(
                            color: Colors.lightBlueAccent
                                .withOpacity(.3),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (Container(
                            height:160,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(200.0)),
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
                                  padding:
                                      const EdgeInsets.all(25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(validatorModel!.votingPower!,
                                          style:
                                              kMediumBoldTextStyle),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text('Voting Power',
                                          style: kSmallTextStyle),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      const BorderRadius.all(
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
                    ],
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Uptime',
                              style: kSmallTextStyle,
                            ),
                            Text(
                              '${validatorModel!.missedBlocksCounter!} blocks missed',
                              style: kSmallBoldTextStyle,
                            )
                          ],
                        ),
                        // Column(
                        //   crossAxisAlignment:
                        //       CrossAxisAlignment.start,
                        //   children: [
                        //     Text('Participation',
                        //         style: kSmallTextStyle),
                        //     Text(
                        //       ' 5/7',
                        //       style: kSmallBoldTextStyle,
                        //     ),
                        //   ],
                        // ),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Commission',
                              style: kSmallTextStyle,
                            ),
                            Text(
                            '${truncateToDecimalPlaces(double.parse(validatorModel!.commission!)*100,2).toString()}%',
                              style: kSmallBoldTextStyle,
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
    );
  }
}
