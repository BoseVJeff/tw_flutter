import 'dart:ui';
import 'package:flutter/painting.dart';

/// All shadows as defined in Tailwind
abstract class TwShadow {
  static const List<BoxShadow> xs2 = [
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.05,
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
      blurRadius: 2.0,
      spreadRadius: 0.0,
      color: Color.from(
        alpha: 0.05,
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
      blurRadius: 3.0,
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
      spreadRadius: -1.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      offset: Offset(0.0, 4.0),
      blurRadius: 6.0,
      spreadRadius: -1.0,
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
      spreadRadius: -2.0,
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
      offset: Offset(0.0, 10.0),
      blurRadius: 15.0,
      spreadRadius: -3.0,
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
      blurRadius: 6.0,
      spreadRadius: -4.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      offset: Offset(0.0, 20.0),
      blurRadius: 25.0,
      spreadRadius: -5.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
    BoxShadow(
      offset: Offset(0.0, 8.0),
      blurRadius: 10.0,
      spreadRadius: -6.0,
      color: Color.from(
        alpha: 0.1,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];

  static const List<BoxShadow> xl2 = [
    BoxShadow(
      offset: Offset(0.0, 25.0),
      blurRadius: 50.0,
      spreadRadius: -12.0,
      color: Color.from(
        alpha: 0.25,
        red: 0.0,
        green: 0.0,
        blue: 0.0,
        colorSpace: ColorSpace.sRGB,
      ),
    ),
  ];
}
