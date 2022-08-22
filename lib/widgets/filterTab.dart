import 'package:flutter/material.dart';
import 'package:zenscape_app/Constants/constants.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration (
        color: const Color(0xFFD4F1FF).withOpacity(.5),
    border: Border.all(
      color: Colors.lightBlueAccent.withOpacity(.5),
      width: 1.0,
    ),
        borderRadius: const BorderRadius.all(Radius.circular(18.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-2, -2), // changes position of shadow
          ),],),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
        children: [
          Text('Filter',style:kSmallTextStyle),
          DropdownButton(items: [], onChanged: null)
        ],
        ),
      ),
    );
  }
}
