import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../backend files/miscModel.dart';

class GovParamController extends GetxController {

  static var GovList = [].obs;
  static var client = http.Client();

  Future<RxList<dynamic>> fetchMisc(String ApiUri) async{
    var response = await client.get(Uri.parse(ApiUri));

    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
      print(jsonString);
      return GovList = List.from(jsonString).map((e) => GovParamModel.fromJson(e)).toList().obs;
    }
    else{
      Get.snackbar('Error','No data fetched from API');
      return GovList;
    }
  }
}