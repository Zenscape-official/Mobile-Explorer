import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zenscape_app/backend%20files/blocksModel.dart';

class BlocksController extends GetxController {

  static var blockList = [].obs;

  static var client = http.Client();

  Future<RxList<dynamic>> fetchBlocks(String ApiUri) async{
    var response = await client.get(Uri.parse(ApiUri));

    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
      return blockList = List.from(jsonString).map((e) => BlockModel.fromJson(e)).toList().obs;
    }
    else{
      Get.snackbar('Error','No data fetched from API');
      return blockList;
    }
  }
}