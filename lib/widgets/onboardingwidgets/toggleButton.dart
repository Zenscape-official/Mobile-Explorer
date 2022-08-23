import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  String leftTitle='';
  String rightTitle='';
  GestureTapCallback? leftCall;
  GestureTapCallback? rightCall;
  final CupertinoPageRoute? cupertinoPageRoute;

  @override

  ToggleButton({ required this.leftTitle,required this.rightTitle,this.leftCall,this.rightCall, this.cupertinoPageRoute});
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double width = 200.0;
const double height = 30.0;
const double activeAlign = -1;
const double inactiveAlign = 1;
const Color selectedColor = Color(0xFF12BFFF);
const Color normalColor = Colors.black54;

class _ToggleButtonState extends State<ToggleButton> {
  double? xAlign;
  Color? leftColor;
  Color? rightColor;

  @override
  void initState() {
    super.initState();
    xAlign = activeAlign;
    leftColor = selectedColor;
    rightColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(xAlign!, 0),
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: width * 0.5,
                height: height,
                decoration: BoxDecoration(
                  color:const Color(0xFFD4F1FF),
                  border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.of(context).push(widget.cupertinoPageRoute!);
                  xAlign = activeAlign;
                  leftColor = selectedColor;
                  rightColor = normalColor;
                  widget.leftCall;
                });
              },
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.leftTitle,
                    style: TextStyle(
                      color: leftColor,
                      fontFamily: 'MontserratRegular',
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = inactiveAlign;
                  rightColor = selectedColor;
                  leftColor = normalColor;
                  widget.rightCall;
                });
              },
              child: Align(
                alignment: const Alignment(1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.rightTitle,
                    style: TextStyle(
                      fontFamily: 'MontserratRegular',
                      color: rightColor,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
