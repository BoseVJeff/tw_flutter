import 'dart:ui';

import 'src/tailwind_sizes.dart';

export 'src/tailwind_padding.dart';
export 'src/tailwind_sizes.dart';

extension NumberSizes on TwSize {
  double w(int n) => TwSize.baseSize * n;
  double h(int n) => TwSize.baseSize * n;
  Size size(int n) => Size.square(TwSize.baseSize * n);
}
