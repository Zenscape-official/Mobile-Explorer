import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/contractModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/screens/network/contractDetails.dart';
import '../../backend_files/networkList.dart';
import '../../controller/contractController.dart';
import '../../widgets/navigationDrawerWidget.dart';
import '../../widgets/searchBarWidget.dart';

class Contracts extends StatefulWidget {
  final NetworkList? networkList;
  const Contracts({Key? key,this.networkList}) : super(key: key);
  @override
  State<Contracts> createState() => _ContractsState();
}
class _ContractsState extends State<Contracts> {
  final ContractController _contractController =
  Get.put(ContractController());

  var contracts;
  int pageIndex=4;
  bool isLoaded=false;
  @override
  void initState() {
    super.initState();
    contData();
  }

  void contData() async {
    contracts =
    await _contractController.fetchCont(widget.networkList!.contractsUrl!);
    setState(() {
      if(contracts!=null){
        isLoaded=true;
      }
      else {
        isLoaded=false;
      }
    });
  }
  TextEditingController nameController=TextEditingController();
  String fullName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:NavDraw(networkData:widget.networkList,pageIndex: pageIndex,),
      appBar: AppBar(
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Contracts',
                style:kBigBoldTextStyle),
            CircleAvatar(
                radius:15,
                child: InkWell(
                   // onTap: ()=> Navigator.of(context).popUntil((route) => route.isFirst),
                    child: Image.network(widget.networkList!.logoUrl??widget.networkList!.logUrl!)),
                backgroundColor: Colors.transparent),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(nameController:nameController),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text('Popular Contracts',style: kMediumTextStyle,),
                ],
              ),
            ),

             isLoaded?ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ContractController.ContractList.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    ContractContainer(contractModel: ContractController.ContractList[index],);
                }
                ):
             CircularProgressIndicator(),
            SizedBox(height:30),
          ],
        ),
      ),
    );
  }
}

class ContractContainer extends StatelessWidget {
  final ContractModel? contractModel;
  const ContractContainer({
    Key? key, this.contractModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> Navigator.push(context, CupertinoPageRoute(builder: (context) => ContractDetails(contractModel: contractModel,))),
      child: Container(
        decoration: kBoxDecorationWithGradient,
        margin: const EdgeInsets.all(14),
        child: Column(
            children:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Row(
                        children: [
                          CircleAvatar(radius:10,backgroundColor: Colors.transparent,child: SvgPicture.asset('assets/svgfiles/description_FILL0_wght400_GRAD0_opsz48.svg',color: Colors.black,)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(contractModel!.label!,
                                style:kMediumTextStyle),
                          ),],
                      ),
                    ]
                ),

              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,4,8,8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Contract',
                          style:kSmallTextStyle),
                      Text('CW20 Contract',
                          style:kSmallTextStyle)
                    ]
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Contract Address',
                          style:kSmallTextStyle),
                      Text(dotRefactorFunction(contractModel!.contractAddress!),
                          style:kSmallTextStyle)
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,4.0,8,12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Instantiated at',
                          style:kSmallTextStyle),
                      Text(dateTime(contractModel!.instantiatedAt!),
                          style:kSmallTextStyle)
                    ]
                ),

              ),

            ]
        ),
      ),
    );
  }
}
