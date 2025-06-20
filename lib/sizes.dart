import 'dart:ui';

import 'package:tw_flutter/src/tailwind_padding.dart';

import 'src/tailwind_sizes.dart';

export 'src/tailwind_padding.dart';
export 'src/tailwind_sizes.dart';

// Flutter uses the same `EdgeInsetsGeometry` for both padding and margin.
// These typedefs exist purely for user familiarity
typedef TwPadding = TwInsetsGeometry;
typedef TwMargin = TwInsetsGeometry;

extension NumberSizes on TwSize {
  double w(int n) => TwSize.baseSize * n;
  double h(int n) => TwSize.baseSize * n;
  Size size(int n) => Size.square(TwSize.baseSize * n);
}
