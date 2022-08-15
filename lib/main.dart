import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenscape_app/Screens/explorer.dart';
import 'package:zenscape_app/Screens/gettingStarted.dart';
import 'package:zenscape_app/Screens/landing_page.dart';
import 'Controller/product_controller.dart';
import 'Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = (prefs.getInt("initScreen"));
  runApp(const MyApp());
  await prefs.setInt("initScreen", 0);
}

// void main(){
//   runApp(MyApp());
// }
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
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      home:  initScreen ==null ?  GettingStarted():const MainApp()
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
  final List<TabItem> _bottomTabs = [
    TabItem.home,
    TabItem.details,
    TabItem.explore,
   // TabItem.notification,
   // TabItem.setting
  ];
  TabItem _currentItem = TabItem.home;
  @override

  Widget build(BuildContext context) {

    ProductController.fetchProducts;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label:('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.explore_rounded),label:('Explorer'))
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
              return const CupertinoPageScaffold(child: Explorer());
            });
        }return Container();
      },
     //  body: _buildScreen(),
     //  endDrawer: NavigationDrawerWidget(),
     //
     //  floatingActionButton: FloatingActionButton(
     //    backgroundColor: Colors.lightBlueAccent,
     //    child: const Icon(Icons.widgets),
     //    onPressed: ()async{
     //      final Uri url= Uri.parse('https://zenscape.one');
     //      if (await launchUrl (url))
     //      {await launchUrl (url);
     //      }
     //    },
     //  ),
     //  //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
     //
     // // backgroundColor: const Color(0xFF1A1C29),
     //  bottomNavigationBar: _bottomNavigationBar(),

    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: _bottomTabs.map((tabItem) => _bottomNavigationBarItem(_icon(tabItem), tabItem)).toList(),
      onTap: _onSelectTab,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(IconData icon,
      TabItem tabItem) {
    final Color color =
    _currentItem == tabItem ? Color(0xFF12BFFF) : Colors.blueGrey;

    return BottomNavigationBarItem(icon: Icon(icon, color: color), label: '');
  }

  void _onSelectTab(int index) {
    TabItem selectedTabItem = _bottomTabs[index];

    setState(() {
      _currentItem = selectedTabItem;
    });
  }

  IconData _icon(TabItem item) {
    switch (item) {
      case TabItem.home:
        return Icons.home;
      case TabItem.explore:
        return Icons.explore;
       case TabItem.details:
        return Icons.notifications;
      // case TabItem.setting:
      //   return Icons.settings;
      default:
        throw 'Unknown $item';
    }
  }

  Widget _buildScreen() {
    switch (_currentItem) {
      case TabItem.home:
        return const LandingPage();
      case TabItem.explore:
       return const Explorer();
     // case TabItem.notification:
      // return HomeScreen()
     // case TabItem.setting:
       //return ;
      default:
        return const HomeScreen();
    }
  }
}
