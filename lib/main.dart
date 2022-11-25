import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Screens/onboardingScreen.dart';
import 'package:zenscape_app/controller/bottomNavController.dart';
import 'package:zenscape_app/controller/dashboardController.dart';
import 'package:zenscape_app/controller/networklistController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenscape_app/screens/explorer.dart';
import 'package:zenscape_app/screens/landingPage.dart';

dynamic initScreen;
var timestamp = DateTime.now().toUtc();

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
  void initState() {
    super.initState();
    NetworkController.networkList();
    DashboardController.dashboardList();
}
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App Title',
      debugShowCheckedModeBanner: false,
      home:  initScreen == null ? OnboardingPage():const MainApp()
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  State<MainApp> createState() => _MainAppState();

}
class _MainAppState extends State<MainApp> {
  final NetworkController networkController = Get.put(NetworkController());
  final DashboardController dashboardController = Get.put(DashboardController());
  final NavController navController=Get.put(NavController());
  @override
  void initState() {
    super.initState();
  }
DateTime timePressedBack=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Obx(
     () {
        return WillPopScope(
          onWillPop: () async{
            final difference= DateTime.now().difference(timePressedBack);
            final isExitWarning=difference>=const Duration(seconds: 2);
            timePressedBack=DateTime.now();
            if(isExitWarning)

              {
                const message='Press Back Again to Exit App';
                Get.snackbar('title', message);
                return false;
              }

            else {
              return true;
            }

          },
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              onTap:(index) {
               // navController.changeIndex(index);

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              inactiveColor: Colors.grey,
              currentIndex: navController.selectedIndex.value,
              activeColor: Colors.lightBlueAccent,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_rounded,size: 27,
                       // color:Colors.lightBlueAccent
                  ),label:('Explorer'),),
                BottomNavigationBarItem(icon: Icon(Icons.widgets_outlined,size: 27,
                    //color: Colors.lightBlueAccent,
                  ),

                    label:('Zenscape')),
                // BottomNavigationBarItem(icon: Icon(Icons.explore_rounded,size: 27,
                //   //color: Colors.lightBlueAccent,
                // ),
                //     label:('Explorer'))
              ],
            ),

            tabBuilder: (context,index){
              switch(index) {
                case 0:
                  return CupertinoTabView(builder: (context) {
                    return const CupertinoPageScaffold(
                        child:LandingPage());
                  });
                case 1:
                  return CupertinoTabView(builder: (context) {
                    return CupertinoPageScaffold(child: Webview());
                  });
                // case 2:
                //   return CupertinoTabView(builder: (context) {
                //     return const CupertinoPageScaffold(child: Webview());
                  //});
              }return Container();
            },
          ),
        );
      }
    );
  }
}
