import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../backend_files/ProposalsModel.dart';

class ProposalController extends GetxController {

  static var proposalList = [].obs;

  static var client = http.Client();

   Future<RxList<dynamic>> fetchProducts(String ApiUri) async{
    var response = await client.get(Uri.parse(ApiUri));

    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
      print((jsonString).toString());

     return proposalList = List.from(jsonString).map((e) => ProposalsModel.fromJson(e)).toList().reversed.toList().obs;
    }
    else{
      Get.snackbar('Error','No data fetched from API');
      return proposalList;
    }
  }
}