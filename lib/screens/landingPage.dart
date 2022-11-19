import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/bottomNavController.dart';
import 'package:zenscape_app/controller/dashboardController.dart';
import '../controller/networklistController.dart';
import 'network/dashboard.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Rx<List<NetworkList>> foundNetwork = Rx<List<NetworkList>>([]);
  final NetworkController networkController = Get.put(NetworkController());
  final DashboardController dashboardController = Get.put(DashboardController());

  // static void selectPage(BuildContext context,int index) {
  //   BottomNavigationScreenState? stateObject = context.findAncestorStateOfType<BottomNavigationScreenState>();
  //   stateObject?.setState((){
  //     bottomNavigationTabIndex = index;
  //   });
  // }

@override
  void initState() {
    super.initState();
     netData();
  foundNetwork.value=  [];
  }
  var flag=false;
  var results;
  var dash;
  var net;


  void filterList(String name) {
    if (name.isEmpty) {
      foundNetwork.value = net ;
    } else {
       foundNetwork.value = net
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
    }
    results=foundNetwork.value;
  }

  netData() async{
    net= await networkController.fetchList();
    dash= await dashboardController.fetchDash();
    setState(() {
      if (net!=null&& dash!=null){
        for (int i = 0; i < NetworkController.networkList.length - 1; i++) {
          for (int j = 0; j < DashboardController.dashboardList.length - 1; j++) {
            if (NetworkController.networkList[i].id ==
                DashboardController.dashboardList[j].id) {
              NetworkController.networkList[i].price =
                  DashboardController.dashboardList[j].currentPrice.toString();
              NetworkController.networkList[i].marketCap =
                  DashboardController.dashboardList[j].marketCap.toString();
              NetworkController.networkList[i].the24HrVol = DashboardController
                  .dashboardList[j].marketCapChange24H
                  .toString();
              NetworkController.networkList[i].percChangeInPrice =
                  DashboardController.dashboardList[j].priceChangePercentage24H
                      .toString();
            }
          }
        }
       flag=true;
      }
      else{
        flag=false;
      }
    });
  }

  TextEditingController nameController = TextEditingController();
  String fullName = '';
  List<String>? image = [];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hey there!',
              style: kBigBoldTextStyle,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        contentPadding: const EdgeInsets.only(
                            left: 8.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Colors.transparent,
                        focusedBorder: InputBorder.none,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (text) => filterList(text)),
                )),
            const SizedBox(
              height: 0,
            ),
           nameController.text.isEmpty? SizedBox(width:1): ListView.builder(
                shrinkWrap: true,
                itemCount : nameController.text.isEmpty ? 0: foundNetwork.value.length,
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  NetworkDashBoard(networkData: NetworkController.networkList[index]))),
                      child:ListTile(

                        title: Text(
                          foundNetwork.value[index].name!,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(foundNetwork.value[index].denom!),
                      ),
                    ),
           ),
            Container(
              margin: const EdgeInsets.only(
                  right: 10, top: 10, left: 10, bottom: 15),
              height: 199,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: kBoxDecorationWithGradient,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('assets/images/img.png'),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      'India\'s Most Valued \n Crypto Company',
                      style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              const Text('1 ',
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                      color: Colors.black)),
                              Column(
                                children: [
                                  Text('Crore +', style: kMediumBoldTextStyle),
                                  Text('Investors', style: kSmallTextStyle),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text('100%', style: kMediumBoldTextStyle),
                            Text('Transparent', style: kSmallTextStyle),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              const Text('1 ',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25,
                                      color: Colors.black)),
                              Column(
                                children: [
                                  Text('Crore +', style: kMediumBoldTextStyle),
                                  Text('Investors', style: kSmallTextStyle),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
         flag? Obx(() {

              return  StaggeredGridView.countBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 0,
                  itemCount: NetworkController.networkList.length,
                  itemBuilder: (context, index) {
                    return NetworkCard(NetworkController.networkList[index]);
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1));
            }):Column(
              children: const [SizedBox(height: 80,),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NetworkCard extends StatefulWidget {
  final NetworkList networkList;
  const NetworkCard(this.networkList);
  @override
  State<NetworkCard> createState() => _NetworkCardState();
}

class _NetworkCardState extends State<NetworkCard> {

  @override
  Widget build(BuildContext context) {
    final NavController navController=Get.put(NavController());
        return InkWell(

          onTap: ()=> {
          navController.changeIndex(1),
            print(navController.selectedIndex),
             Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        NetworkDashBoard(networkData: widget.networkList)))
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: kBoxDecorationWithoutGradient,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 15, 5),
                        child: CircleAvatar(
                          child: Image.network(widget.networkList.logoUrl ??
                              widget.networkList.logUrl!),
                          radius: 15,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.networkList.denom!,
                              style: kMediumBoldTextStyle),
                          Text(widget.networkList.name!, style: kSmallTextStyle),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('APR', style: kExtraSmallTextStyle),
                            const SizedBox(height: 2),
                            Text(widget.networkList.apy!,
                                style: kMediumBoldTextStyle),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price', style: kExtraSmallTextStyle),
                            const SizedBox(height: 2),
                            Text(truncateToDecimalPlaces(double.parse(widget.networkList.price!),2).toString(),
                                style: kMediumBoldTextStyle),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}