import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/ibcRelayersModel.dart';

class IBCController extends GetxController {

  static var IBCList = [].obs;

  static var client = http.Client();

  Future<RxList<dynamic>> fetchIBC(String ApiUri)  async{
    var response = await client.get(Uri.parse(ApiUri));

    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body))["channels"];
      print((jsonString).toString());

      return IBCList = List.from(jsonString).map((e) => Channel.fromJson(e)).toList().obs;
    }
    else{
      Get.snackbar('Error','No data fetched from API');
      return IBCList;
    }
  }
}