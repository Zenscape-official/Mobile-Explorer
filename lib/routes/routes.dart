import 'package:get/get.dart';
import 'package:zenscape_app/screens/network/dashboard.dart';
import 'package:zenscape_app/screens/network/parameters.dart';
import 'package:zenscape_app/screens/network/proposals.dart';

import '../Screens/network/blocks.dart';
import '../Screens/network/contracts.dart';
import '../Screens/network/validators.dart';

/// Routes name to directly navigate the route by its name
class Routes {
  static String screen1 = '/dashboard';
  static String screen2 = '/validators';
  static String screen3 = '/blocks';
  static String screen4 = '/proposals';
  static String screen5 = '/contracts';
  static String screen6 = '/params';
}

/// Add this list variable into your GetMaterialApp as the value of getPages parameter.
/// You can get the reference to the above GetMaterialApp code.
final getPages = [
  GetPage(
    name: Routes.screen1,
    page: () => const NetworkDashBoard(),
  ),
  GetPage(
    name: Routes.screen2,
    page: () => const Validators(),
  ),
  GetPage(
    name: Routes.screen3,
    page: () => const Blocks(),
  ),
  GetPage(
    name: Routes.screen4,
    page: () => const Proposals(),
  ),
  GetPage(
    name: Routes.screen5,
    page: () => const Contracts(),
  ),
  GetPage(
    name: Routes.screen6,
    page: () => const Parameters(),
  ),
];