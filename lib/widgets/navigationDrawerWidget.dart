import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/Screens/network/parameters.dart';
import 'package:zenscape_app/Screens/network/validators.dart';
import 'package:zenscape_app/Screens/network/blocks.dart';
import 'package:zenscape_app/Screens/network/proposals.dart';
import 'package:zenscape_app/screens/network/dashboard.dart';
import '../Screens/network/contracts.dart';
import '../backend_files/networkList.dart';

class NavDraw extends StatefulWidget {
  final NetworkList? networkData;
  final String? logoUrl;
  const NavDraw({ this.networkData,this.logoUrl});

  @override
  _NavDrawState createState() => _NavDrawState();
}

int selectedIndex = 0;
class _NavDrawState extends State<NavDraw> {
  @override
  void initState() {
    super.initState();
   //selectedIndex = 0;
   }

  @override
  Widget build(BuildContext context) {
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
                => Navigator.of(context).popUntil((route) => route.isFirst),
                child: Container(
                  height: 100,
                  color: Colors.transparent,
                  child: DrawerHeader(
                    child:Image.asset('assets/images/img.png'),
                      margin: const EdgeInsets.fromLTRB(0, 0, 140, 0),
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration()),
                ),
              ),
              _createDrawerItem(
                  image: 'assets/images/home_FILL0_wght400_GRAD0_opsz48.png',
                  text: 'Home',
                  isSelected: selectedIndex == 8,
                  onTap: () {
                    setState(() {
                      selectedIndex = 8;
                    });
                    Navigator.of(context).popUntil((route) => route.isFirst);

                  }),
              _createDrawerItem(
                  image: 'assets/images/dashbd.png',
                  text: 'Dashboard',
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>NetworkDashBoard(networkData:widget.networkData)));
                  }),
              _createDrawerItem(
                  image: 'assets/images/val.png',
                  text: 'Validators',
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Validators(networkList:widget.networkData)));
                  }),
              _createDrawerItem(
                  image: 'assets/images/blocks.png',
                  text: 'Blocks',
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Blocks(networkData:widget.networkData)));
                  }),
              _createDrawerItem(
                  image: 'assets/images/props.png',
                  text: 'Proposals',
                  isSelected: selectedIndex == 3,
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                    Navigator.of(context).pop();
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>Proposals(networkListProposal:widget.networkData ,)));
                  }),
              // _createDrawerItem(
              //     image: 'assets/images/ibc.png',
              //     text: 'IBC Relayers',
              //     isSelected: selectedIndex == 4,
              //     onTap: () {
              //       setState(() {
              //         selectedIndex = 4;
              //       });
              //       Navigator.of(context).pop();
              //       Navigator.push(context, CupertinoPageRoute(builder: (context)=> IBCRelayers(networkData:widget.networkData)));
              //     }),
              // _createDrawerItem(
              //     image: 'assets/images/assets.png',
              //     text: 'Assets',
              //     isSelected: selectedIndex == 5,
              //     onTap: () {
              //       setState(() {
              //         selectedIndex = 5;
              //       });
              //       Navigator.of(context).pop();
              //       Navigator.push(context, CupertinoPageRoute(builder: (context)=> Assets(networkData:widget.networkData)));
              //     }),
              _createDrawerItem(
                  image:'assets/images/contracts.png',
                  text: 'Smart Contracts',
                  isSelected: selectedIndex == 6,
                  onTap: () {
                    setState(() {
                      selectedIndex = 6;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Contracts(networkList:widget.networkData)));
                  }),
              _createDrawerItem(
                  image: 'assets/images/params.png',
                  text: 'Parameters',
                  isSelected: selectedIndex == 7,
                  onTap: () {
                    setState(() {
                      selectedIndex = 7;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Parameters(networkList:widget.networkData)));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _createDrawerItem(
    {String? image, String? text, GestureTapCallback? onTap, required bool isSelected}) {
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