import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class NetworkController extends GetxController {

  static var client = http.Client();
  var isLoading=false;

  Future<dynamic> fetchList(String Url) async{
    isLoading=true;
   try{
     var response = await client.get(Uri.parse(
         Url
    ));
    switch(response.statusCode){
      case 200:
      case 201:

      final result = jsonDecode(response.body);
      final jsonResponse = {'success': true, 'response': result};
      isLoading=false;
      return jsonResponse;
      case 400:
        final result = jsonDecode(response.body);
        final jsonResponse = {'success': false, 'response': result};
        isLoading=false;
        return jsonResponse;
      case 401:
        final jsonResponse = {'success': false, 'response': 'UNAUTHORIZED'};
        isLoading=false;
        return jsonResponse;
      case 500:
      case 501:
      case 502:
        final jsonResponse = {
          'success': false,
          'response': 'SOMETHING WRONG ${response.statusCode}'
        };
        isLoading=false;
        return jsonResponse;
      default:
        final jsonResponse = {
          'success': false,
          'response': 'SOMETHING WRONG ${response.statusCode}'
        };
        isLoading=false;
        return jsonResponse;
    }
   } on SocketException {
     final jsonResponse = {
       'success': false,
       'response': 'No Internet or Connection Failure '
     };
     isLoading=false;
     return jsonResponse;
   } on FormatException {
     final jsonResponse = {'success': false, 'response': 'Bad Response'};
     return jsonResponse;
   } on HttpException {
     final jsonResponse = {
       'success': false,
       'response': 'SOMETHING_WRONG' //Server not responding
     };
     isLoading=false;
     return jsonResponse;
   }
  }
}
