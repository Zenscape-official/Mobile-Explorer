import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/rawLogModel.dart';
import '../backend_files/txModel.dart';

class RawLogController extends GetxController {

  static var rawList = [].obs;
 // static var client = http.Client();

 RxList<RawLogModel> fetchTx(var rawlog) {
    //var response = await client.get(Uri.parse(''));

      var jsonString= jsonDecode(rawlog);

     return rawList = List.from(jsonString).map((e) => RawLogModel.fromJson(e)).toList().obs;



  }
}