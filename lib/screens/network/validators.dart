import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/backend_files/validatorsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/widgets/navigationDrawerWidget.dart';
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
  TextEditingController nameController = TextEditingController();
  String fullName = '';
  var validators;
  var activeVal;
  var inactiveVal;
  bool isLoaded=false;
  @override
  void initState() {
    super.initState();
    valData();
  }

  void valData() async {
    validators =
        await _validatorController.fetchVal(widget.networkList!.validatorsUrl!);
   setState(() {
     if(validators!=null){
       isLoaded=true;
     }
     else {
       isLoaded=false;
     }
   });
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
              Text('Validators', style: kBigBoldTextStyle),
              CircleAvatar(
                  radius:15,
                  child: InkWell(
                      onTap: ()=> Navigator.of(context).popUntil((route) => route.isFirst),
                      child: Image.network(widget.networkList!.logoUrl??widget.networkList!.logUrl!)),
                  backgroundColor: Colors.transparent),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child:Column(children: [
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
                      contentPadding: const EdgeInsets.all(15),
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
                        //you can access nameController in its scope to get
                        // the value of text entered as shown below
                        //fullName = nameController.text;
                      });
                    },
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ToggleSwitch(
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
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: const ['Active', 'Inactive'],
                    radiusStyle: true,
                    onToggle: (index) {},
                  ),
                ],
              ),
            ),
            isLoaded?  ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ValidatorController.validatorsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return  ValidatorContainer (validatorModel: ValidatorController.validatorsList[index]);
                }):const CircularProgressIndicator()
          ]),
        ));
  }
}

class ValidatorContainer extends StatelessWidget {
  final ValidatorModel? validatorModel;
  const ValidatorContainer({
    Key? key, this.validatorModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            child: Image.network(
                                validatorModel!.avatarUrl?? 'https://picsum.photos/200/300'),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(width:5),
                          Text(validatorModel!.moniker!,
                              style: kBigBoldTextStyle),
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
                                  children: [
                                    Text('4407436',
                                        style:
                                            kMediumBoldTextStyle),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text('+4.29%',
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
                            "Uptime",
                            style: kSmallBoldTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text('Partcipation',
                              style: kSmallTextStyle),
                          Text(
                            ' 5/7',
                            style: kSmallBoldTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Commission',
                            style: kSmallTextStyle,
                          ),
                          Text(
                           truncateToDecimalPlaces(double.parse(validatorModel!.commission!),2).toString(),
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
    );
  }
}
