import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../backend_files/valStatusModel.dart';
import '../backend_files/validatorsModel.dart';

class ValidatorController extends GetxController {
  RxList<ValStatusModel>? valStatus ;
  RxList<ValidatorModel>? validatorsList ;
  static var activeValidatorsList = [].obs;
  ValidatorModel? activeValidatorModel;
  static var inActiveValidatorsList = [].obs;
  static var client = http.Client();
  var isLoading=false;

  var dateToday= DateTime.now();
  Future<dynamic> fetchVal(String ApiUri,String status) async {
    isLoading=true;
    try {
      var response = await client.get(Uri.parse(ApiUri));
      var statusResponse=await client.get(Uri.parse(status));
      isLoading=false;
      switch (response.statusCode) {
        case 200:
        case 201:
          var jsonString = jsonDecode(response.body);
          var jsonStatusString= jsonDecode(statusResponse.body);
          validatorsList = List.from(jsonString)
              .map((e) => ValidatorModel.fromJson(e))
              .toList()
              .obs;
          valStatus= List.from(jsonStatusString)
              .map((x) => ValStatusModel.fromMap(x)).toList().obs;
          return validatorsList;
        case 400:
          final result = jsonDecode(response.body);
          final jsonResponse = {'success': false, 'response': result};
          return jsonResponse;
        case 401:
          final jsonResponse = {'success': false, 'response': 'UNAUTHORIZED'};
          return jsonResponse;
        case 500:
        case 501:
        case 502:
          final jsonResponse = {
            'success': false,
            'response': 'SOMETHING_WRONG'
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
      final jsonResponse = {'success': false, 'response': 'No Internet or Connection Failure'};
      return jsonResponse;
    } on FormatException {
      final jsonResponse = {'success': false, 'response': 'Bad Response'};
      return jsonResponse;
    } on HttpException {
      final jsonResponse = {
        'success': false,
        'response': 'SOMETHING_WRONG' //Server not responding
      };
      return jsonResponse;
    }
  }
}
