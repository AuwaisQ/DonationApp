import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

const Color primColor = Color(0xff13B156);

//NavAnimation
Widget navAnimation(Widget child){
  return DelayedDisplay(
    slidingCurve: Curves.easeInOutBack,
    slidingBeginOffset: const Offset(0, -0.09),
    delay: const Duration(milliseconds: 200),
    child: child,);
}
//Auwais

//Text Theme
const TextStyle titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5
);
const TextStyle subTitle = TextStyle(
  fontSize: 15,
  color: Colors.black54,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
  height: 1.5,
  overflow: TextOverflow.ellipsis
);
const TextStyle headline = TextStyle(
  color: Colors.black,
  fontSize: 18,
  letterSpacing: 0.5,
  fontWeight: FontWeight.w600,
);
const TextStyle headline1 = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
);
const TextStyle buttonTitleStyleW = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
const TextStyle buttonTitleStyleG = TextStyle(
  color: primColor,
  fontSize: 20,
  fontWeight: FontWeight.w500,
);