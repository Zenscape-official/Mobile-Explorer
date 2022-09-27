import 'dart:io';
import 'package:flutter/material.dart';
var kBigTextStyle= TextStyle(
fontFamily: 'MontserratRegular',
  color: Colors.black,
  fontWeight: Platform.isAndroid ?FontWeight.normal: FontWeight.w900,
fontSize: 20,
);
var kBigBoldTextStyle= TextStyle(
  fontFamily: 'MontserratBold',
  color: Colors.black,
  fontWeight: Platform.isAndroid ?FontWeight.w700: FontWeight.w900,
  fontSize: 20,
);

var kMediumTextStyle= TextStyle(
  fontFamily: 'MontserratRegular',
  color: Colors.black,

  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.w900,
  fontSize: 15,
);
var kMediumBoldTextStyle= TextStyle(
  fontFamily: 'MontserratBold',
  color: Colors.black,
  fontWeight: Platform.isAndroid?FontWeight.w700: FontWeight.w900,
  fontSize: 17,
);

var kSmallTextStyle= TextStyle(
  fontFamily: 'MontserratRegular',
  color: Colors.black,
  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.w900,
  fontSize: 13,
);
var kSmallBoldTextStyle= TextStyle(
  fontFamily: 'MontserratBold',
  color: Colors.black,
  fontWeight: Platform.isAndroid?FontWeight.bold: FontWeight.w900,
  fontSize: 12,
);

var kExtraSmallTextStyle= TextStyle(
  fontFamily: 'MontserratRegular',
  color: Colors.black,
  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.w900,
  fontSize: 10,
);
var kGradientColor= LinearGradient(
  colors: [ Colors.white, const Color(0xFFBCE4FC).withOpacity(.5)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
var kBoxDecorationWithGradient=BoxDecoration (
  borderRadius: const BorderRadius.all(Radius.circular(15.0),
  ),
  gradient: kGradientColor,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(.05),
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(0,4), // changes position of shadow
  ),],);
var kBoxDecorationWithoutGradient=BoxDecoration (
  color: const Color(0xFFD4F1FF).withOpacity(.5),
  borderRadius: const BorderRadius.all(Radius.circular(12.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(.05),
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(-2, -2), // changes position of shadow
    ),],);
var kBoxBorder = BoxDecoration (
  border: Border.all(
    color: Colors.lightBlueAccent.withOpacity(.5),
    width: 1.0,
  ),
  color: const Color(0xFF8CDAFF).withOpacity(.2),
  borderRadius: const BorderRadius.all(Radius.circular(15.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(.05),
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(-2, -2), // changes position of shadow
    ),
  ],
);
class GreenContainer extends StatelessWidget {
  GreenContainer(this.title);
  String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent.withOpacity(.1),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(
          color: const Color(0xFF6BD68D),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            const CircleAvatar(backgroundColor:  Colors.green,
              radius: 3,),
            SizedBox(width: 2,),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(title!,
                style: kSmallTextStyle,),
            ),
          ],
        ),
      ),
    );
  }
}

void function(String hash){

}