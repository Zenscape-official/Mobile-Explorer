import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zenscape_app/backend%20files/assetsModel.dart';

class AssetsController extends GetxController {

  static var assetList = [].obs;
  static var client = http.Client();

  Future<RxList<dynamic>> fetchAssets(String ApiUri) async{
    var response = await client.get(Uri.parse(ApiUri));

    if (response.statusCode==200){
      var jsonString= jsonDecode(response.body)['assets'];
      print(jsonString);
      return assetList = List.from(jsonString).map((e) => Asset.fromJson(e)).toList().obs;
    }
    else{
      Get.snackbar('Error','No data fetched from API');
      return assetList;
    }
  }
}