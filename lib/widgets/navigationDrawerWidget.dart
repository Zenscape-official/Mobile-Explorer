import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/Screens/network/parameters.dart';
import 'package:zenscape_app/Screens/network/validators.dart';
import 'package:zenscape_app/Screens/network/blocks.dart';
import 'package:zenscape_app/Screens/network/proposals.dart';
import 'package:zenscape_app/controller/navController.dart';
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
int prevIndex=0;
class _NavDrawState extends State<NavDraw> {
  NavController navController=Get.put(NavController());
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
              // _createDrawerItem(
              //     image: 'assets/images/home_FILL0_wght400_GRAD0_opsz48.png',
              //     text: 'Home',
              //     isSelected: selectedIndex == 8,
              //     onTap: () {
              //
              //       setState(() {
              //         prevIndex=selectedIndex;
              //         selectedIndex = 8;
              //       });
              //       Navigator.of(context).popUntil((route) => route.isFirst);
              //
              //     }),
              _createDrawerItem(
                  image: 'assets/images/dashbd.png',
                  text: 'Dashboard',
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    print(ModalRoute.of(context));
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 0;
                    });
                    //Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> NetworkDashBoard(networkData:widget.networkData)))
                        .then((value) {
                      print(selectedIndex);
                      print(prevIndex);
                      setState(() {
                        selectedIndex= prevIndex;
                        Navigator.of(context).pop();
                      });
                    }
                    );
                  }),
              _createDrawerItem(
                  image: 'assets/images/val.png',
                  text: 'Validators',
                  isSelected: selectedIndex==1,
                  onTap: () {
                    print(ModalRoute.of(context));

                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 1;
                    });
                   // Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Validators(networkList:widget.networkData)))
                        .then((value) {
                      print(selectedIndex);
                      print(prevIndex);
                      setState(() {
                        selectedIndex= prevIndex;
                        Navigator.of(context).pop();
                      });
                    }
                    );
                  }),
              _createDrawerItem(
                  image: 'assets/images/blocks.png',
                  text: 'Blocks',
                  isSelected: selectedIndex==2,
                  onTap: () {
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 2;
                    });
                   // Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Blocks(networkData:widget.networkData))).then((value) {
                      print(selectedIndex);
                      print(prevIndex);
                      setState(() {
                        selectedIndex= prevIndex;
                        Navigator.of(context).pop();
                      });
                    }
                    );
                  }),
              _createDrawerItem(
                  image: 'assets/images/props.png',
                  text: 'Proposals',
                  isSelected: selectedIndex == 3,
                  onTap: () {
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 3;
                    });
                   // Navigator.of(context).pop();
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>Proposals(networkListProposal:widget.networkData ,))).then((value) {
        print(selectedIndex);
        print(prevIndex);
        setState(() {
          selectedIndex= prevIndex;
          Navigator.of(context).pop();
        });
      }
      );
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
                      prevIndex=selectedIndex;
                      selectedIndex = 6;
                    });
                   // Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> Contracts(networkList:widget.networkData))).then((value) {
                      print(selectedIndex);
                      print(prevIndex);
                      setState(() {
                        selectedIndex= prevIndex;
                        Navigator.of(context).pop();
                      });
                    }
                    );
                  }),
              _createDrawerItem(
                  image: 'assets/images/params.png',
                  text: 'Parameters',
                  isSelected: selectedIndex == 7,
                  onTap: () {
                    setState(() {
                      prevIndex=selectedIndex;
                      selectedIndex = 7;
                    });
                    //Navigator.of(context).pop();
                    Navigator.push(
                        context, CupertinoPageRoute(
                        builder: (context)=>
                            Parameters(networkList:widget.networkData)))
                        .then((value) {
                          print(selectedIndex);
                          print(prevIndex);
                         setState(() {
                           selectedIndex= prevIndex;
                           Navigator.of(context).pop();
                         });
                  }
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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../backend_files/networkList.dart';
// import '../routes/app_pages.dart';
//
// class NavDraw extends StatelessWidget {
//     final NetworkList? networkData;
//   final String? logoUrl;
//   const NavDraw({ this.networkData,this.logoUrl});
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         child: ListView(
//           children: [
//             buildDrawerHeader(),
//             Divider(
//               color: Colors.grey,
//             ),
//             buildDrawerItem(
//               icon: Icons.photo,
//               text: "DASHBOARD",
//               onTap: () => navigate(0),
//               tileColor: Get.currentRoute == Routes.DASHBOARD ? Colors.blue : null,
//               textIconColor: Get.currentRoute == Routes.DASHBOARD
//                   ? Colors.white
//                   : Colors.black,
//             ),
//             buildDrawerItem(
//               icon: Icons.video_call,
//               text: "VALIDATORS",
//               onTap: () => navigate(1),
//               tileColor: Get.currentRoute == Routes.VALIDATORS ? Colors.blue : null,
//               textIconColor: Get.currentRoute == Routes.VALIDATORS
//                   ? Colors.white
//                   : Colors.black,
//             ),
//             buildDrawerItem(
//                 icon: Icons.chat,
//                 text: "BLOCKS",
//                 onTap: () => navigate(2),
//                 tileColor: Get.currentRoute == Routes.BLOCKS ? Colors.blue : null,
//                 textIconColor: Get.currentRoute == Routes.BLOCKS
//                     ? Colors.white
//                     : Colors.black),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildDrawerHeader() {
//     return UserAccountsDrawerHeader(
//       accountName: Text("Ripples Code"),
//       accountEmail: Text("ripplescode@gmail.com"),
//       currentAccountPicture: CircleAvatar(
//         backgroundImage: AssetImage('image/logo.jpg'),
//       ),
//       currentAccountPictureSize: Size.square(72),
//       otherAccountsPictures: [
//         CircleAvatar(
//           backgroundColor: Colors.white,
//           child: Text("RC"),
//         )
//       ],
//       otherAccountsPicturesSize: Size.square(50),
//     );
//   }
//
//   Widget buildDrawerItem({
//     required String text,
//     required IconData icon,
//     required Color textIconColor,
//     required Color? tileColor,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: textIconColor),
//       title: Text(
//         text,
//         style: TextStyle(color: textIconColor),
//       ),
//       tileColor: tileColor,
//       onTap: onTap,
//     );
//   }
//
//   navigate(int index) {
//     if (index == 0) {
//       Get.toNamed(Routes.DASHBOARD);
//     }
//     else if (index == 1) {
//       Get.toNamed(Routes.VALIDATORS);
//     }
//     if (index == 2) {
//       Get.toNamed(Routes.BLOCKS);
//     }
//   }
// }