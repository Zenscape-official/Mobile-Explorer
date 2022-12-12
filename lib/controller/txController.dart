import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../backend_files/txModel.dart';

class TxController extends GetxController {

  static var txList = [].obs;
  static var client = http.Client();

  Future<RxList<dynamic>> fetchTx(String ApiUri) async{
    var response = await client.get(Uri.parse(ApiUri));
    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
     // print(jsonString);
      // for(var prod i`n jsonString){
      //   txList.add(TxModel.fromJson(prod));}
      txList = List.from(jsonString).map((e) => TxModel.fromJson(e)).toList().reversed.toList().obs;
      return txList;
    }
    else{
      Get.snackbar('Error','No data fetched from API');
      return txList;
    }
  }
}