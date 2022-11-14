

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../backend files/dashboardModel.dart';
class DashboardController extends GetxController {

  static var dashboardList = [].obs;
  static var client = http.Client();

  Future<RxList<dynamic>> fetchDash() async{
    var response = await client.get(Uri.parse(
'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=marlin,ki,umee,injective,band-protocol,stride,canto,assetmantle,osmosis,akash-network,comdex,juno-network,chihuahua,cosmos,kava,near,celo,skale,terra-luna,iris-network,matic-network,sentinel,tezos,persistence,secret&order=market_cap_desc&sparkline=false'
                  ));

    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
     // print(jsonString);
      return dashboardList = List.from(jsonString).map((e) => DashboardModel.fromJson(e)).toList().obs;
    }
    else{
      print(response.statusCode);
      Get.snackbar('Error','No data fetched from API');
      return dashboardList;
    }
  }
}