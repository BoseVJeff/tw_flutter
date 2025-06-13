import 'package:flutter/animation.dart';

/// Default transition properties as defined in Tailwind CSS
abstract class TwTransition {
  static final Duration duration = Duration(milliseconds: 150);

  static final Cubic curve = Cubic(0.4, 0.0, 0.2, 1.0);
}
