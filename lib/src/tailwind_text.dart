import 'package:flutter/painting.dart';

/// All font sizes as defined in Tailwind
abstract class TwFontSizeRaw {
  static const xs = 12.0;

  static const sm = 14.0;

  static const base = 16.0;

  static const lg = 18.0;

  static const xl = 20.0;

  static const xl2 = 24.0;

  static const xl3 = 30.0;

  static const xl4 = 36.0;

  static const xl5 = 48.0;

  static const xl6 = 60.0;

  static const xl7 = 72.0;

  static const xl8 = 96.0;

  static const xl9 = 128.0;
}

/// All line heights as defined in Tailwind
abstract class TwLineHeightRaw {
  static const xs = 1.3333333333333333;

  static const sm = 1.4285714285714286;

  static const base = 1.5;

  static const lg = 1.5555555555555556;

  static const xl = 1.4;

  static const xl2 = 1.3333333333333333;

  static const xl3 = 1.2;

  static const xl4 = 1.1111111111111112;

  static const xl5 = 1.0;

  static const xl6 = 1.0;

  static const xl7 = 1.0;

  static const xl8 = 1.0;

  static const xl9 = 1.0;
}

/// All character spacings as defined in Tailwind
abstract class TwCharSpacingRaw {
  static const tighter = -0.05;

  static const tight = -0.025;

  static const normal = 0.0;

  static const wide = 0.025;

  static const wider = 0.05;

  static const widest = 0.1;
}

extension TwFontSize on TextStyle {
  TextStyle xs() {
    return copyWith(fontSize: TwFontSizeRaw.xs, height: TwLineHeightRaw.xs);
  }

  TextStyle sm() {
    return copyWith(fontSize: TwFontSizeRaw.sm, height: TwLineHeightRaw.sm);
  }

  TextStyle base() {
    return copyWith(fontSize: TwFontSizeRaw.base, height: TwLineHeightRaw.base);
  }

  TextStyle lg() {
    return copyWith(fontSize: TwFontSizeRaw.lg, height: TwLineHeightRaw.lg);
  }

  TextStyle xl() {
    return copyWith(fontSize: TwFontSizeRaw.xl, height: TwLineHeightRaw.xl);
  }

  TextStyle xl2() {
    return copyWith(fontSize: TwFontSizeRaw.xl2, height: TwLineHeightRaw.xl2);
  }

  TextStyle xl3() {
    return copyWith(fontSize: TwFontSizeRaw.xl3, height: TwLineHeightRaw.xl3);
  }

  TextStyle xl4() {
    return copyWith(fontSize: TwFontSizeRaw.xl4, height: TwLineHeightRaw.xl4);
  }

  TextStyle xl5() {
    return copyWith(fontSize: TwFontSizeRaw.xl5, height: TwLineHeightRaw.xl5);
  }

  TextStyle xl6() {
    return copyWith(fontSize: TwFontSizeRaw.xl6, height: TwLineHeightRaw.xl6);
  }

  TextStyle xl7() {
    return copyWith(fontSize: TwFontSizeRaw.xl7, height: TwLineHeightRaw.xl7);
  }

  TextStyle xl8() {
    return copyWith(fontSize: TwFontSizeRaw.xl8, height: TwLineHeightRaw.xl8);
  }

  TextStyle xl9() {
    return copyWith(fontSize: TwFontSizeRaw.xl9, height: TwLineHeightRaw.xl9);
  }
}

extension TwCharSpacing on TextStyle {
  TextStyle charTighter() {
    return copyWith(letterSpacing: TwCharSpacingRaw.tighter * (fontSize ?? 16));
  }

  TextStyle charTight() {
    return copyWith(letterSpacing: TwCharSpacingRaw.tight * (fontSize ?? 16));
  }

  TextStyle charNormal() {
    return copyWith(letterSpacing: TwCharSpacingRaw.normal * (fontSize ?? 16));
  }

  TextStyle charWide() {
    return copyWith(letterSpacing: TwCharSpacingRaw.wide * (fontSize ?? 16));
  }

  TextStyle charWider() {
    return copyWith(letterSpacing: TwCharSpacingRaw.wider * (fontSize ?? 16));
  }

  TextStyle charWidest() {
    return copyWith(letterSpacing: TwCharSpacingRaw.widest * (fontSize ?? 16));
  }
}
