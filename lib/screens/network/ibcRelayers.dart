import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend%20files/ibcRelayersModel.dart';
import 'package:zenscape_app/backend%20files/networkList.dart';
import 'package:zenscape_app/controller/ibcController.dart';
import 'package:zenscape_app/screens/network/ibcDetails.dart';
import '../../Constants/constants.dart';
import '../../widgets/navigationDrawerWidget.dart';

class IBCRelayers extends StatefulWidget {
  NetworkList? networkData;
   IBCRelayers({Key? key,this.networkData}) : super(key: key);
  @override
  State<IBCRelayers> createState() => _IBCRelayersState();
}

class _IBCRelayersState extends State<IBCRelayers> {
  final IBCController _ibcController = Get.put(IBCController());

  var ibc;
  bool isLoaded=false;
  @override
  void initState() {
    super.initState();
    IBCData();
  }

  void IBCData() async {
    ibc =
    await _ibcController.fetchIBC(widget.networkData!.ibcUrl!);
    setState(() {
      if(ibc!=null){
        isLoaded=true;
      }
      else {
        isLoaded=false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var nameController;
    return Scaffold(
      drawer: NavDraw(networkData:widget.networkData),
      appBar: AppBar(
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('IBC Relayers',
                style:kBigBoldTextStyle),
            CircleAvatar(
                radius:15,
                child: Image.network(widget.networkData!.logoUrl??widget.networkData!.logUrl!),
                backgroundColor: Colors.transparent),
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
                      // setState(() {
                      //   //you can access nameController in its scope to get
                      //   // the value of text entered as shown below
                      //   //fullName = nameController.text;
                      // });
                    },
                  ),
                )),
            isLoaded?ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: IBCController.IBCList.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    IBCContainer(data: IBCController.IBCList[index]);
                }):CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class IBCContainer extends StatelessWidget {
Sendable? data;
IBCContainer({
    Key? key, this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> Get.to(() => const IBCDetails()),
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
                          CircleAvatar(radius:15,backgroundColor: Colors.transparent,child: Image.asset('assets/images/kava.png',)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data!.chainId!,
                                  style:kMediumBoldTextStyle),

                          ),],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightGreenAccent.withOpacity(.1),
                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                            color:  const Color(0xFF6BD68D),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8,1.0,8,1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CircleAvatar(backgroundColor: Colors.green,
                                radius: 3,),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text('Opened',
                                  style: kSmallTextStyle,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                ),

              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,

                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: kGradientColor,
                        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                        border: Border.all(
                          color:  Colors.lightBlueAccent,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8,1.0,8,1),
                        child: Row(
                          children:[
                            Row(
                              children: [
                                CircleAvatar(child: Image.asset('assets/images/kava.png'),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(' Cosmos',
                                        style: kMediumBoldTextStyle,),
                                      Text(' channel-227',
                                        style: kSmallTextStyle,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.lightBlueAccent,height: 2,thickness: 2,),
                    Container(
                      decoration: BoxDecoration(
                        gradient: kGradientColor,
                        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                        border: Border.all(
                          color:  Colors.lightBlueAccent,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8,1.0,8,1),
                        child: Row(
                          children:[
                            Row(
                              children: [
                                CircleAvatar(child: Image.asset('assets/images/kava.png'),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,


                                    children: [
                                      Text(' Cosmos',
                                        style: kMediumBoldTextStyle,),
                                      Text(' channel-227',
                                        style: kSmallTextStyle,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height:10),

              Padding(
                padding: const EdgeInsets.fromLTRB(8,2,8,2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Operational Period',
                          style:kSmallTextStyle),
                      Text('184 Days',
                          style:kSmallBoldTextStyle)
                    ]
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,2,8,2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('24 Txs',
                          style:kSmallTextStyle),
                      Text('110',
                          style:kSmallBoldTextStyle)
                    ]
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,2,8,15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('24h Value',
                          style:kSmallTextStyle),
                      Text('\$146,987,655',
                          style:kSmallBoldTextStyle)
                    ]
                ),
              ),
            ]
        ),
      ),
    );
  }
}
