import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend%20files/contractModel.dart';
import 'package:zenscape_app/constants/constants.dart';
import '../../backend files/networkList.dart';
import '../../controller/ContractController.dart';
import '../../widgets/navigationDrawerWidget.dart';
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
      drawer:NavDraw(networkData:widget.networkList),
      appBar: AppBar(
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('CONTRACTS',
                style:kBigTextStyle),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
                width: MediaQuery.of(context).size.width/1.1,
                height: 40,
                decoration: kBoxDecorationWithoutGradient,
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      filled: true,
                      fillColor: Colors.transparent,
                      focusedBorder: InputBorder.none,
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
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
                }):CircularProgressIndicator(),
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
    return Container(
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
                        CircleAvatar(radius:10,backgroundColor: Colors.transparent,child: Image.asset('assets/images/neta.png',color: Colors.black,)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(contractModel!.label!,
                              style:kMediumTextStyle),
                        ),],
                    ),

                    Container(
                      decoration: kBoxDecorationWithoutGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('10s ago',
                            style:TextStyle(
                                color: Colors.black.withOpacity(.5),
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    )
                  ]
              ),

            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
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
                    Text(function(contractModel!.contractAddress!),
                        style:kSmallTextStyle)
                  ]
              ),

            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,4.0,8,8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Executes',
                        style:kSmallTextStyle),
                    Text('',
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
    );
  }
}
