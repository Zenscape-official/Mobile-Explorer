import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../backend_files/contractModel.dart';

class ContractController extends GetxController {

  static var ContractList = [].obs;
  static var client = http.Client();

  Future<RxList<dynamic>> fetchCont(String ApiUri) async{
    var response = await client.get(Uri.parse(ApiUri));

    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
      //print(jsonString);
      return ContractList = List.from(jsonString).map((e) => ContractModel.fromJson(e)).toList().obs;
    }
    else{
      Get.snackbar('Error','No data fetched from API');
      return ContractList;
    }
  }
}