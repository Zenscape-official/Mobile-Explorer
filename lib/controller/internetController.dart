
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;



Future<dynamic> requestGET({String? url}) async {
  try {
    final response = await http.get(Uri.parse(url!));
    switch (response.statusCode) {
      case 200:
      case 201:
        final result = jsonDecode(response.body);
        final jsonResponse = {'success': true, 'response': result};
        return jsonResponse;
      case 400:
        final result = jsonDecode(response.body);
        final jsonResponse = {'success': false, 'response': result};
        return jsonResponse;
      case 401:
        final jsonResponse = {
          'success': false,
          'response': 'ConstantUtil.UNAUTHORIZED'
        };
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
      'response': 'SOMETHING_WRONG' //Server not responding
    };
    return jsonResponse;
  }
}