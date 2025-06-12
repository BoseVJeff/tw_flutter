import 'dart:math';

import 'package:flutter/painting.dart';
// import 'package:vector_math/vector_math_64.dart';

List<double> _generateStops(num start, num end, int count) {
  return List.generate(
    count,
    (i) => (start + i * ((end - start) / (count - 1))) / 100,
  );
}

abstract class TailwindGradient {
  static LinearGradient linear(
    Alignment toDirection,
    List<Color> colors, {
    int? from,
    int? to,
  }) => LinearGradient(
    colors: colors,
    begin: toDirection * -1,
    end: toDirection,
    tileMode: TileMode.clamp,
    stops: ((from == null) && (to == null))
        ? null
        : _generateStops(from ?? 0, to ?? 100, colors.length),
  );

  static LinearGradient linearWithStops(
    Alignment toDirection,
    Map<double, Color> stops,
  ) => LinearGradient(
    colors: stops.values.toList(),
    stops: stops.keys.toList(),
    begin: toDirection * -1,
    end: toDirection,
    tileMode: TileMode.clamp,
  );

  static RadialGradient radial(
    List<Color> colors, {
    int? from,
    int? to,
    Alignment at = Alignment.center,
    Alignment center = Alignment.center,
  }) => RadialGradient(
    colors: colors,
    center: center,
    focal: at,
    // transform: GradientTranslation(at.x, at.y),
    stops: ((from == null) && (to == null))
        ? null
        : _generateStops(from ?? 0, to ?? 100, colors.length),
  );

  static RadialGradient radialWithStops(
    Map<double, Color> stops, {
    Alignment at = Alignment.center,
    Alignment center = Alignment.center,
  }) => RadialGradient(
    colors: stops.values.toList(),
    stops: stops.keys.toList(),
    center: center,
    focal: at,
    // transform: GradientTranslation(at.x, at.y),
  );

  static SweepGradient conic(
    List<Color> colors, {
    int? from,
    int? to,
    int rotation = 0,
  }) => SweepGradient(
    colors: colors,
    stops: ((from == null) && (to == null))
        ? null
        : _generateStops(from ?? 0, to ?? 100, colors.length),
    transform: GradientRotation(((rotation - 90) * pi) / 180),
  );

  static SweepGradient conicWithStops(Map<double, Color> stops) =>
      SweepGradient(colors: stops.values.toList(), stops: stops.keys.toList());
}

// class GradientTranslation implements GradientTransform {
//   final double x;
//   final double y;

//   const GradientTranslation(this.x, this.y);

//   @override
//   Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
//     return Matrix4.identity()
//       ..translate(x * (bounds.width), y * (bounds.height))
//     // ..scale(1 + x, 1 + y)
//     ;
//   }
// }
