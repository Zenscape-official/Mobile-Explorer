import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../backend files/networkList.dart';
class RemoteServices {
    static var networkClient= http.Client();
    static Future<List<NetworkList>?> fetchData() async{
      var response = await networkClient.get(Uri.parse('https://explorer-static-test.zenscape.one/network-list.json'));
      if (response.statusCode==200){
        var json =(response.body);

        return networkListFromJson(json);
      }
      else {
        Get.snackbar('Error', 'No Data found');
        return null;
      }
    }

}