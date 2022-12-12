import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zenscape_app/backend_files/blocksModel.dart';

class BlocksController extends GetxController {

  static var blockList = [].obs;
  static var client = http.Client();
  var isLoading;

  Future<dynamic> fetchBlocks(String ApiUri) async{
    isLoading=true;
    try{
      var response = await client.get(Uri.parse(ApiUri));
      isLoading=false;
      switch(response.statusCode) {

        case 200:
        case 201:
          var jsonString = jsonDecode((response.body));

          //print(jsonString.runtimeType);
          return blockList = List
              .from(jsonString)
              .map((e) => BlockModel.fromJson(e))
              .toList()
              .reversed
              .toList()
              .obs;
        case 400:
          final result = jsonDecode(response.body);
          final jsonResponse = {'success': false, 'response': result};
          return jsonResponse;
        case 401:
          final jsonResponse = {
            'success': false,
            'response': 'UNAUTHORIZED'
          };
          return jsonResponse;
        case 500:
        case 501:
        case 502:
          final jsonResponse = {
            'success': false,
            'response':'SOMETHING_WRONG'
          };
          return jsonResponse;
        default:
          final jsonResponse = {
            'success': false,
            'response': 'SOMETHING_WRONG'
          };
          return jsonResponse;
      }
    } on SocketException {
      final jsonResponse = {
        'success': false,
        'response': 'NO_INTERNET'
      };
      return jsonResponse;
    } on FormatException {
      final jsonResponse = {
        'success': false,
        'response': 'BAD_RESPONSE'
      };
      return jsonResponse;
    } on HttpException {
      final jsonResponse = {
        'success': false,
        'response': 'SOMETHING_WRONG'  //Server not responding
      };
      return jsonResponse;
    }

  }
      }
