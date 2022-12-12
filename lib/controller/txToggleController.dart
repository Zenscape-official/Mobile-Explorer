import 'package:get/get.dart';

class TxToggleController extends GetxController{

  int isBlockSelected=0;

  void updateData(int index){
    if(index==0){
      isBlockSelected=0;
      update();
    }
    if(index==1){
      isBlockSelected=1;
      update();
    }

  }

}