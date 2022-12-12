import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../backend_files/proposalsModel.dart';

class ProposalController extends GetxController {
  static var proposalList = [].obs;
  static var client = http.Client();

  Future<dynamic> fetchProducts(String ApiUri) async {
    try {
      var response = await client.get(Uri.parse(ApiUri));

      switch (response.statusCode) {
        case 200:
        case 201:
          var jsonString = jsonDecode((response.body));
          print((jsonString).toString());

          return proposalList = List.from(jsonString)
              .map((e) => ProposalsModel.fromJson(e))
              .toList()
              .reversed
              .toList()
              .obs;

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
      final jsonResponse = {
        'success': false,
        'response': 'No Internet or Connection Failure'
      };
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
