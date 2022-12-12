import 'package:get/get.dart';

class ValToggleController extends GetxController{

  int isActiveSelected=0;

  void updateData(int index){
    if(index==0){
      isActiveSelected=0;
      update();
    }
    if(index==1){
      isActiveSelected=1;
      update();
    }

  }

}