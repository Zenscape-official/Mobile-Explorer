import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/Screens/AkashNetwork/Parameters.dart';
import 'package:zenscape_app/Screens/AkashNetwork/Validators.dart';
import 'package:zenscape_app/Screens/AkashNetwork/assets.dart';
import 'package:zenscape_app/Screens/AkashNetwork/blocks.dart';
import 'package:zenscape_app/Screens/AkashNetwork/IBC%20Relayers.dart';
import 'package:zenscape_app/Screens/AkashNetwork/dashboard.dart';
import 'package:zenscape_app/Screens/AkashNetwork/proposals.dart';
import 'package:zenscape_app/Screens/landing_page.dart';
import '../Controller/product_controller.dart';
import '../Screens/AkashNetwork/contracts.dart';
import '../Screens/AkashNetwork/transactions.dart';

bool isDataLoading=false;
class NavigationDrawerInWidget extends StatefulWidget {
  const NavigationDrawerInWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerInWidget> createState() => _NavigationDrawerInWidgetState();
}

class _NavigationDrawerInWidgetState extends State<NavigationDrawerInWidget> {
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
              => Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const LandingPage())),

            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'DASHBOARD',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  buildMenuItem(
                    text: 'VALIDATOR',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  buildMenuItem(
                    text: 'BLOCKS',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  buildMenuItem(
                    text: 'TRANSACTIONS',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  buildMenuItem(
                      text: 'PROPOSALS',
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
                    text: 'IBC RELAYERS',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  buildMenuItem(
                    text: 'ASSETS',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  buildMenuItem(
                    text: 'CONTRACTS',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  buildMenuItem(
                    text: 'PARAMETERS',
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
              // backgroundImage: AssetImage('lib/Symbol.png')),
            ],
          ),
        ),
      );
//for building a searchtab in the navdrawer
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
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Validators()));
        break;
      case 2:
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Blocks()));
        break;
      case 3:
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Txs()));
        break;
      case 4:
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>Proposals()));
        break;
      case 5:
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const IBCRelayers()));
        break;
      case 6:
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const Assets()));
        break;
      case 7:
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Contracts()));
        break;
      case 8:
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Parameters()));
        break;
      default:
        const CircularProgressIndicator();
    }
  }
}