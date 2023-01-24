import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/Screens/onboardingScreen.dart';
import 'package:zenscape_app/controller/dashboardController.dart';
import 'package:zenscape_app/controller/networklistController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenscape_app/screens/explorer.dart';
import 'package:zenscape_app/screens/landingPage.dart';

dynamic initScreen;
var timestamp = DateTime.now().toUtc();
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  HttpOverrides.global = MyHttpOverrides();

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
    DashboardController.dashboardList();
}
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        defaultTransition: Transition.noTransition,
        transitionDuration:  Duration(seconds: 0),

      title: 'Zenscape',
      debugShowCheckedModeBanner: false,
      home:  initScreen == null ? OnboardingPage():const MainApp(),

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
  PersistentTabController? _controller;
  DateTime timePressedBack=DateTime.now();

  @override
  void initState() {
    super.initState();

  }
  List<Widget> _buildScreens(){
    return [
      LandingPage(),
      Webview()
    ];
  }
  List<PersistentBottomNavBarItem> _navBarItems(){
    return [
      PersistentBottomNavBarItem(

          icon: Icon(Icons.widgets_outlined),
          title: 'Explorer',
        activeColorPrimary: Colors.lightBlueAccent,
        inactiveColorPrimary: Colors.grey
      ),
      PersistentBottomNavBarItem(icon: Icon(Icons.explore_rounded,),
          title: 'Zenscape',
          activeColorPrimary: Colors.lightBlueAccent,
          inactiveColorPrimary: Colors.grey)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return

           PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),

            navBarStyle: NavBarStyle.style3,
          );

  }


}

