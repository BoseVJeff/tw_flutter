import 'package:csslib/visitor.dart';
import 'package:logging/logging.dart';

class DefaultTransitionVisitor extends Visitor {
  static const String prefix = "--default-transition-";
  List<String> parsedTransition = [];
  final Logger log = Logger("DefaultTransitionVisitor");
  List<num> values = [];
  String? func;
  num? durationMs;
  List<double>? curveValues;

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      var propName = node.property.substring(prefix.length);
      log.fine("[${node.property}] Parsing $propName");
      values = [];
      node.expression!.visit(this);
      log.fine(func);
      log.fine(values);
      parsedTransition.add(propName);
      if (func != null) {
        // Transition function
        curveValues = values.map((e) => e.toDouble()).toList();
      } else {
        // Transition timing
        durationMs = values.first;
      }
    }
  }

  @override
  visitTimeTerm(TimeTerm node) {
    log.fine(
      "[${node.value.runtimeType}] ${node.value} ${node.unitToString()}",
    );
    if (node.unitToString() == "ms") {
      Object val = node.value;
      if (val is double) {
        values.add(val);
      } else if (val is int) {
        values.add(val);
      } else if (val is num) {
        values.add(val);
      } else if (val is String) {
        values.add(num.parse(val));
      } else {
        values.add(num.parse(val.toString()));
      }
    } else {
      log.warning(
        "Time value `${node.value}` is in `${node.unitToString()}` instead of `ms`. Ignored!",
      );
    }
  }

  @override
  visitFunctionTerm(FunctionTerm node) {
    log.fine("Visited function ${node.text}");
    func = node.text;
    if (func != "cubic-bezier") {
      log.warning("Curve is not Cubic bezier, is `$func`");
    }
    super.visitFunctionTerm(node);
  }

  @override
  visitNumberTerm(NumberTerm node) {
    log.fine("${node.value.runtimeType} ${node.value}");
    Object val = node.value;
    if (val is double) {
      values.add(val);
    } else if (val is int) {
      values.add(val);
    } else if (val is num) {
      values.add(val);
    } else if (val is String) {
      values.add(num.parse(val));
    } else {
      values.add(num.parse(val.toString()));
    }
  }
}
