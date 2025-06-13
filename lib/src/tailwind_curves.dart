import 'package:flutter/animation.dart';

/// Curves as defined in Tailwind CSS
abstract class TwCurves {
  static final Cubic easeIn = Cubic(0.4, 0, 1, 1);

  static final Cubic easeOut = Cubic(0, 0, 0.2, 1);

  static final Cubic easeInOut = Cubic(0.4, 0, 0.2, 1);
}
