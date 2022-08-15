import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive? 10: 6,
      width: isActive? 10: 6,
      decoration: BoxDecoration(
        color: isActive?Theme.of(context).primaryColor: Colors.white,
        border: Border.all(color: Colors.lightBlueAccent),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
    );
  }
}
