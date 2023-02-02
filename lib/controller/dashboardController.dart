import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../backend_files/dashboardModel.dart';

class DashboardController extends GetxController {
  static var dashboardList = [].obs;
  static var client = http.Client();
  var isLoading;

  Future<RxList<dynamic>> fetchDash() async {
    isLoading = true;
    var response = await client.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=marlin,ki,umee,injective,band-protocol,stride,canto,assetmantle,osmosis,akash-network,comdex,juno-network,chihuahua,cosmos,kava,near,celo,skale,terra-luna,iris-network,matic-network,sentinel,tezos,persistence,secret&order=market_cap_desc&sparkline=false'));

    if (response.statusCode == 200) {
      var jsonString = jsonDecode((response.body));

      return dashboardList = List.from(jsonString)
          .map((e) => DashboardModel.fromJson(e))
          .toList()
          .obs;
    } else {
      Get.snackbar('Error', 'No data fetched from API');
      return dashboardList;
    }
  }

  Future<String> fetchdata(String input, String json) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {

      if(response.body.length!=2) {
        return await jsonDecode(response.body)[0][json];
      }
      else {
        return '0';
      }
    } else {
      return '0';
    }
  }

  Future<String> fetchSingleData(String input, String json) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {
      return await jsonDecode(response.body)[json].toString();
    }
    else {
      return '';
    }
  }
  Future<String> fetchOsmoAPR(String input) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200)
    {
      return await jsonDecode(response.body).toString();
    }
    else {
      return '';
    }
  }

  Future<String> fetchDataWithoutParam(String input) async {
    final response = await http.get(Uri.parse(input));
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      return '';
    }
  }
  fetch2PathData(String uri,String path1, String path2) async {
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return await jsonDecode(response.body)[path1][path2];
    } else {
      return '';
    }
  }
}
