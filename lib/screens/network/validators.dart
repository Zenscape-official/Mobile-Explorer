import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/backend_files/validatorsModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/navController.dart';
import 'package:zenscape_app/controller/networklistController.dart';
import 'package:zenscape_app/screens/network/validatorDetails.dart';
import 'package:zenscape_app/widgets/navigationDrawerWidget.dart';
import '../../controller/valToggleController.dart';
import '../../controller/validatorsController.dart';
import '../../widgets/searchBarWidget.dart';

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
  NavController navController = Get.put(NavController());
  String fullName = '';
  List<ValidatorModel>? validators=[];
  List<ValidatorModel> activeVal=[];
  List<ValidatorModel> inActiveVal=[];

  bool isLoaded=false;
  int activeValSelected=0;
  var totalVoting=1;
  int pageIndex=1;

  @override
  void initState() {
    super.initState();
    valData();
    navController.updatePage(2);
  }
  void valData() async {

    validators =
        await _validatorController.fetchVal(widget.networkList!.validatorsUrl!,widget.networkList!.valStatus!);
   setState(() {
     if(validators!=null){
       isLoaded=true;
     }
     else {
       isLoaded=false;
     }
   }
   );
   for (int i=0;i<validators!.length;i++){
     totalVoting+=validators![i].votingPower!;
   }
  }


  @override
  Widget build(BuildContext context) {
    ValidatorController.activeValidatorsList.sort((b, a) => b.votingPower.compareTo(a.votingPower));
    ValidatorController.inActiveValidatorsList.sort((b, a) => b.votingPower.compareTo(a.votingPower));
    return Scaffold(
        drawer: NavDraw(networkData: widget.networkList,pageIndex: pageIndex,),
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
                     // onTap: ()=> Navigator.of(context).popUntil((route) => route.isFirst),
                      child: Image.network(widget.networkList!.logoUrl??widget.networkList!.logUrl!)),
                  backgroundColor: Colors.transparent),
            ],
          ),
        ),
        body: Column(children: [
          SearchBar(nameController:nameController,hintText: 'Enter Block Height,Tx hash, Address..',networkList: widget.networkList!,),

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
                child: CupertinoScrollbar(child:ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ValidatorController.activeValidatorsList.length,
                    itemBuilder: (BuildContext context, int index) {

                      return  ValidatorContainer (validatorModel: ValidatorController.activeValidatorsList.reversed.toList()[index],totalVoting:totalVoting,status: 'Active',denom:widget.networkList!.denom!);
                    })),
              ):Expanded(
                child: CupertinoScrollbar(
                  child: ListView.builder(
                  // reverse: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: ValidatorController.inActiveValidatorsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  ValidatorContainer (validatorModel: ValidatorController.inActiveValidatorsList.reversed.toList()[index],totalVoting:totalVoting,status: 'Inactive',denom:widget.networkList!.denom!);
                  }),
                ),
              );
            }
          ):
          Center(child: const CircularProgressIndicator()),
          SizedBox(height:14),
        ]));
  }
}

class ValidatorContainer extends StatelessWidget {
  final ValidatorModel? validatorModel;
  final int? totalVoting;
  final String? status;
  final String? denom;
  const ValidatorContainer({
    Key? key, this.validatorModel,this.totalVoting,this.status,this.denom
  }) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (context) => ValidatorDetails(validatorModel: validatorModel,totalVoting: totalVoting,status: status,denom:denom))),
      child: Column(
        children: [

          Container(
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
                        children: [
                          SingleChildScrollView(

                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child:validatorModel!.avatarUrl==null?Image.asset('assets/images/groups_FILL0_wght400_GRAD0_opsz48.png'):
                                  CachedNetworkImage(
                                    imageUrl: validatorModel!.avatarUrl ??
                                        validatorModel!.avatarUrl!,
                                    height: 40,
                                    width: 40,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),),
                                const SizedBox(width:10),

                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width:180,
                                    height: 22,

                                    child: Text(validatorModel!.moniker!,
                                        style: kMediumBoldTextStyle),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(validatorModel!.votingPower!.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                                  style:
                                  kMediumBoldTextStyle),
                              const SizedBox(
                                height: 4,
                              ),
                              Text('${truncateToDecimalPlaces(validatorModel!.votingPower!/totalVoting!,2)*100}%',
                                  style: kSmallTextStyle),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Uptime',
                              style: kSmallTextStyle,
                            ),
                            Text(
                              '${validatorModel!.missedBlocksCounter!} blocks missed',
                              style: kSmallBoldTextStyle,
                            )
                          ]
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Commission',
                              style: kSmallTextStyle,
                            ),
                            Text(
                              '${truncateToDecimalPlaces(double.parse(validatorModel!.commission!)*100,2).toString()}%',
                              style: kSmallBoldTextStyle,
                            )

                          ]
                      ),
                    ),

                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
