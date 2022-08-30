
import 'package:get/get.dart';
import 'package:zenscape_app/backend%20files/networkList.dart';
import 'package:zenscape_app/services/remoteServices.dart';
class NetworkController extends GetxController{

  static var networkList=<NetworkList>[].obs;

  void fetchList() async {
    var products= await RemoteServices.fetchData();
    if (products!=null){
      networkList.value=products;

    }
    else{print('error');}
  }

}