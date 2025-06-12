import 'package:csslib/parser.dart';
import 'package:csslib/visitor.dart';
import 'package:logging/logging.dart';
import 'package:sass_api/sass_api.dart' show ColorSpace, SassColor, SassNumber;

class TextShadowVisitor extends Visitor {
  static const String prefix = "--text-shadow-";
  static const Map<String, String> nameMapping = {"2xs": "xs2", "2xl": "xl2"};
  List<SassNumber> values = [];
  List<SassNumber> colorValues = [];
  String colorFunc = "";
  bool isColor = false;
  List<RawBoxShadow> shadows = [];
  Map<String, List<RawBoxShadow>> parsedShadows = {};

  final Logger log = Logger("ShadowVisitor");

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      String name = node.property.substring(prefix.length);
      name = nameMapping[name] ?? name;
      log.fine("Will parse ${node.property} as $name");
      // log.fine(node.toDebugString());

      if (node.expression != null) {
        values = [];
        node.expression!.visit(this);
        flush();

        parsedShadows[name] = shadows;

        shadows = [];

        // log.fine(node.expression!.toDebugString());
      }
    }
  }

  @override
  visitFunctionTerm(FunctionTerm node) {
    isColor = true;
    colorValues = [];
    colorFunc = node.text;
    super.visitFunctionTerm(node);
    log.fine("${node.text} $colorValues");
    isColor = false;
  }

  @override
  visitNumberTerm(NumberTerm node) {
    log.fine(
      "Visited number-term with value [${node.value.runtimeType}]${node.value}",
    );
    num rawValue;
    if (node.value is int) {
      rawValue = node.value as int;
    } else if (node.value is double) {
      rawValue = node.value as double;
    } else {
      rawValue = double.parse(node.text);
    }
    if (isColor) {
      SassNumber number = SassNumber(rawValue);
      colorValues.add(number);
    } else {
      SassNumber number = SassNumber(rawValue, "px");
      values.add(number);
    }
  }

  @override
  visitLengthTerm(LengthTerm node) {
    log.fine(
      "Visited number-term with value [${node.value.runtimeType}]${node.value} ${TokenKind.unitToString(node.unit)}",
    );
    num rawValue;
    if (node.value is int) {
      rawValue = node.value as int;
    } else if (node.value is double) {
      rawValue = node.value as double;
    } else {
      rawValue = double.parse(node.text);
    }
    SassNumber number = SassNumber(rawValue, TokenKind.unitToString(node.unit));
    values.add(number);
  }

  @override
  visitOperatorComma(OperatorComma node) {
    log.fine(
      "Visited <comma>! | val: $values | cVal: [$colorFunc] $colorValues",
    );
    flush();
  }

  void flush() {
    // Parse color
    ColorSpace space;
    switch (colorFunc) {
      case "rgb":
      case "rgba":
        space = ColorSpace.rgb;
        break;
      default:
        log.fine("[WARN] $colorFunc not defined!");
        space = ColorSpace.rgb;
        break;
    }
    SassColor color = SassColor.forSpace(
      space,
      colorValues.take(3).map((e) => e.value).toList(),
      colorValues[3].value,
    );

    // Parse shadow values
    if (values.length == 2) {
      // Just x,y
      shadows.add(
        RawBoxShadow(x: values[0].value, y: values[1].value, color: color),
      );
    } else if (values.length == 3) {
      // Just x,y,blur
      shadows.add(
        RawBoxShadow(
          x: values[0].value,
          y: values[1].value,
          blur: values[2].value,
          color: color,
        ),
      );
    } else if (values.length == 4) {
      // x,y,blur,spread
      shadows.add(
        RawBoxShadow(
          x: values[0].value,
          y: values[1].value,
          blur: values[2].value,
          spread: values[3].value,
          color: color,
        ),
      );
    } else {
      throw FormatException(
        "Expected 2/3/4 values, got ${values.length} values!",
      );
    }
    // Reset all buffers
    values = [];
    colorValues = [];
    colorFunc = "";
  }
}

class RawBoxShadow {
  final double x;
  final double y;
  final double blur;
  final double spread;
  final SassColor? color;

  const RawBoxShadow({
    required this.x,
    required this.y,
    this.blur = 0,
    this.spread = 0,
    this.color,
  });

  @override
  String toString() {
    return "box-shadow($x, $y, $blur, $spread, ${color?.toCssString()})";
  }
}
