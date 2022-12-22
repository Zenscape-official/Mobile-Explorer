
import 'package:get/get.dart';

class NavController extends GetxController{

  int isPageSelected=0;

  void updatePage(int index){
    if(index==1){
      isPageSelected=1;
      update();
    }
    else if(index==2){
      isPageSelected=2;
      update();
    }
    else if(index==3){
      isPageSelected=3;
      update();
    }
    else if(index==4){
      isPageSelected=4;
      update();
    }
    else if(index==5){
      isPageSelected=5;
      update();
    }
    else if(index==6){
      isPageSelected=6;
      update();
    }
    else if(index==7){
      isPageSelected=7;
      update();
    }
    else if(index==8){
      isPageSelected=8;
      update();
    }

  }

}