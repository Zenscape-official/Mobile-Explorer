import 'dart:convert';
import '../backend files/akashproposals.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ProductController extends GetxController {
  static var productList = <Proposal>[].obs;


  static var client = http.Client();
  static Future<void> fetchProducts() async{
    var response = await client.get(Uri.parse('https://akash-api.polkachu.com/cosmos/gov/v1beta1/proposals#'));
    if (response.statusCode==200){
      // print (response.body);
       var jsonString= jsonDecode((response.body))['proposals'];

       ProductController.productList = List.from(jsonString).map((e) => Proposal.fromMap(e)).toList().obs;
    }
    else{

     Get.snackbar('Error','No data fetched from API');
    }
  }
  //Logic for searchbar


}