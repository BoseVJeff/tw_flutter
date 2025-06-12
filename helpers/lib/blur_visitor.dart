import 'package:csslib/parser.dart';
import 'package:csslib/visitor.dart';
import 'package:logging/logging.dart';

class BlurVisitor extends Visitor {
  static const String prefix = "--blur-";
  static const Map<String, String> nameMapping = {
    "2xs": "xs2",
    "2xl": "xl2",
    "3xl": "xl3",
  };
  Map<String, num> parsedBlurs = {};
  num? value;
  Logger log = Logger("BlurVisitor");

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      String name = node.property.substring(prefix.length);
      name = nameMapping[name] ?? name;

      node.expression!.visit(this);

      if (value != null) {
        parsedBlurs.addAll({name: value!});
      } else {
        log.shout("No value found for ${node.property}");
      }
    }
  }

  @override
  visitLengthTerm(LengthTerm node) {
    Object val = node.value;
    log.fine("[${node.value.runtimeType}] ${node.value}");
    if (node.unit != TokenKind.UNIT_LENGTH_PX) {
      log.warning("${node.text} is not in px! Parsing may have an error!");
    }
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
  }
}
