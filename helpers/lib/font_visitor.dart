import 'package:csslib/visitor.dart';
import 'package:helpers/consts.dart';
import 'package:logging/logging.dart';

class FontVisitor extends Visitor {
  static const String prefix = "--font-";
  static const String negPrefix = "weight-";
  final Logger log = Logger("FontVisitor");

  Map<String, List<String>> parsedFonts = {};
  List<String> values = [];
  List<String> genericFonts = [];

  @override
  visitDeclaration(Declaration node) {
    if (node.property.startsWith(prefix)) {
      String name = node.property.substring(prefix.length);
      name = nameMapping[name] ?? name;

      if (!name.startsWith(negPrefix)) {
        log.fine("Parsing $name");

        // log.fine(node.expression!.toDebugString());
        values = [];
        node.expression!.visit(this);

        parsedFonts.addAll({name: values});
      }
    }
  }

  @override
  visitLiteralTerm(LiteralTerm node) {
    log.fine("[${node.value.runtimeType}] ${node.value}");
    var val = node.value;
    // These seem to come up from nowhere, do not show up in `toDebugString`.
    // TODO: Figure out where this comes from
    const List<String> negNames = ["inline", "reference"];
    if (val is Identifier) {
      if (!negNames.contains(val.name)) {
        values.add(val.name);
        genericFonts.add(val.name);
      }
    } else if (val is String) {
      if (val.contains(" ")) {
        // Contains space => quoted (assuming no syntatical errors)
        values.add(val.substring(1, val.length - 1));
      } else {
        values.add(val);
      }
    } else {
      log.warning(
        "Value $val (${val.runtimeType}) is not an Identifier or String!",
      );
    }
  }
}
