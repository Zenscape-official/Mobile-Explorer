import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../backend files/validatorsModel.dart';

class ValidatorController extends GetxController {

  static var validatorsList = [].obs;
  static var client = http.Client();

  Future<RxList<dynamic>> fetchVal(String ApiUri) async{
    var response = await client.get(Uri.parse(ApiUri));
      print(ApiUri);
    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
      print(jsonString);
      return validatorsList = List.from(jsonString).map((e) => ValidatorModel.fromJson(e)).toList().obs;
    }
    else{
      print("statuscode is ${response.statusCode}");
      Get.snackbar('Error','No data fetched from API');
      return validatorsList;
    }
  }
}