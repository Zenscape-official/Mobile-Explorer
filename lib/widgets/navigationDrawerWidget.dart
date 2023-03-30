import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/Screens/network/parameters.dart';
import 'package:zenscape_app/Screens/network/validators.dart';
import 'package:zenscape_app/Screens/network/proposals.dart';
import 'package:zenscape_app/controller/navController.dart';
import 'package:zenscape_app/screens/network/blocks.dart';
import 'package:zenscape_app/screens/network/dashboard.dart';
import 'package:zenscape_app/screens/network/ibcRelayers.dart';
import '../Screens/network/contracts.dart';
import '../backend_files/networkList.dart';
import '../controller/toggleController.dart';

class NavDraw extends StatefulWidget {
  final NetworkList? networkData;
  final String? logoUrl;
   final int? pageIndex;
  const NavDraw({ this.networkData,this.logoUrl, this.pageIndex});
  @override
  _NavDrawState createState() => _NavDrawState();
}


class _NavDrawState extends State<NavDraw> {
  int selectedIndex = 0;
  int prevIndex=0;
  NavController navController=Get.put(NavController());
  final ToggleController toggleController =Get.put(ToggleController());
  @override
  void initState() {
    super.initState();
   //selectedIndex = 0;
   }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.pageIndex!;
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
          child: ListView(
            children: <Widget>[
              InkWell(
                onTap: ()
                =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: Container(
                  height: 100,
                  color: Colors.transparent,
                  child: DrawerHeader(
                    child:Image.asset('assets/images/zenscapeLogoWhite.jpg'),
                      margin: const EdgeInsets.fromLTRB(0, 0, 140, 0),
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration()),
                ),
              ),
              // _createDrawerItem(
              //     image: 'assets/images/home_FILL0_wght400_GRAD0_opsz48.png',
              //     text: 'Home',
              //     isSelected: selectedIndex == 8,
              //     onTap: () {
              //       setState(() {
              //         prevIndex=selectedIndex;
              //         selectedIndex = 8;
              //       });
              //       Navigator.of(context).popUntil((route) => route.isFirst);
              //
              //     }),
              _createDrawerItem(
                pageIndex:widget.pageIndex,
                fetchData: widget.networkData,
                  context: context,

                  image: 'assets/images/dashbd.png',
                  text: 'Dashboard',
                  isSelected: selectedIndex==0,
                  onTap: () {
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 0;
                      print(widget.pageIndex);
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> NetworkDashBoard(networkData:widget.networkData)));

                  }),
              _createDrawerItem(
                  context: context,
                  image: 'assets/images/val.png',
                  text: 'Validators',
                  isSelected: widget.pageIndex==1,
                  onTap: () {

                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Validators(networkList:widget.networkData!)));

                  }),
              _createDrawerItem(
                  context: context,

                  image: 'assets/images/blocks.png',
                  text: 'Blocks',
                  isSelected:widget.pageIndex==2,
                  onTap: () {
                    toggleController.updateData(0);
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 2;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Blocks(networkData:widget.networkData,valDescUrl: widget.networkData!.blocksMoniker,)));

                  }),
              _createDrawerItem(
                  pageIndex: widget.pageIndex,
                  fetchData: widget.networkData,
                  context: context,
                  image: 'assets/images/props.png',
                  text: 'Proposals',
                  isSelected: widget.pageIndex==3,
                  onTap: () {
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 3;
                    });
                    Navigator.of(context).pop();
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>Proposals(networkListProposal:widget.networkData ,)));

                  }),
            widget.networkData!.uDenom=='uatom'||widget.networkData!.uDenom=='uosmo'?Container():  _createDrawerItem(
                  pageIndex: widget.pageIndex,
                  fetchData: widget.networkData,
                  context: context,
                  image:'assets/images/contracts.png',
                  text: 'Smart Contracts',
                  isSelected: widget.pageIndex==4,
                  onTap: () {
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 4;
                    });
                   Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Contracts(networkList:widget.networkData)));

                  }),
               _createDrawerItem(
                  pageIndex: widget.pageIndex,
                  fetchData: widget.networkData,
                  context: context,
                  image:'assets/images/contracts.png',
                  text: 'IBC Relayers',
                  isSelected: widget.pageIndex==5,
                  onTap: () {
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 5;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> IBCRelayers(networkData:widget.networkData)));

                  }),
              _createDrawerItem(
                  pageIndex: widget.pageIndex,
                fetchData: widget.networkData,
                context: context,
                  image: 'assets/images/params.png',
                  text: 'Parameters',
                  isSelected: widget.pageIndex==6,
                  onTap: () {

                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 6;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, CupertinoPageRoute(
                        builder: (context)=>
                            Parameters(networkList:widget.networkData)
                    )
                    );
                  }
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _createDrawerItem(
    {required BuildContext context,
      String? image,
      String? text,
     required GestureTapCallback onTap,
     required bool isSelected,

      var fetchData,
      int? pageIndex
    }) {

  return Ink(
    color: isSelected ? Color(0xFFD4F1FF) : Colors.transparent,
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: ListTile(
        selected: true,
        hoverColor: Colors.lightBlueAccent,
        title: Row(
          children: <Widget>[
            SizedBox(
                height: 20,
                child: Image.asset(image!,color: isSelected?Colors.black:Colors.grey)),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text!,style: isSelected?kSmallBoldTextStyle:kSmallTextStyle,),
            )
          ],
        ),
        onTap: onTap,
      ),
    ),
  );
}
