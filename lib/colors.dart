import 'package:tw_flutter/src/tailwind_colors_material.dart';

export "src/tailwind_colors.dart";
export "src/tailwind_colors_hex.dart";
export "src/tailwind_colors_material.dart";

// This is done to setup default values
// It is set up as an alias so that it can be easily changed in the future.
// Right now, this is set to hex colors as it does not display correctly on Windows (with Impeller the darker shades are clipped to black, with Skia the colors are wrong)
// TODO: Raise an issue in the Flutter issue tracker and reset this to `TwMaterialColors` when it is fixed.
typedef TwColors = TwMaterialColors;
