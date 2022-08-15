import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenscape_app/model/slidemodel.dart';
import 'package:zenscape_app/widgets/onboardingwidgets/slidedots.dart';
import '../main.dart';
import '../widgets/onboardingwidgets/slideitems.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);


  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  int _currentPage=0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState(){
    super.initState();
    Timer.periodic(const Duration(seconds:5),(Timer timer){
       if (_currentPage<2){
        _currentPage++;
      }
       else{
        _currentPage=0;
      }
      _pageController.animateToPage(_currentPage, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    );
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }
  _onPageChanged(int index)
  {
    setState(() {
    _currentPage=index;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                PageView.builder(
                scrollDirection:Axis.horizontal ,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) => SlideItem(index: index),
              itemCount: slideList.length,),
              Stack(children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     for(int i=0;i<slideList.length;i++)
                       if(i==_currentPage)
                         SlideDots(isActive: true)
                      else
                        SlideDots(isActive: false)
                        ],
                      ),
                    ),
                  ],
                ),
              ]
            )
          ),
          //SizedBox(height: 200),
          Center(
            child: CupertinoButton(
              child: const Text('Get Started'),
              onPressed: () {
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>const MainApp()));
              },
              color: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
    ));
  }
}
