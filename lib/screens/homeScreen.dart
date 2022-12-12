

import 'package:flutter/material.dart';

import '../constants/constants.dart';

class InfoCard extends StatelessWidget {
      final String title1;
      final String? titleValue1;
      final String? icon1;

      InfoCard({Key? key, required this.title1, this.titleValue1,this.icon1}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxDecorationWithoutGradient,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,8,8,9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(
               height: 26,
               width: 26,
               child: Image.asset(icon1!)),
            SizedBox(height: 4),
            Text(title1,
            style: kSmallTextStyle,),
            SizedBox(height: 4),
            Text(titleValue1!.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
              style: kMediumBoldTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
