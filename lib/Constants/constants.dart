import 'dart:io';

import 'package:flutter/material.dart';
var kBigTextStyle= TextStyle(
fontFamily: 'Montserrat',
  color: Colors.black,
  fontWeight: Platform.isAndroid ?FontWeight.normal: FontWeight.w900,
fontSize: 18,
);
var kMediumTextStyle= TextStyle(
  fontFamily: 'Montserrat',
  color: Colors.black,

  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.w900,
  fontSize: 15,
);
var kSmallTextStyle= TextStyle(
  fontFamily: 'Montserrat',
  color: Colors.black,
  fontWeight: Platform.isAndroid?FontWeight.normal: FontWeight.w900,
  fontSize: 12,
);
var kExtraSmallTextStyle= TextStyle(
  fontFamily: 'Montserrat',
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
  borderRadius: const BorderRadius.all(Radius.circular(15.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(.05),
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(-2, -2), // changes position of shadow
    ),],);