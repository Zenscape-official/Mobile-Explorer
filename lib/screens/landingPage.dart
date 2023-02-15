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
  var supply;

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
    'https://dfcrpylw0p0vw.cloudfront.net/images/banner_zenscape.png',
    'https://dfcrpylw0p0vw.cloudfront.net/images/StakeBanner.png'
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
          for(int i = 0; i < net.length; i++){
            for (int j = 0; j < DashboardController.dashboardList.length; j++) {
              if (net[i].id == DashboardController.dashboardList[j].id) {
                net[i].price = DashboardController.dashboardList[j].currentPrice
                    .toString();
                net[i].marketCap =
                    DashboardController.dashboardList[j].marketCap.toString();
                net[i].the24HrVol = DashboardController
                    .dashboardList[j].totalVolume
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
      }
      );
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
              // SearchBar(nameController: nameController,hintText: 'Enter Tx hash, Address...'),
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
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false),
                      itemCount: 2,
                      itemBuilder: (context, index, realIndex) {
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
                          ),
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
      child: Image.network(
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
  double APR = 1;
  String image = '';
  String? supply;
  var bondedToken;
  var inflation='0';
  var bankTotal;
  bool APRLoaded=false;
  var epoch_provision;
  var curr_supply;

  getAPR() async {
    if(widget.networkList.uDenom=='uatom'){
      supply = (await _dashboardController.fetch2PathData(widget.networkList.height!,'amount', 'amount'));
    }
    else{
      supply = (await _dashboardController.fetch2PathData(widget.networkList.height!, 'result', 'amount'));}

    bondedToken = await _dashboardController.fetchdata(
    widget.networkList.bondedTokens!, 'bonded_tokens');
    if(widget.networkList.uDenom!='uosmo') {
      inflation = (await _dashboardController.fetchdata(
          widget.networkList.inflation!, 'value'));
    }
    else{
      epoch_provision=await _dashboardController.fetchSingleData('https://lcd-osmosis.whispernode.com/osmosis/mint/v1beta1/epoch_provisions', 'epoch_provisions');
      curr_supply=await _dashboardController.fetchSingleData('https://api-osmosis.imperator.co/supply/v1/osmo', 'amount');
      inflation=(((double.parse(epoch_provision) * 365 + double.parse(curr_supply))/double.parse(curr_supply))/1000000).toString();
    }

    if(widget.networkList.uDenom=='uosmo') {
      APR=double.parse(await _dashboardController.fetchOsmoAPR('https://api-osmosis.imperator.co/apr/v2/staking'));
    }
    else{
      if(supply!=null){
      setState(() {
        APR = ((double.parse(inflation) * double.parse(supply??'0')) /
            double.parse(bondedToken)) *
            100;
      });
    }}

    if(APR!=1){
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
                    NetworkDashBoard(networkData: widget.networkList,APR: APR,)
            )
        )
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
                            imageUrl:
                                widget.networkList.logUrl!,
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
                      Text(widget.networkList.denom.toString(),
                          style: kMediumBoldTextStyle),
                     Container(child: Text(widget.networkList.name.toString(), style: kSmallTextStyle))
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
                              '${truncateToDecimalPlaces(APR, 2).obs.toString()}%'
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
                              '${truncateToDecimalPlaces(APR, 2).obs.toString()}%'
                           , style: kLandingPageBoldTextStyle)
                            :SizedBox(
                             height: 15,
                             width: 15,
                             child: Container()),
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
