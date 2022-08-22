import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/Screens/AkashNetwork/Parameters.dart';
import 'package:zenscape_app/Screens/AkashNetwork/Validators.dart';
import 'package:zenscape_app/Screens/AkashNetwork/assets.dart';
import 'package:zenscape_app/Screens/AkashNetwork/blocks.dart';
import 'package:zenscape_app/Screens/AkashNetwork/IBC%20Relayers.dart';
import 'package:zenscape_app/Screens/AkashNetwork/dashboard.dart';
import 'package:zenscape_app/Screens/AkashNetwork/proposals.dart';
import '../Controller/product_controller.dart';
import '../Screens/AkashNetwork/contracts.dart';
import '../Screens/AkashNetwork/transactions.dart';

bool isDataLoading=false;
class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  RxBool isSelected=false.obs;
  @override
  Widget build(BuildContext context) {
    const name = 'ZENSCAPE';

    return Drawer(
      child: Material(
        //color: Colors.lightBlueAccent,
        child: ListView(
          children: <Widget>[
            buildHeader(
              name: name,
              onClicked: ()
              => Navigator.of(context).popUntil((route) => route.isFirst)

            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Dashboard',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  buildMenuItem(
                    text: 'Validator',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  buildMenuItem(
                    text: 'Blocks',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  buildMenuItem(
                    text: 'Transactions',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  buildMenuItem(
                    text: 'Proposals',
                    icon: Icons.account_tree_outlined,
                    onClicked: () {
                      ProductController.fetchProducts();

                      if (ProductController.productList.isEmpty==true){
                       isDataLoading==true;

                      }
                      else{ selectedItem(context, 4);
                      }
                    }
                  ),

                  buildMenuItem(
                    text: 'IBC Relayers',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  buildMenuItem(
                    text: 'Assets',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  buildMenuItem(
                    text: 'Contracts',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  buildMenuItem(
                    text: 'Parameters',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.all(20)),
          child: Row(
            children: [
               Image.asset('assets/images/img.png'),
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color:  Colors.blue),
      title: Text(text, style: kSmallTextStyle),
      hoverColor: hoverColor,
      onTap: onClicked,
      // tileColor: Colors.lightBlueAccent,


    );
  }

  void selectedItem(BuildContext context, int index) {
   Get.back();

    switch (index) {
      case 0:
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>NetworkDashBoard()));
        break;
      case 1:
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Validators()));
        break;
      case 2:
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Blocks()));
        break;
      case 3:
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Txs()));
        break;
      case 4:
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>Proposals()));
        break;
      case 5:
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const IBCRelayers()));
        break;
      case 6:
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const Assets()));
        break;
        case 7:
          Navigator.of(context).pop();
          Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Contracts()));
        break;
      case 8:
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Parameters()));
        break;
      default:
        const CircularProgressIndicator();
    }
  }
}

class NavDraw extends StatefulWidget {
  const NavDraw({Key? key}) : super(key: key);

  @override
  _NavDrawState createState() => _NavDrawState();
}

int selectedIndex = 0;

class _NavDrawState extends State<NavDraw> {
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
                  image: 'assets/images/dashbd.png',
                  text: 'Dashboard',
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>NetworkDashBoard()));
                  }),
              _createDrawerItem(
                  image: 'assets/images/val.png',
                  text: 'Validator',
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Validators()));
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Blocks()));
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>Proposals()));
                  }),
              _createDrawerItem(
                  image: 'assets/images/IBC.png',
                  text: 'IBC Relayers',
                  isSelected: selectedIndex == 4,
                  onTap: () {
                    setState(() {
                      selectedIndex = 4;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const IBCRelayers()));
                  }),
              _createDrawerItem(
                  image: 'assets/images/props.png',
                  text: 'Assets',
                  isSelected: selectedIndex == 5,
                  onTap: () {
                    setState(() {
                      selectedIndex = 5;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Assets()));
                  }),
              _createDrawerItem(
                  image:'assets/images/contracts.png',
                  text: 'Smart Contracts',
                  isSelected: selectedIndex == 6,
                  onTap: () {
                    setState(() {
                      selectedIndex = 6;
                    });
                    Navigator.of(context).pop();
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Contracts()));
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Parameters()));
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