import 'dart:ui';
import 'package:flutter/painting.dart';

/// All text shadows as defined in Tailwind
abstract class TwTextShadow {
  static const List<BoxShadow> xs2 = [
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.15,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];

  static const List<BoxShadow> xs = [
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 1.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.2,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];

  static const List<BoxShadow> sm = [
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.075,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 1.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.075,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
    BoxShadow(
      offset: Offset(0.0, 2.0),
      blurRadius: 2.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.075,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 1.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 2.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
    BoxShadow(
      offset: Offset(0.0, 2.0),
      blurRadius: 4.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 2.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
    BoxShadow(
      offset: Offset(0.0, 3.0),
      blurRadius: 2.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
    BoxShadow(
      offset: Offset(0.0, 4.0),
      blurRadius: 8.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];
}
