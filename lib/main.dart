import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zenscape_app/Screens/onboardingScreen.dart';
import 'package:zenscape_app/controller/dashboardController.dart';
import 'package:zenscape_app/controller/networklistController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenscape_app/routes/routes.dart';
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
    DashboardController.dashboardList();
}
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        defaultTransition: Transition.noTransition, //this would be the solution
        transitionDuration:  Duration(seconds: 0),

      title: 'App Title',
      debugShowCheckedModeBanner: false,
      home:  initScreen == null ? OnboardingPage():const MainApp(),
      getPages: getPages,
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
            backgroundColor: Colors.white, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: false,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            // screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            //  // animateTabTransition: true,
            //   curve: Curves.ease,
            //   duration: Duration(milliseconds: 200),
            // ),
            navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
          );
         // child: CupertinoTabScaffold(
         //    //resizeToAvoidBottomInset: true,
         //
         //    tabBar: CupertinoTabBar(
         //      onTap:(index) {
         //      },
         //      inactiveColor: Colors.grey,
         //      currentIndex: navController.selectedIndex.value,
         //      activeColor: Colors.lightBlueAccent,
         //      items: const<BottomNavigationBarItem>[
         //        const BottomNavigationBarItem(
         //
         //          icon: Icon(Icons.explore_rounded,size: 27,
         //               // color:Colors.lightBlueAccent
         //          ),label:('Explorer'),
         //        ),
         //        const BottomNavigationBarItem(icon: Icon(Icons.widgets_outlined,size: 27,
         //            //color: Colors.lightBlueAccent,
         //          ),
         //
         //            label:('Zenscape')),
         //        // BottomNavigationBarItem(icon: Icon(Icons.explore_rounded,size: 27,
         //        //   //color: Colors.lightBlueAccent,
         //        // ),
         //        //label:('Explorer')
         //      ],
         //    ),
         //
         //    tabBuilder: (context,index){
         //      switch(index) {
         //        case 0:
         //          return CupertinoTabView(builder: (context) {
         //            return const CupertinoPageScaffold(
         //                child:LandingPage());
         //          });
         //        case 1:
         //          return CupertinoTabView(builder: (context) {
         //            return const CupertinoPageScaffold(child: Webview());
         //          });
         //        // case 2:
         //        //   return CupertinoTabView(builder: (context) {
         //        //     return const CupertinoPageScaffold(child: Webview());
         //        //});
         //      }
         //      return Container();
         //    },
         //  ),
    //     );
    //   }
    // );
  }


}

