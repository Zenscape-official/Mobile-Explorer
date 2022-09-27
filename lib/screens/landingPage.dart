import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/backend%20files/networkList.dart';
import '../Constants/constants.dart';
import '../controller/networklistController.dart';
import 'network/dashboard.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final NetworkController networkController = Get.put(NetworkController());
  var isLoaded = false;
  static var lists;
  var results;
  Rx<List<NetworkList>> foundNetwork = Rx<List<NetworkList>>([]);

  void filterList(String name) {
    if (name.isEmpty) {
      // foundNetwork.value = NetworkController.networkList;
    } else {
      foundNetwork.value = NetworkController.networkList
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
    }
    results=foundNetwork.value;
  }

  @override
  void initState() {
    super.initState();
    getData();
    networkController.fetchList();
    foundNetwork.value = NetworkController.networkList;
  }

  getData() async {
    // lists=await NetworkList.fetchList();
    if (lists != null) {
      setState(() {
        isLoaded = true;
      });
    } else {
      // print(lists);
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
                        //hintText: 'Select a chain',
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (text) => filterList(text)),
                )),
            const SizedBox(
              height: 20,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(foundNetwork.value[index].denom!),
                ),
              ),),
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
            Obx(() {
              return StaggeredGridView.countBuilder(
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
            }),
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
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  NetworkDashBoard(networkData: widget.networkList))),
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
                        Text('APY', style: kExtraSmallTextStyle),
                        const SizedBox(height: 2),
                        Text(widget.networkList.apy!,
                            style: kMediumBoldTextStyle),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Commission', style: kExtraSmallTextStyle),
                        const SizedBox(height: 2),
                        Text(widget.networkList.commission!,
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
