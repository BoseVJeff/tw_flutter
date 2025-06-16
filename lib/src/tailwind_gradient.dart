import 'dart:math';

import 'package:flutter/painting.dart';
// import 'package:vector_math/vector_math_64.dart';

List<double> _generateStops(double start, double end, int count) {
  return List.generate(count, (i) => start + i * ((end - start) / (count - 1)));
}

abstract class TailwindGradient {
  static LinearGradient linear(
    Alignment toDirection,
    List<Color> colors, {
    double? from,
    double? to,
  }) => LinearGradient(
    colors: colors,
    begin: toDirection * -1,
    end: toDirection,
    tileMode: TileMode.clamp,
    stops: ((from == null) && (to == null))
        ? null
        : _generateStops(from ?? 0, to ?? 1, colors.length),
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
    double? from,
    double? to,
    Alignment at = Alignment.center,
  }) => RadialGradient(
    colors: colors,
    // center: (at + Alignment(1, 1)) / 2,
    center: at,
    // focal: at,
    // transform: GradientTranslation(at.x, at.y),
    // radius: max(1, sqrt2 * (to ?? 1)),
    stops: ((from == null) && (to == null))
        ? null
        : _generateStops(from ?? 0, to ?? 1, colors.length),
  );

  static RadialGradient radialWithStops(
    Map<double, Color> stops, {
    Alignment at = Alignment.center,
  }) => RadialGradient(
    colors: stops.values.toList(),
    stops: stops.keys.toList(),
    center: at,
    radius: max(
      1,
      sqrt(pow(2 * at.x, 2) + pow(2 * at.y, 2)) *
          (stops.keys.last - stops.keys.elementAt(stops.keys.length - 2)),
      // sqrt2 * (stops.keys.last - stops.keys.elementAt(stops.keys.length - 2)),
    ),
    // radius: 1.06,
    // center: center,
    // focal: at,
    // transform: GradientTranslation(at.x, at.y),
  );

  static SweepGradient conic(
    List<Color> colors, {
    double? from,
    double? to,
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
