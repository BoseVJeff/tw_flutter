import 'package:csslib/visitor.dart';
import 'package:helpers/consts.dart';

class TrackingVisitor extends Visitor {
  static const String prefix = "--tracking-";

  /// Multiply this by the font size to get the usable `px` value.
  Map<String, double> parsedTracking = {};
  double? value;

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      String name = node.property.substring(prefix.length);
      name = nameMapping[name] ?? name;

      node.expression!.visit(this);

      parsedTracking.addAll({name: value!});
    }
  }

  @override
  visitEmTerm(EmTerm node) {
    value = (node.value as num).toDouble();
  }
}

class LeadingVisitor extends Visitor {
  static const String prefix = "--leading-";

  /// Multiply this by the font size to get the usable `px` value.
  Map<String, double> parsedLeading = {};
  double? value;

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      String name = node.property.substring(prefix.length);
      name = nameMapping[name] ?? name;

      node.expression!.visit(this);

      parsedLeading.addAll({name: value!});
    }
  }

  @override
  visitNumberTerm(NumberTerm node) {
    value = (node.value as num).toDouble();
  }
}

class WeightVisitor extends Visitor {
  static const String prefix = "--font-weight-";

  /// Multiply this by the font size to get the usable `px` value.
  Map<String, double> parsedWeights = {};
  double? value;

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      String name = node.property.substring(prefix.length);
      name = nameMapping[name] ?? name;

      node.expression!.visit(this);

      parsedWeights.addAll({name: value!});
    }
  }

  @override
  visitNumberTerm(NumberTerm node) {
    value = (node.value as num).toDouble();
  }
}
