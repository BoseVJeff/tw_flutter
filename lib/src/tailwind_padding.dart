import 'package:flutter/painting.dart';
import 'package:tw_flutter/src/tailwind_sizes.dart';

class TwInsetsGeometry {
  static EdgeInsetsGeometry p(int n) =>
      EdgeInsetsGeometry.all(TwSize.baseSize * n);

  static EdgeInsetsGeometry px(int n) =>
      EdgeInsetsGeometry.symmetric(horizontal: TwSize.baseSize * n);

  static EdgeInsetsGeometry py(int n) =>
      EdgeInsetsGeometry.symmetric(vertical: TwSize.baseSize * n);

  static EdgeInsetsGeometry pt(int n) =>
      EdgeInsetsGeometry.only(top: TwSize.baseSize * n);
  static EdgeInsetsGeometry pb(int n) =>
      EdgeInsetsGeometry.only(bottom: TwSize.baseSize * n);
  static EdgeInsetsGeometry pl(int n) =>
      EdgeInsetsGeometry.only(left: TwSize.baseSize * n);
  static EdgeInsetsGeometry pr(int n) =>
      EdgeInsetsGeometry.only(right: TwSize.baseSize * n);

  static EdgeInsetsGeometry ps(int n) =>
      EdgeInsetsGeometry.directional(start: TwSize.baseSize * n);
  static EdgeInsetsGeometry pe(int n) =>
      EdgeInsetsGeometry.directional(end: TwSize.baseSize * n);
}
