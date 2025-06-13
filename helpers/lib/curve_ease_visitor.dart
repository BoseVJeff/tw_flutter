import 'package:csslib/visitor.dart';
import 'package:logging/logging.dart';

class CurveEaseVisitor extends Visitor {
  static const String prefix = "--ease-";
  final Logger log = Logger("CurveEaseVisitor");
  Map<String, ({String fun, List<num> params})> parsedCurves = {};
  String? func;
  List<num> values = [];

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      String name = node.property.substring(prefix.length);
      log.fine("Parsing $name");
      func = null;
      values = [];
      node.expression!.visit(this);
      // print("$func : $values");
      parsedCurves.addAll({name: (fun: func!, params: values)});
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
