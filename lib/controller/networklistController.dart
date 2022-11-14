// import 'package:get/get.dart';
// import 'package:zenscape_app/backend%20files/networkList.dart';
// import 'package:zenscape_app/services/remoteServices.dart';
// class NetworkController extends GetxController{
//
//   static var networkList=<NetworkList>[].obs;
//
//   void fetchList() async {
//     var products= await RemoteServices.fetchData();
//     if (products!=null){
//       print(networkList.runtimeType);
//       networkList.value=products;
//
//     }
//     else{print('error');}
//   }
//
// }
//

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zenscape_app/backend%20files/networkList.dart';
class NetworkController extends GetxController {

  static var networkList = [].obs;
  static var client = http.Client();

  Future<RxList<dynamic>> fetchList() async{
    var response = await client.get(Uri.parse(
        'https://explorer-static-test.zenscape.one/network-list.json'
    ));

    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
      //print(jsonString);
      return networkList = List.from(jsonString).map((e) => NetworkList.fromJson(e)).toList().obs;
    }
    else{
      print(response.statusCode);
      Get.snackbar('Error','No data fetched from API');
      return networkList;
    }
  }
}