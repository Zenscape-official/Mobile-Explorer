import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/Controller/onboardingController.dart';

import '../main.dart';


class OnboardingPage extends StatelessWidget {
final _controller=OnboardingController();

OnboardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller:_controller.pageController,
              onPageChanged: _controller.selectedPageIndex,
                itemCount: _controller.OnboardingPages.length,
                itemBuilder: (context,index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      _controller.OnboardingPages[index].assetImage,
                    ),
                              const SizedBox(height: 32),
                              Text(
                                  _controller.OnboardingPages[index].title,style:kMediumBoldTextStyle),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _controller.OnboardingPages[index].description,style:kSmallTextStyle,textAlign: TextAlign.center,),
                    )
                  ],
                );}),
            Positioned(
              bottom: 100,
              left: MediaQuery.of(context).size.width/2.5,
              child: Row(
                children: List.generate(_controller.OnboardingPages.length, (index) => Obx(() {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent),
                        color: _controller.selectedPageIndex.value == index
                            ? Colors.lightBlueAccent
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),);
                  }
                )),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: TextButton(
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>const MainApp())),
                  child:Text('Skip>>')
            ),),
            Positioned(
              right: 20,
              bottom: 30,
              child: InkWell(
                onTap:()=> _controller.isLastPage? Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>const MainApp())): _controller.pageController.nextPage(duration: 300.milliseconds, curve: Curves.easeIn),
                child: Container(
                  decoration:const BoxDecoration(
                    color:Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Obx(() {
                    if(_controller.isLastPage) {
                      return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text( 'Getting Started',style:TextStyle(color:Colors.white)),
                    );
                    } else {
                      return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_forward,color:Colors.white),
                    );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}