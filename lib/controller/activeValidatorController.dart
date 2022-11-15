import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:zenscape_app/widgets/onboardingwidgets/onboardingInfo.dart';
import 'package:get/state_manager.dart';


class OnboardingController extends GetxController {

  var selectedValIndex=0.obs;
  bool get isLastPage => selectedValIndex.value == OnboardingPages.length - 1;
  var pageController = PageController();
  forwardAction(){
    if(isLastPage){
    }
    else
    {pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);}
  }


  List<OnboardingInfo> OnboardingPages=[
    OnboardingInfo('assets/svgfiles/icon1.svg','Stake Your Assets','Stake your crypto assets directly from the app...'),
    OnboardingInfo('assets/svgfiles/icon2.svg','Auto-Compounding','Enable auto-compounding at just one click to maximize your returns...'),
    OnboardingInfo('assets/svgfiles/icon3.svg','Governance Proposal','Vote on the governance proposal and have your say...')
  ];
}
// class ValInfo{
//   final assetImage;
//   final title;
//   final description;
//
//   valInfo(this.assetImage,this.title,this.description);
// }