import 'package:csslib/visitor.dart';
import 'package:logging/logging.dart';
import 'package:sass_api/sass_api.dart' show ColorSpace, SassColor;

class ColorVisitor extends Visitor {
  static const String prefix = "--color-";

  final Logger log = Logger("ColorVisitor");

  ColorSpace? colorSpace;
  List<double> values = [];
  Map<String, Map<int, SassColor>> parsedSwatches = {};
  Map<String, SassColor> parsedColors = {};

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      // Filter for colors only
      log.fine("Will parse ${node.property}!");
      // Has a value assigned
      if (node.expression != null) {
        // Empty out state so that values infered from visiting nodes can fill them.
        // This ensures that older values are not accidentaly used.
        values = [];
        colorSpace = null;

        // Visit all nodes in the declaration and get all parameters
        node.expression!.visit(this);

        // Parse the property name to get the color name and shade (if available)
        List<String> nameParts = node.property
            .substring(prefix.length)
            .split("-");
        int? shade = int.tryParse(nameParts.last);
        String colorName;
        // Build the color name, joining parts with `_` to ensure that the names are hopefully valid Dart variable names.
        // TODO: Generate lowerCamelCased names instead
        if (shade != null) {
          // The last part is the shade, not to be included in the color name.
          colorName = nameParts.take(nameParts.length - 1).join("_");
        } else {
          // No shade
          colorName = nameParts.join("_");
        }
        // TODO: Check if the color name is a valid Dart identifier.

        // Missing color-space usually indicates use of a literal color or a hex value.
        // Currently, only hex values are supported.
        // TODO: Add support for literal values (`color: black;`, etc).
        SassColor sassColor;
        if (colorSpace != null) {
          sassColor = SassColor.forSpace(colorSpace!, values);
          log.fine(
            "[$colorName${(shade == null) ? '' : ':$shade'}] ${sassColor.toCssString()} -> ${sassColor.toSpace(ColorSpace.displayP3).toCssString()}",
          );
        } else {
          sassColor = colorMap[node.property.substring(prefix.length)]!;
          log.fine(
            "[$colorName${(shade == null) ? '' : ':$shade'}] ${colorMap[node.property.substring(prefix.length)]}",
          );
        }

        if (shade == null) {
          // These are independent colors with no swatches.
          // Mantain these seperately.
          if (!parsedColors.containsKey(colorName)) {
            parsedColors.addAll({colorName: sassColor});
          }
        } else {
          // Color has shades and therefore belongs to a swatch.
          // Create and mantain the swatches seperately.
          if (!parsedSwatches.containsKey(colorName)) {
            parsedSwatches.addAll({colorName: {}});
          }
          parsedSwatches[colorName]!.addAll({shade: sassColor});
        }

        // Reset visitor state
        values = [];
        colorSpace = null;
      }
    }
  }

  @override
  visitPercentageTerm(PercentageTerm node) {
    values.add((node.value as num) / 100);
  }

  @override
  visitNumberTerm(NumberTerm node) {
    values.add((node.value as num).toDouble());
  }

  @override
  visitHexColorTerm(HexColorTerm node) {
    // colorFunction = ColorFunction.hex;
    // values.add((node.value as int).toDouble());
    colorSpace = ColorSpace.srgb;
    int value = node.value as int;
    if (value <= 0xfff) {
      values = [
        (((value >> 8) & 0xf) * 0x11).toDouble(),
        (((value >> 4) & 0xf) * 0x11).toDouble(),
        ((value & 0xf) * 0x11).toDouble(),
      ];
    } else if (value <= 0xffffff) {
      values = [
        ((value >> 16) & 0xff).toDouble(),
        ((value >> 8) & 0xff).toDouble(),
        (value & 0xff).toDouble(),
      ];
    } else {
      throw FormatException(
        "Hex color is not #rgb or #rrggbb. It is #${value.toRadixString(16)}",
        value,
      );
    }
    // log.fine("Hex values parsed: $values");
  }

  @override
  visitFunctionTerm(FunctionTerm node) {
    colorSpace = ColorSpace.fromName(node.text);
    super.visitFunctionTerm(node);
  }

  @override
  visitLiteralTerm(LiteralTerm node) {
    // log.fine("[${node.value.runtimeType}] ${node.value}");
  }
}

