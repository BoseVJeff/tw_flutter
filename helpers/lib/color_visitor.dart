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
            "[$colorName${(shade == null) ? '' : ':$shade'}] $sassColor -> ${sassColor.toSpace(ColorSpace.displayP3)}",
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
    colorSpace = ColorSpace.a98Rgb;
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
  "transparent": SassColor.a98Rgb(0, 0, 0, 0),
  "aliceblue": SassColor.a98Rgb(240, 248, 255, 1),
  "antiquewhite": SassColor.a98Rgb(250, 235, 215, 1),
  "aqua": SassColor.a98Rgb(0, 255, 255, 1),
  "aquamarine": SassColor.a98Rgb(127, 255, 212, 1),
  "azure": SassColor.a98Rgb(240, 255, 255, 1),
  "beige": SassColor.a98Rgb(245, 245, 220, 1),
  "bisque": SassColor.a98Rgb(255, 228, 196, 1),
  "black": SassColor.a98Rgb(0, 0, 0, 1),
  "blanchedalmond": SassColor.a98Rgb(255, 235, 205, 1),
  "blue": SassColor.a98Rgb(0, 0, 255, 1),
  "blueviolet": SassColor.a98Rgb(138, 43, 226, 1),
  "brown": SassColor.a98Rgb(165, 42, 42, 1),
  "burlywood": SassColor.a98Rgb(222, 184, 135, 1),
  "cadetblue": SassColor.a98Rgb(95, 158, 160, 1),
  "chartreuse": SassColor.a98Rgb(127, 255, 0, 1),
  "chocolate": SassColor.a98Rgb(210, 105, 30, 1),
  "coral": SassColor.a98Rgb(255, 127, 80, 1),
  "cornflowerblue": SassColor.a98Rgb(100, 149, 237, 1),
  "cornsilk": SassColor.a98Rgb(255, 248, 220, 1),
  "crimson": SassColor.a98Rgb(220, 20, 60, 1),
  "cyan": SassColor.a98Rgb(0, 255, 255, 1),
  "darkblue": SassColor.a98Rgb(0, 0, 139, 1),
  "darkcyan": SassColor.a98Rgb(0, 139, 139, 1),
  "darkgoldenrod": SassColor.a98Rgb(184, 134, 11, 1),
  "darkgray": SassColor.a98Rgb(169, 169, 169, 1),
  "darkgreen": SassColor.a98Rgb(0, 100, 0, 1),
  "darkgrey": SassColor.a98Rgb(169, 169, 169, 1),
  "darkkhaki": SassColor.a98Rgb(189, 183, 107, 1),
  "darkmagenta": SassColor.a98Rgb(139, 0, 139, 1),
  "darkolivegreen": SassColor.a98Rgb(85, 107, 47, 1),
  "darkorange": SassColor.a98Rgb(255, 140, 0, 1),
  "darkorchid": SassColor.a98Rgb(153, 50, 204, 1),
  "darkred": SassColor.a98Rgb(139, 0, 0, 1),
  "darksalmon": SassColor.a98Rgb(233, 150, 122, 1),
  "darkseagreen": SassColor.a98Rgb(143, 188, 143, 1),
  "darkslateblue": SassColor.a98Rgb(72, 61, 139, 1),
  "darkslategray": SassColor.a98Rgb(47, 79, 79, 1),
  "darkslategrey": SassColor.a98Rgb(47, 79, 79, 1),
  "darkturquoise": SassColor.a98Rgb(0, 206, 209, 1),
  "darkviolet": SassColor.a98Rgb(148, 0, 211, 1),
  "deeppink": SassColor.a98Rgb(255, 20, 147, 1),
  "deepskyblue": SassColor.a98Rgb(0, 191, 255, 1),
  "dimgray": SassColor.a98Rgb(105, 105, 105, 1),
  "dimgrey": SassColor.a98Rgb(105, 105, 105, 1),
  "dodgerblue": SassColor.a98Rgb(30, 144, 255, 1),
  "firebrick": SassColor.a98Rgb(178, 34, 34, 1),
  "floralwhite": SassColor.a98Rgb(255, 250, 240, 1),
  "forestgreen": SassColor.a98Rgb(34, 139, 34, 1),
  "fuchsia": SassColor.a98Rgb(255, 0, 255, 1),
  "gainsboro": SassColor.a98Rgb(220, 220, 220, 1),
  "ghostwhite": SassColor.a98Rgb(248, 248, 255, 1),
  "gold": SassColor.a98Rgb(255, 215, 0, 1),
  "goldenrod": SassColor.a98Rgb(218, 165, 32, 1),
  "gray": SassColor.a98Rgb(128, 128, 128, 1),
  "green": SassColor.a98Rgb(0, 128, 0, 1),
  "greenyellow": SassColor.a98Rgb(173, 255, 47, 1),
  "grey": SassColor.a98Rgb(128, 128, 128, 1),
  "honeydew": SassColor.a98Rgb(240, 255, 240, 1),
  "hotpink": SassColor.a98Rgb(255, 105, 180, 1),
  "indianred": SassColor.a98Rgb(205, 92, 92, 1),
  "indigo": SassColor.a98Rgb(75, 0, 130, 1),
  "ivory": SassColor.a98Rgb(255, 255, 240, 1),
  "khaki": SassColor.a98Rgb(240, 230, 140, 1),
  "lavender": SassColor.a98Rgb(230, 230, 250, 1),
  "lavenderblush": SassColor.a98Rgb(255, 240, 245, 1),
  "lawngreen": SassColor.a98Rgb(124, 252, 0, 1),
  "lemonchiffon": SassColor.a98Rgb(255, 250, 205, 1),
  "lightblue": SassColor.a98Rgb(173, 216, 230, 1),
  "lightcoral": SassColor.a98Rgb(240, 128, 128, 1),
  "lightcyan": SassColor.a98Rgb(224, 255, 255, 1),
  "lightgoldenrodyellow": SassColor.a98Rgb(250, 250, 210, 1),
  "lightgray": SassColor.a98Rgb(211, 211, 211, 1),
  "lightgreen": SassColor.a98Rgb(144, 238, 144, 1),
  "lightgrey": SassColor.a98Rgb(211, 211, 211, 1),
  "lightpink": SassColor.a98Rgb(255, 182, 193, 1),
  "lightsalmon": SassColor.a98Rgb(255, 160, 122, 1),
  "lightseagreen": SassColor.a98Rgb(32, 178, 170, 1),
  "lightskyblue": SassColor.a98Rgb(135, 206, 250, 1),
  "lightslategray": SassColor.a98Rgb(119, 136, 153, 1),
  "lightslategrey": SassColor.a98Rgb(119, 136, 153, 1),
  "lightsteelblue": SassColor.a98Rgb(176, 196, 222, 1),
  "lightyellow": SassColor.a98Rgb(255, 255, 224, 1),
  "lime": SassColor.a98Rgb(0, 255, 0, 1),
  "limegreen": SassColor.a98Rgb(50, 205, 50, 1),
  "linen": SassColor.a98Rgb(250, 240, 230, 1),
  "magenta": SassColor.a98Rgb(255, 0, 255, 1),
  "maroon": SassColor.a98Rgb(128, 0, 0, 1),
  "mediumaquamarine": SassColor.a98Rgb(102, 205, 170, 1),
  "mediumblue": SassColor.a98Rgb(0, 0, 205, 1),
  "mediumorchid": SassColor.a98Rgb(186, 85, 211, 1),
  "mediumpurple": SassColor.a98Rgb(147, 112, 219, 1),
  "mediumseagreen": SassColor.a98Rgb(60, 179, 113, 1),
  "mediumslateblue": SassColor.a98Rgb(123, 104, 238, 1),
  "mediumspringgreen": SassColor.a98Rgb(0, 250, 154, 1),
  "mediumturquoise": SassColor.a98Rgb(72, 209, 204, 1),
  "mediumvioletred": SassColor.a98Rgb(199, 21, 133, 1),
  "midnightblue": SassColor.a98Rgb(25, 25, 112, 1),
  "mintcream": SassColor.a98Rgb(245, 255, 250, 1),
  "mistyrose": SassColor.a98Rgb(255, 228, 225, 1),
  "moccasin": SassColor.a98Rgb(255, 228, 181, 1),
  "navajowhite": SassColor.a98Rgb(255, 222, 173, 1),
  "navy": SassColor.a98Rgb(0, 0, 128, 1),
  "oldlace": SassColor.a98Rgb(253, 245, 230, 1),
  "olive": SassColor.a98Rgb(128, 128, 0, 1),
  "olivedrab": SassColor.a98Rgb(107, 142, 35, 1),
  "orange": SassColor.a98Rgb(255, 165, 0, 1),
  "orangered": SassColor.a98Rgb(255, 69, 0, 1),
  "orchid": SassColor.a98Rgb(218, 112, 214, 1),
  "palegoldenrod": SassColor.a98Rgb(238, 232, 170, 1),
  "palegreen": SassColor.a98Rgb(152, 251, 152, 1),
  "paleturquoise": SassColor.a98Rgb(175, 238, 238, 1),
  "palevioletred": SassColor.a98Rgb(219, 112, 147, 1),
  "papayawhip": SassColor.a98Rgb(255, 239, 213, 1),
  "peachpuff": SassColor.a98Rgb(255, 218, 185, 1),
  "peru": SassColor.a98Rgb(205, 133, 63, 1),
  "pink": SassColor.a98Rgb(255, 192, 203, 1),
  "plum": SassColor.a98Rgb(221, 160, 221, 1),
  "powderblue": SassColor.a98Rgb(176, 224, 230, 1),
  "purple": SassColor.a98Rgb(128, 0, 128, 1),
  "rebeccapurple": SassColor.a98Rgb(102, 51, 153, 1),
  "red": SassColor.a98Rgb(255, 0, 0, 1),
  "rosybrown": SassColor.a98Rgb(188, 143, 143, 1),
  "royalblue": SassColor.a98Rgb(65, 105, 225, 1),
  "saddlebrown": SassColor.a98Rgb(139, 69, 19, 1),
  "salmon": SassColor.a98Rgb(250, 128, 114, 1),
  "sandybrown": SassColor.a98Rgb(244, 164, 96, 1),
  "seagreen": SassColor.a98Rgb(46, 139, 87, 1),
  "seashell": SassColor.a98Rgb(255, 245, 238, 1),
  "sienna": SassColor.a98Rgb(160, 82, 45, 1),
  "silver": SassColor.a98Rgb(192, 192, 192, 1),
  "skyblue": SassColor.a98Rgb(135, 206, 235, 1),
  "slateblue": SassColor.a98Rgb(106, 90, 205, 1),
  "slategray": SassColor.a98Rgb(112, 128, 144, 1),
  "slategrey": SassColor.a98Rgb(112, 128, 144, 1),
  "snow": SassColor.a98Rgb(255, 250, 250, 1),
  "springgreen": SassColor.a98Rgb(0, 255, 127, 1),
  "steelblue": SassColor.a98Rgb(70, 130, 180, 1),
  "tan": SassColor.a98Rgb(210, 180, 140, 1),
  "teal": SassColor.a98Rgb(0, 128, 128, 1),
  "thistle": SassColor.a98Rgb(216, 191, 216, 1),
  "tomato": SassColor.a98Rgb(255, 99, 71, 1),
  "turquoise": SassColor.a98Rgb(64, 224, 208, 1),
  "violet": SassColor.a98Rgb(238, 130, 238, 1),
  "wheat": SassColor.a98Rgb(245, 222, 179, 1),
  "white": SassColor.a98Rgb(255, 255, 255, 1),
  "whitesmoke": SassColor.a98Rgb(245, 245, 245, 1),
  "yellow": SassColor.a98Rgb(255, 255, 0, 1),
  "yellowgreen": SassColor.a98Rgb(154, 205, 50, 1),
};
