import 'dart:math';

import 'package:flutter/painting.dart';

export 'src/tailwind_gradient.dart';

extension AngleAlignment on Alignment {
  static Alignment fromAngle(num radians) =>
      Alignment(cos(radians), sin(radians));
}
