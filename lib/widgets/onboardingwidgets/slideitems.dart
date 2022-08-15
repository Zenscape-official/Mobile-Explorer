import 'package:flutter/material.dart';
import 'package:zenscape_app/Constants/constants.dart';
import 'package:zenscape_app/model/slidemodel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideItem extends StatelessWidget {
   int index;
  SlideItem({required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width/2,
            child: SvgPicture.asset(slideList[index].imageUrl)),
        SizedBox(height: 0),
        Text(slideList[index].title,
        style:kMediumTextStyle),
        SizedBox(height: 5),
        Text(
            slideList[index].description,
            style:kSmallTextStyle,
            textAlign: TextAlign.center),
      ],
    );
  }
}

