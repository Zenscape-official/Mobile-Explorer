import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../backend_files/validatorsModel.dart';

class ValidatorController extends GetxController {

  static var validatorsList = [].obs;
  static var activeValidatorsList = [].obs;
  ValidatorModel? activeValidatorModel;
  static var inActiveValidatorsList = [].obs;
  static var client = http.Client();

  Future<RxList<dynamic>> fetchVal(String ApiUri) async{
    var response = await client.get(Uri.parse(ApiUri));
      // print(ApiUri);
    if (response.statusCode==200){
      var jsonString= jsonDecode((response.body));
      // print(jsonString);
      validatorsList = List.from(jsonString).map((e) => ValidatorModel.fromJson(e)).toList().obs;
      for(int i=0;i<validatorsList.length;i++){
        activeValidatorModel = validatorsList[i];
       // print(activeValidatorModel!.jailedUntil.toString());
        if(activeValidatorModel!.jailedUntil.toString()==('1970-01-01 00:00:00.000Z')){
         // print(activeValidatorModel!.jailedUntil.toString());
          activeValidatorsList.add(validatorsList[i]);
        }
        else(inActiveValidatorsList.add(validatorsList[i]));
      }
      print(inActiveValidatorsList.length);
      return validatorsList;
    }
    else{
      print("statuscode is ${response.statusCode}");
      Get.snackbar('Error','No data fetched from API');
      return validatorsList;
    }
  }
}