// Taken from https://drafts.csswg.org/css-color-4/#named-colors
final Map<String, SassColor> colorMap = {
  "transparent": SassColor.rgb(0, 0, 0, 0),
  "aliceblue": SassColor.rgb(240, 248, 255, 1),
  "antiquewhite": SassColor.rgb(250, 235, 215, 1),
  "aqua": SassColor.rgb(0, 255, 255, 1),
  "aquamarine": SassColor.rgb(127, 255, 212, 1),
  "azure": SassColor.rgb(240, 255, 255, 1),
  "beige": SassColor.rgb(245, 245, 220, 1),
  "bisque": SassColor.rgb(255, 228, 196, 1),
  "black": SassColor.rgb(0, 0, 0, 1),
  "blanchedalmond": SassColor.rgb(255, 235, 205, 1),
  "blue": SassColor.rgb(0, 0, 255, 1),
  "blueviolet": SassColor.rgb(138, 43, 226, 1),
  "brown": SassColor.rgb(165, 42, 42, 1),
  "burlywood": SassColor.rgb(222, 184, 135, 1),
  "cadetblue": SassColor.rgb(95, 158, 160, 1),
  "chartreuse": SassColor.rgb(127, 255, 0, 1),
  "chocolate": SassColor.rgb(210, 105, 30, 1),
  "coral": SassColor.rgb(255, 127, 80, 1),
  "cornflowerblue": SassColor.rgb(100, 149, 237, 1),
  "cornsilk": SassColor.rgb(255, 248, 220, 1),
  "crimson": SassColor.rgb(220, 20, 60, 1),
  "cyan": SassColor.rgb(0, 255, 255, 1),
  "darkblue": SassColor.rgb(0, 0, 139, 1),
  "darkcyan": SassColor.rgb(0, 139, 139, 1),
  "darkgoldenrod": SassColor.rgb(184, 134, 11, 1),
  "darkgray": SassColor.rgb(169, 169, 169, 1),
  "darkgreen": SassColor.rgb(0, 100, 0, 1),
  "darkgrey": SassColor.rgb(169, 169, 169, 1),
  "darkkhaki": SassColor.rgb(189, 183, 107, 1),
  "darkmagenta": SassColor.rgb(139, 0, 139, 1),
  "darkolivegreen": SassColor.rgb(85, 107, 47, 1),
  "darkorange": SassColor.rgb(255, 140, 0, 1),
  "darkorchid": SassColor.rgb(153, 50, 204, 1),
  "darkred": SassColor.rgb(139, 0, 0, 1),
  "darksalmon": SassColor.rgb(233, 150, 122, 1),
  "darkseagreen": SassColor.rgb(143, 188, 143, 1),
  "darkslateblue": SassColor.rgb(72, 61, 139, 1),
  "darkslategray": SassColor.rgb(47, 79, 79, 1),
  "darkslategrey": SassColor.rgb(47, 79, 79, 1),
  "darkturquoise": SassColor.rgb(0, 206, 209, 1),
  "darkviolet": SassColor.rgb(148, 0, 211, 1),
  "deeppink": SassColor.rgb(255, 20, 147, 1),
  "deepskyblue": SassColor.rgb(0, 191, 255, 1),
  "dimgray": SassColor.rgb(105, 105, 105, 1),
  "dimgrey": SassColor.rgb(105, 105, 105, 1),
  "dodgerblue": SassColor.rgb(30, 144, 255, 1),
  "firebrick": SassColor.rgb(178, 34, 34, 1),
  "floralwhite": SassColor.rgb(255, 250, 240, 1),
  "forestgreen": SassColor.rgb(34, 139, 34, 1),
  "fuchsia": SassColor.rgb(255, 0, 255, 1),
  "gainsboro": SassColor.rgb(220, 220, 220, 1),
  "ghostwhite": SassColor.rgb(248, 248, 255, 1),
  "gold": SassColor.rgb(255, 215, 0, 1),
  "goldenrod": SassColor.rgb(218, 165, 32, 1),
  "gray": SassColor.rgb(128, 128, 128, 1),
  "green": SassColor.rgb(0, 128, 0, 1),
  "greenyellow": SassColor.rgb(173, 255, 47, 1),
  "grey": SassColor.rgb(128, 128, 128, 1),
  "honeydew": SassColor.rgb(240, 255, 240, 1),
  "hotpink": SassColor.rgb(255, 105, 180, 1),
  "indianred": SassColor.rgb(205, 92, 92, 1),
  "indigo": SassColor.rgb(75, 0, 130, 1),
  "ivory": SassColor.rgb(255, 255, 240, 1),
  "khaki": SassColor.rgb(240, 230, 140, 1),
  "lavender": SassColor.rgb(230, 230, 250, 1),
  "lavenderblush": SassColor.rgb(255, 240, 245, 1),
  "lawngreen": SassColor.rgb(124, 252, 0, 1),
  "lemonchiffon": SassColor.rgb(255, 250, 205, 1),
  "lightblue": SassColor.rgb(173, 216, 230, 1),
  "lightcoral": SassColor.rgb(240, 128, 128, 1),
  "lightcyan": SassColor.rgb(224, 255, 255, 1),
  "lightgoldenrodyellow": SassColor.rgb(250, 250, 210, 1),
  "lightgray": SassColor.rgb(211, 211, 211, 1),
  "lightgreen": SassColor.rgb(144, 238, 144, 1),
  "lightgrey": SassColor.rgb(211, 211, 211, 1),
  "lightpink": SassColor.rgb(255, 182, 193, 1),
  "lightsalmon": SassColor.rgb(255, 160, 122, 1),
  "lightseagreen": SassColor.rgb(32, 178, 170, 1),
  "lightskyblue": SassColor.rgb(135, 206, 250, 1),
  "lightslategray": SassColor.rgb(119, 136, 153, 1),
  "lightslategrey": SassColor.rgb(119, 136, 153, 1),
  "lightsteelblue": SassColor.rgb(176, 196, 222, 1),
  "lightyellow": SassColor.rgb(255, 255, 224, 1),
  "lime": SassColor.rgb(0, 255, 0, 1),
  "limegreen": SassColor.rgb(50, 205, 50, 1),
  "linen": SassColor.rgb(250, 240, 230, 1),
  "magenta": SassColor.rgb(255, 0, 255, 1),
  "maroon": SassColor.rgb(128, 0, 0, 1),
  "mediumaquamarine": SassColor.rgb(102, 205, 170, 1),
  "mediumblue": SassColor.rgb(0, 0, 205, 1),
  "mediumorchid": SassColor.rgb(186, 85, 211, 1),
  "mediumpurple": SassColor.rgb(147, 112, 219, 1),
  "mediumseagreen": SassColor.rgb(60, 179, 113, 1),
  "mediumslateblue": SassColor.rgb(123, 104, 238, 1),
  "mediumspringgreen": SassColor.rgb(0, 250, 154, 1),
  "mediumturquoise": SassColor.rgb(72, 209, 204, 1),
  "mediumvioletred": SassColor.rgb(199, 21, 133, 1),
  "midnightblue": SassColor.rgb(25, 25, 112, 1),
  "mintcream": SassColor.rgb(245, 255, 250, 1),
  "mistyrose": SassColor.rgb(255, 228, 225, 1),
  "moccasin": SassColor.rgb(255, 228, 181, 1),
  "navajowhite": SassColor.rgb(255, 222, 173, 1),
  "navy": SassColor.rgb(0, 0, 128, 1),
  "oldlace": SassColor.rgb(253, 245, 230, 1),
  "olive": SassColor.rgb(128, 128, 0, 1),
  "olivedrab": SassColor.rgb(107, 142, 35, 1),
  "orange": SassColor.rgb(255, 165, 0, 1),
  "orangered": SassColor.rgb(255, 69, 0, 1),
  "orchid": SassColor.rgb(218, 112, 214, 1),
  "palegoldenrod": SassColor.rgb(238, 232, 170, 1),
  "palegreen": SassColor.rgb(152, 251, 152, 1),
  "paleturquoise": SassColor.rgb(175, 238, 238, 1),
  "palevioletred": SassColor.rgb(219, 112, 147, 1),
  "papayawhip": SassColor.rgb(255, 239, 213, 1),
  "peachpuff": SassColor.rgb(255, 218, 185, 1),
  "peru": SassColor.rgb(205, 133, 63, 1),
  "pink": SassColor.rgb(255, 192, 203, 1),
  "plum": SassColor.rgb(221, 160, 221, 1),
  "powderblue": SassColor.rgb(176, 224, 230, 1),
  "purple": SassColor.rgb(128, 0, 128, 1),
  "rebeccapurple": SassColor.rgb(102, 51, 153, 1),
  "red": SassColor.rgb(255, 0, 0, 1),
  "rosybrown": SassColor.rgb(188, 143, 143, 1),
  "royalblue": SassColor.rgb(65, 105, 225, 1),
  "saddlebrown": SassColor.rgb(139, 69, 19, 1),
  "salmon": SassColor.rgb(250, 128, 114, 1),
  "sandybrown": SassColor.rgb(244, 164, 96, 1),
  "seagreen": SassColor.rgb(46, 139, 87, 1),
  "seashell": SassColor.rgb(255, 245, 238, 1),
  "sienna": SassColor.rgb(160, 82, 45, 1),
  "silver": SassColor.rgb(192, 192, 192, 1),
  "skyblue": SassColor.rgb(135, 206, 235, 1),
  "slateblue": SassColor.rgb(106, 90, 205, 1),
  "slategray": SassColor.rgb(112, 128, 144, 1),
  "slategrey": SassColor.rgb(112, 128, 144, 1),
  "snow": SassColor.rgb(255, 250, 250, 1),
  "springgreen": SassColor.rgb(0, 255, 127, 1),
  "steelblue": SassColor.rgb(70, 130, 180, 1),
  "tan": SassColor.rgb(210, 180, 140, 1),
  "teal": SassColor.rgb(0, 128, 128, 1),
  "thistle": SassColor.rgb(216, 191, 216, 1),
  "tomato": SassColor.rgb(255, 99, 71, 1),
  "turquoise": SassColor.rgb(64, 224, 208, 1),
  "violet": SassColor.rgb(238, 130, 238, 1),
  "wheat": SassColor.rgb(245, 222, 179, 1),
  "white": SassColor.rgb(255, 255, 255, 1),
  "whitesmoke": SassColor.rgb(245, 245, 245, 1),
  "yellow": SassColor.rgb(255, 255, 0, 1),
  "yellowgreen": SassColor.rgb(154, 205, 50, 1),
};
