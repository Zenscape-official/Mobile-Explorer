import 'package:get/get.dart';

import '../backend_files/networkList.dart';
import 'networklistController.dart';

class SearchController extends GetxController{
  RxList<NetworkList> foundNetwork = RxList<NetworkList>([]);
  final NetworkController networkController = Get.put(NetworkController());

  var net;

  @override
  void onInit() {
    super.onInit();
    //net= getData();
     foundNetwork.value= [];
  }
//   getData()async{
// final result=await networkController.fetchList('https://binaries-comdex.s3.ap-south-1.amazonaws.com/zenscape.json');
// return result;
//   }

  void filterList(String name,var net) {
    var results;
    print(net);
    if (name.isEmpty) {
     results = net ;
    } else {
      results = net
          .where((element) => element.name
          .toString()
          .toLowerCase()
          .contains(name.toLowerCase()))
          .toList();

    }
    print(results);
  foundNetwork.value=results;
  }

}