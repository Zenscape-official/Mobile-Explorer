import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BookController extends GetxController {

  // It is mandatory initialize with one value from listType
  final selected = "some book type".obs;

  void setSelected(String value){
    selected.value = value;
  }
}

