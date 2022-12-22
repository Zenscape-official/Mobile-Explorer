import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/networkList.dart';
import 'package:zenscape_app/constants/constants.dart';
import 'package:zenscape_app/controller/dashboardController.dart';
import '../constants/functions.dart';
import '../controller/networklistController.dart';
import '../widgets/searchBarWidget.dart';
import 'network/dashboard.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Rx<List<NetworkList>> foundNetwork = Rx<List<NetworkList>>([]);
  final NetworkController networkController = Get.put(NetworkController());
  final DashboardController dashboardController =
      Get.put(DashboardController());
  var flag = false;
  var dash;
  var net;

  @override
  void initState() {
    super.initState();
    netData();
    // print(foundNetwork.value);
  }

  final svgPath = [
    'assets/svgfiles/ZENSCAPE_BANNER_APP.svg',
    'assets/svgfiles/BANNER_2.svg'
  ];
 //late final containerList=[buildContainer1(),buildContainer2()];
  final pngPath = [
    'assets/images/banner_zenscape.png',
    'assets/images/banner2.png'
  ];
  void filterList(String name) async {
    if (name.isEmpty) {
      foundNetwork.value = net;
    } else {
      foundNetwork.value = net
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
      print(foundNetwork.value);
    }
  }

  netData() async {
    final result = await networkController
        .fetchList('https://dfcrpylw0p0vw.cloudfront.net/networkList.json');
    if (result['success'] == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(result['response']),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          );
        },
      );
    }

    if (result['success'] == true) {
      net = List.from(result['response'])
          .map((e) => NetworkList.fromJson(e))
          .toList()
          .obs;

      dash = await dashboardController.fetchDash();
      setState(() {
        if (dash != null) {
          for (int i = 0; i < net.length - 1; i++) {
            for (int j = 0;
                j < DashboardController.dashboardList.length - 1;
                j++) {
              if (net[i].id == DashboardController.dashboardList[j].id) {
                net[i].price = DashboardController.dashboardList[j].currentPrice
                    .toString();
                net[i].marketCap =
                    DashboardController.dashboardList[j].marketCap.toString();
                net[i].the24HrVol = DashboardController
                    .dashboardList[j].marketCapChange24H
                    .toString();
                net[i].percChangeInPrice = DashboardController
                    .dashboardList[j].priceChangePercentage24H
                    .toString();
              }
            }
          }
          flag = true;
        } else {
          flag = false;
        }
      });
    }
  }

  TextEditingController nameController = TextEditingController();
  String fullName = '';
  List<String>? image = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: RefreshIndicator(
          onRefresh: () async {
            await netData();
          },
          child: Column(
            children: [
              SearchBar(nameController: nameController),
              nameController.text.isEmpty
                  ? const SizedBox(width: 0)
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: nameController.text.isEmpty
                          ? 0
                          : foundNetwork.value.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => NetworkDashBoard(
                                    networkData: foundNetwork.value[index]))),
                        child: ListTile(
                          title: Row(
                            children: [
                              ClipOval(
                                  child: Image.network(
                                foundNetwork.value[index].logoUrl ??
                                    foundNetwork.value[index].logUrl!,
                                fit: BoxFit.fill,
                                height: 20,
                                width: 20,
                              )),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                foundNetwork.value[index].name!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            foundNetwork.value[index].denom!,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
              Column(
                children: <Widget>[
                  CarouselSlider.builder(
                      options: CarouselOptions(
                          viewportFraction: .9,
                          // height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false),
                      itemCount: 2,
                      itemBuilder: (context, index, realIndex) {
                        final svgImage=svgPath[index];

                        final pngImage=pngPath[index];
                        return
                          buildPngPicture(pngImage,index);
                          //containerList[index];
                      }),
                ],
              ),
              flag
                  ? Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 2,
                            itemCount: net.length,
                            itemBuilder: (context, index) {
                              return NetworkCard(net[index]);
                            },
                            staggeredTileBuilder: (index) =>
                                const StaggeredTile.fit(1)),
                      );
                    })
                  : Column(
                      children: const [
                        SizedBox(
                          height: 80,
                        ),
                        Center(child: CircularProgressIndicator()),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

// Widget buildContainer1() {
//     return Container(
//                           //margin: EdgeInsets.only(right: 10, top: 10),
//                           // height: 199,
//                           // width: 310,
//                           //decoration: kBoxDecorationWithGradient,
//
//                           child: Stack(
//                             children: <Widget>[
//                               SvgPicture.asset(
//                                 'assets/svgfiles/banner_background.svg',
//
//                                 width: MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height,
//                               ),
//                               Positioned(
//                                 top:20,
//                                 left:133,
//                                 //right:112,
//                                 child: Image.asset('assets/images/img.png',
//                                   height:40 ,
//                                   width: 80,),
//                               ),
//                               Positioned(
//                                 top:75,
//                                 left:23,
//                                 //right:112,
//                                 child: Image.asset('assets/images/banner_logos/osmosis.png',
//                                   height:40 ,
//                                   width: 80,),
//                               ),
//                               Positioned(
//                                 top:75,
//                                 left:133,
//                                 //right:112,
//                                 child: Image.asset('assets/images/banner_logos/persistence.png',
//                                   height:40 ,
//                                   width: 80,),
//                               ),
//                               Positioned(
//                                 bottom:65,
//                                 left:193,
//                                 //right:112,
//                                 child: Image.asset('assets/images/banner_logos/canto.png',
//                                   height:40 ,
//                                   width: 80,),
//                               ),
//                               Positioned(
//                                 bottom:69,
//                                 left:53,
//                                 //right:112,
//                                 child: SvgPicture.asset('assets/images/banner_logos/comdex.svg',
//                                   height:20 ,
//                                   width: 30,),
//                               ),
//                               // Positioned(
//                               //   bottom:69,
//                               //   left:33,
//                               //   //right:112,
//                               //   child: SvgPicture.asset('assets/images/banner_logos/mntl_logo.svg',
//                               //     height:20 ,
//                               //     width: 30,),
//                               // ),
//                               Positioned(
//                                 top:75,
//                                 right:20,
//                                 //right:112,
//                                 child: Image.asset('assets/images/banner_logos/rebus.png',
//                                   height:40 ,
//                                   width: 80,),
//                               ),
//                               Positioned(
//                                 top:60,
//                                 right:92,
//                                 child: Text('VALIDATING CHAINS',
//                                 style: kMediumTextStyle,),
//                               ),
//
//                             ],
//                           ),
//     );
//   }
//   Widget buildContainer2() {
//     return Container(
//       //margin: EdgeInsets.only(right: 10, top: 10),
//       // height: 199,
//       // width: 310,
//       //decoration: kBoxDecorationWithGradient,
//
//         child: Stack(
//           children: <Widget>[
//             SvgPicture.asset(
//               'assets/svgfiles/banner_background.svg',
//
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//             ),
//             Positioned(
//               top:0,
//               left:0,
//               right:0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 140),
//                 child: Image.asset('assets/images/img.png',
//                 height:40 ,
//                 width: 80,),
//               ),
//             ),
//             Positioned(
//               top:80,
//               right:72,
//               child: Text('Eat,Sleep,Stake,Repeat',
//                 style: kMediumBoldTextStyle,),
//             ),
//             Positioned(
//               bottom: 100,
//               right: 50,
//               child: Text('Join the staking ecosystem with Zenscape today',
//                 style: kExtraSmallTextStyle,
//             ),),
//
//             Positioned(
//                 bottom: 60,
//                 right: 120,
//                 // left: 0,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.lightBlueAccent,
//                     borderRadius: BorderRadius.circular(35),
//                     //border: Border.all(color: Colors.black),
//                   ),
//                   child: InkWell(
//                    onTap: null,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text('STAKE WITH US',
//                             style: TextStyle(
//                               fontFamily: 'MontserratRegular',
//                               color: Colors.white,
//                               fontWeight:  FontWeight.bold,
//                               fontSize: 10,
//                             ),
//                       ),
//                     ),
//                   ),
//                 )),
//
//           ],
//         ));
//   }

  Widget buildSvgPicture(String urlImage, int index,) {
    // return
    // Image.asset(urlImage,height: 20,
    // fit: BoxFit.cover,);
    return SvgPicture.asset(
      urlImage,
      height: 200,
      width: MediaQuery.of(context).size.width,
      //allowDrawingOutsideViewBox: false,
    );
  }
  Widget buildPngPicture(String urlImage, int index) {
    return InkWell(
      //onTap:()=>OnTap,
      child: Image.asset(
        urlImage,
        height: 200,
        width: MediaQuery.of(context).size.width,
        //allowDrawingOutsideViewBox: false,
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
  DashboardController _dashboardController=Get.put(DashboardController());
  NetworkController networkController =Get.put(NetworkController());
  void initstate() {
    super.initState();
    getAPR();
  }

  double APR = 0;
  double APRcmdx=0;
  String image = '';
  var supply;
  var bondedToken;
  var inflation;
  var bankTotal;
  bool APRLoaded=false;

  getAPR() async {
    final APR;
    supply =
    (await _dashboardController.fetchBankData(widget.networkList.height!));

    bondedToken = await _dashboardController.fetchdata(
    widget.networkList.bondedTokens!, 'bonded_tokens');

    inflation = (await _dashboardController.fetchdata(
    widget.networkList.inflation!, 'value'));
    print(supply);
    print(inflation);
    print(bondedToken);
    for(int i=0;i<supply!.length;i++){
      if(supply![i].denom=='ucmdx'){
        bankTotal=supply![i].amount;
      }
    }
    APR = ((double.parse(inflation) * double.parse(bankTotal)) /
        double.parse(bondedToken)) *
        100;
    if(APR!=null){
      setState(() {
        APRLoaded=true;
      });
    }
    //APRLoaded=true;
    return APR;
  }
  @override
  Widget build(BuildContext context) {
    if(widget.networkList.id=='comdex'&&APRLoaded){
     setState(() {
       APRcmdx=getAPR();
     });
    }
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    NetworkDashBoard(networkData: widget.networkList)))
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: kBoxDecorationWithoutGradient,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 15, 5),
                    child: Container(
                      color: Colors.transparent,
                      height: 40,
                      width: 40,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.networkList.logoUrl ??
                              widget.networkList.logUrl!,
                          height: 40,
                          width: 40,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
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
                    widget.networkList.id!='comdex'? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('APR', style: kExtraSmallTextStyle),
                        const SizedBox(height: 2),
                        Text(
                          //(widget.networkList.id!='comdex'?''
                            '${truncateToDecimalPlaces(APR, 2).obs.toString()}%'
                            //:'85.88%'
                            , style: kMediumBoldTextStyle),
                      ],
                    ):Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('APR', style: kExtraSmallTextStyle),
                        const SizedBox(height: 2),
                      Text(
                          //(widget.networkList.id!='comdex'?''
                           // '${truncateToDecimalPlaces(APRcmdx, 2).obs.toString()}%'
                            '85.88%'
                            , style: kMediumBoldTextStyle)
                          // :SizedBox(
                          //  height: 10,
                          //  width: 10,
                          //  child: LinearProgressIndicator()),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price', style: kExtraSmallTextStyle),
                          const SizedBox(height: 2),
                          Text(
                              '\$${truncateToDecimalPlaces(double.parse(widget.networkList.price!), 2).toString()}',
                              style: kMediumBoldTextStyle),
                        ],
                      ),
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
