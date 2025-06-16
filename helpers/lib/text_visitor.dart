import 'package:csslib/visitor.dart';
import 'package:helpers/consts.dart';
import 'package:logging/logging.dart';
import 'package:sass/src/value.dart';
import 'package:sass_api/sass_api.dart' show SassCalculation, SassString;

class TextVisitor extends Visitor {
  static const String prefix = "--text-";
  static const String negPrefix = "--text-shadow-";
  static const String suffix = "--line-height";
  bool parsingHeight = false;
  // Map<String, ({num size, num height})> parsedSizes = {};
  Map<String, double> parsedSizes = {};
  Map<String, double> parsedHeights = {};
  num? size;
  num? height;
  final Logger log = Logger("Text Visitor");

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix) &&
        !node.property.startsWith(negPrefix)) {
      // log.fine(node.toDebugString());

      String name;
      if (node.property.endsWith(suffix)) {
        parsingHeight = true;
        name = node.property.substring(
          prefix.length,
          node.property.length - suffix.length,
        );
        name = nameMapping[name] ?? name;
        log.fine("Visiting $name...");
        node.expression!.visit(this);
        parsedHeights.addAll({name: height!.toDouble()});
      } else {
        parsingHeight = false;
        name = node.property.substring(prefix.length);
        name = nameMapping[name] ?? name;
        log.fine("Visiting $name...");
        node.expression!.visit(this);
        parsedSizes.addAll({name: size!.toDouble()});
      }
    }
  }

  @override
  visitRemTerm(RemTerm node) {
    log.fine("[${node.value.runtimeType}] ${node.value} rem");
    if (parsingHeight) {
      height = (node.value as num) * 16;
    } else {
      size = (node.value as num) * 16;
    }
  }

  @override
  visitNumberTerm(NumberTerm node) {
    log.fine("[${node.value.runtimeType}] ${node.value}");
    if (parsingHeight) {
      height = node.value as num;
    } else {
      size = node.value as num;
    }
  }

  @override
  visitCalcTerm(CalcTerm node) {
    Object calculation;
    if (node.expr.text.contains("/")) {
      calculation = SassCalculation.operate(
        CalculationOperator.dividedBy,
        SassNumber(num.parse(node.expr.text.split("/")[0].trim())),
        SassNumber(num.parse(node.expr.text.split("/")[1].trim())),
      );
    } else if (node.expr.text.contains("*")) {
      calculation = SassCalculation.operate(
        CalculationOperator.dividedBy,
        SassNumber(num.parse(node.expr.text.split("*")[0].trim())),
        SassNumber(num.parse(node.expr.text.split("*")[1].trim())),
      );
    } else if (node.expr.text.contains("+")) {
      calculation = SassCalculation.operate(
        CalculationOperator.dividedBy,
        SassNumber(num.parse(node.expr.text.split("+")[0].trim())),
        SassNumber(num.parse(node.expr.text.split("+")[1].trim())),
      );
    } else if (node.expr.text.contains("-")) {
      calculation = SassCalculation.operate(
        CalculationOperator.dividedBy,
        SassNumber(num.parse(node.expr.text.split("-")[0].trim())),
        SassNumber(num.parse(node.expr.text.split("-")[1].trim())),
      );
    } else {
      calculation = SassNumber(num.parse(node.expr.text));
    }

    log.fine(
      "[CALC] ${node.expr.text} (= [${calculation.runtimeType}] $calculation)",
    );

    if (parsingHeight) {
      height = (calculation as SassNumber).value;
    } else {
      size = (calculation as SassNumber).value;
    }
  }
}
