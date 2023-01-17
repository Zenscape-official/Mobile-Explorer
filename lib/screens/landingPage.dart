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
  List<NetworkList> activeNet=[];
  List<NetworkList> inactiveNet=[];

  @override
  void initState() {
    super.initState();
    netData();
  }

  final svgPath = [
    'assets/svgfiles/ZENSCAPE_BANNER_APP.svg',
    'assets/svgfiles/BANNER_2.svg'
  ];
  final pngPath = [
    'assets/images/banner_zenscape.png',
    'assets/images/banner2.png'
  ];

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
      for(int i=0;i<net.length;i++){
        if(net[i].isActive=='1'){
          activeNet.add(net[i]);}
          else if(net[i].isActive=='0'){
            inactiveNet.add(net[i]);
        }
      }
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
              SearchBar(nameController: nameController,hintText: 'Enter Tx hash, Address...'),
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
                        // final svgImage=svgPath[index];
                        final pngImage=pngPath[index];
                        return
                          buildPngPicture(pngImage,index);

                      }),
                ],
              ),
              flag
                  ?Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Active Chains',style: kMediumBoldTextStyle,),
                  ),
                    Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: StaggeredGridView.countBuilder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 2,
                                itemCount: activeNet.length,
                                itemBuilder: (context, index) {
                                  return NetworkCard(activeNet[index]);
                                },
                                staggeredTileBuilder: (index) =>
                                    const StaggeredTile.fit(1)),
                          ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('All Chains',style: kMediumBoldTextStyle,),
                  ),

                  Padding(
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
                  )

                ],
              ): Column(
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
  Widget buildSvgPicture(String urlImage, int index,) {
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
    supply =
    (await _dashboardController.fetchBankData(widget.networkList.height!));
    bondedToken = await _dashboardController.fetchdata(
    widget.networkList.bondedTokens!, 'bonded_tokens');
    inflation = (await _dashboardController.fetchdata(
    widget.networkList.inflation!, 'value'));

    for(int i=0;i<supply!.length;i++){
      if(supply![i].denom=='ucmdx'){
        bankTotal=supply![i].amount;
      }
    }
    APRcmdx = ((double.parse(inflation) * double.parse(bankTotal)) /
        double.parse(bondedToken)) *
        100;
    if(APRcmdx!=0){
      setState(() {
        APRLoaded=true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
        if(widget.networkList.isActive=='1'){
      getAPR();
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
                      height:40,
                      width:40,
                      child: ClipOval(
                        child: Padding(
                          padding: widget.networkList.id=='chihuahua'? EdgeInsets.all(4.0):EdgeInsets.all(0.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.networkList.logoUrl ??
                                widget.networkList.logUrl!,
                            // height: 40,
                            // width: 40,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.networkList.isActive!='1'? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2.0),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text('APR', style: kExtraSmallTextStyle),
                          const SizedBox(height: 2),
                          Text(
                            //(widget.networkList.id!='comdex'?''
                              '${truncateToDecimalPlaces(APR, 2).obs.toString()}%'
                              //:'85.88%'
                              , style: kLandingPageBoldTextStyle),
                        ],
                      ),
                    ):
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2.0),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text('APR', style: kExtraSmallTextStyle),
                          const SizedBox(height: 2),
                       APRLoaded? Text(
                              '${truncateToDecimalPlaces(APRcmdx, 2).obs.toString()}%'
                           , style: kLandingPageBoldTextStyle)
                            :SizedBox(
                             height: 10,
                             width: 10,
                             child: LinearProgressIndicator()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2.0),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Price', style: kExtraSmallTextStyle),
                          const SizedBox(height: 2),
                          Text(
                              '\$${widget.networkList.price!}',
                              style: kLandingPageBoldTextStyle),
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
