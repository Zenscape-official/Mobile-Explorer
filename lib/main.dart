import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Screens/explorer.dart';
import 'package:zenscape_app/Screens/onboardingScreen.dart';
import 'package:zenscape_app/Screens/landingPage.dart';
import 'package:zenscape_app/controller/proposalsFunc.dart';
import 'Controller/productController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'backend files/networkList.dart';

dynamic initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = (prefs.getInt("initScreen"));
  runApp(const MyApp());
  await prefs.setInt("initScreen", 0);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'App Title',
      debugShowCheckedModeBanner: false,
      home:  initScreen ==null ? OnboardingPage():const MainApp()
    );
  }
}
enum TabItem {home,details, explore}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();

}
class _MainAppState extends State<MainApp> {

  @override

  Widget build(BuildContext context) {
    ProductController.fetchProducts();

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        inactiveColor: Colors.grey,
        currentIndex: 0,
        activeColor: Colors.lightBlueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 27,
               // color:Colors.lightBlueAccent
            ),label:('Home'),),
          BottomNavigationBarItem(icon: Icon(Icons.widgets_outlined,size: 27,
            //color: Colors.lightBlueAccent,
          ),
              label:('Zenscape')),
          BottomNavigationBarItem(icon: Icon(Icons.explore_rounded,size: 27,
            //color: Colors.lightBlueAccent,
          ),
              label:('Explorer'))
        ],
      ),
      tabBuilder: (context,index){
        switch(index) {
          case 0:
            return CupertinoTabView(builder: (context) {

              return const CupertinoPageScaffold(child: LandingPage());
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: LandingPage());
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(child: Webview());
            });
        }return Container();
      },
    );
  }
}
