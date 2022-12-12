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
import '../controller/searchController.dart';
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
  final SearchController searchController=Get.put(SearchController());
  var flag=false;
  var dash;
  var net;

@override
  void initState() {
    super.initState();
     netData();
 // print(foundNetwork.value);
  }
  final svgPath=['assets/svgfiles/ZENSCAPE_BANNER_APP.svg',
    'assets/svgfiles/BANNER_2.svg'];
final pngPath=['assets/images/banner_zenscape.png','assets/images/banner2.png'];
  void filterList(String name) async{
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
  netData() async{
   final result= await networkController.fetchList('https://dfcrpylw0p0vw.cloudfront.net/networkList.json');
      if (result['success'] == false)
      {
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

   if(result['success'] == true) {
      net = List.from(result['response'])
          .map((e) => NetworkList.fromJson(e))
          .toList()
          .obs;

      dash = await dashboardController.fetchDash();
      setState(() {
        if (dash != null) {
          for (int i = 0 ; i < net.length - 1 ; i++) {

            for (int j = 0; j < DashboardController.dashboardList.length - 1;
                j++) {
              if (net[i].id ==
                  DashboardController.dashboardList[j].id) {
                net[i].price = DashboardController
                    .dashboardList[j].currentPrice
                    .toString();
                net[i].marketCap =
                    DashboardController.dashboardList[j].marketCap.toString();
                net[i].the24HrVol =
                    DashboardController.dashboardList[j].marketCapChange24H
                        .toString();
                net[i].percChangeInPrice =
                    DashboardController
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
        child: RefreshIndicator(
          onRefresh: ()async{
            await netData();
          },
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
                              onChanged:
                                  (text) {
                                    filterList(text);
                              }
                          ),
                      ),
                    ),

               nameController.text.isEmpty?
               const SizedBox(width:0):
               ListView.builder(
                    shrinkWrap: true,
                    itemCount : nameController.text.isEmpty ? 0: foundNetwork.value.length,
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      NetworkDashBoard(networkData:foundNetwork.value[index]
                                      )
                              )
                          ),
                          child:ListTile(
                            title: Row(
                              children: [
                                ClipOval(child: Image.network(foundNetwork.value[index].logoUrl??foundNetwork.value[index].logUrl!,
                                fit: BoxFit.fill,
                                  height: 20,
                                  width: 20,
                                )),
                                const SizedBox(width: 15,),
                                Text(
                                  foundNetwork.value[index].name!,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            subtitle: Text(foundNetwork.value[index].denom!,
                            style:  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                          ),
                        ),
               ),
                Column(
                  children: <Widget>[
                    CarouselSlider.builder(
                      itemCount: 2,

                      itemBuilder:(context,index,realIndex) {
                        final svgImage=svgPath[index];
                        return
                        buildSvgPicture(svgImage,index);
                      },
                      options:CarouselOptions(
                          viewportFraction: .95,
                       // height: 200,
                      autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false
                    )
                    ),
                  ],
                ),
             flag?
             Obx(() {
                  return  Padding(
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
                        staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),
                  );
                }):Column(
                  children: const [SizedBox(height: 80,),
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }

  Widget buildSvgPicture(String urlImage, int index) {
   // return
      // Image.asset(urlImage,height: 20,
      // fit: BoxFit.cover,);
    return SvgPicture.asset(
                          urlImage,
                          height: 200,
                          width: MediaQuery.of(context).size.width ,
                          //allowDrawingOutsideViewBox: false,
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
  void initstate() {
    super.initState();

  }
  double APR = 0;
  String image='';

  @override
  Widget build(BuildContext context) {
    image= getImage(widget.networkList.id!);
        return InkWell(
          onTap: ()=> {
             Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        NetworkDashBoard(networkData: widget.networkList)
                )
             )
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: const EdgeInsets.fromLTRB(10, 10, 10,10),
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
                        child: Container(
                          color: Colors.transparent,
                          height: 40,
                          width: 40,
                          child: ClipOval(
                              child: Image.asset(image)
                              // CachedNetworkImage(
                              //   imageUrl: widget.networkList.logoUrl??widget.networkList.logUrl!,
                              //   height: 40,
                              //   width: 40,
                              //   placeholder: (context, url) => CircularProgressIndicator(),
                              //   errorWidget: (context, url, error) => Icon(Icons.error),
                              // ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('APR', style: kExtraSmallTextStyle),
                            const SizedBox(height: 2),
                            Text(truncateToDecimalPlaces(APR,2).obs.toString(),
                                style: kMediumBoldTextStyle),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price', style: kExtraSmallTextStyle),
                            const SizedBox(height: 2),
                            Text('\$${truncateToDecimalPlaces(double.parse(widget.networkList.price!),2).toString()}',
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