import 'package:csslib/visitor.dart';
import 'package:helpers/consts.dart';
import 'package:logging/logging.dart';

class ContainerBreakpointVisitor extends Visitor {
  static const String prefix = "--container-";
  Map<String, num> parsedBreakpoints = {};
  num? value;
  Logger log = Logger("BreakpointVisitor");

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      String name = node.property.substring(prefix.length);
      name = nameMapping[name] ?? name;

      node.expression!.visit(this);

      if (value != null) {
        parsedBreakpoints.addAll({name: value!});
      } else {
        log.shout("No value found for ${node.property}");
      }
    }
  }

  @override
  visitRemTerm(RemTerm node) {
    Object val = node.value;
    log.fine("[${node.value.runtimeType}] ${node.value}");
    if (val is double) {
      value = val;
    } else if (val is int) {
      value = val;
    } else if (val is num) {
      value = val;
    } else if (val is String) {
      value = num.parse(val);
    } else {
      value = num.parse(val.toString());
    }
    // Converting `rem` to `px`
    value = value! * 16;
  }
}
