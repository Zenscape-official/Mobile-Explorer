import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/backend_files/validatorsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/toggleController.dart';
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
  final ToggleController _toggleController =Get.put(ToggleController());
  TextEditingController nameController = TextEditingController();
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
                  GetBuilder<ToggleController>(
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
                        initialLabelIndex: valController.isBlockSelected == 0 ?0:1,
                        totalSwitches: 2,
                        labels: const ['Active', 'Inactive'],
                        radiusStyle: true,
                        onToggle: (index) {
                          activeValSelected = index!;
                        _toggleController.updateData(index);
                        },
                      );
                    }
                  ),
                ],
              ),
            ),
            isLoaded?  GetBuilder<ToggleController>(

              builder: (valController) {
                return valController.isBlockSelected==0?
                ListView.builder(
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ValidatorController.activeValidatorsList.length,
                    itemBuilder: (BuildContext context, int index) {

                      return  ValidatorContainer (validatorModel: ValidatorController.activeValidatorsList[index]);
                    }):ListView.builder(
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ValidatorController.inActiveValidatorsList.length,
                    itemBuilder: (BuildContext context, int index) {

                      return  ValidatorContainer (validatorModel: ValidatorController.inActiveValidatorsList[index]);
                    });
              }
            ):const CircularProgressIndicator()
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
    validatorModel!.jailedUntil;
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
                            child:validatorModel!.avatarUrl==null?
                                Image.network(
                                validatorModel!.avatarUrl??'https://googleflutter.com/sample_image.jpg'):Image.asset('assets/images/groups_FILL0_wght400_GRAD0_opsz48.png'),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(width:5),
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
