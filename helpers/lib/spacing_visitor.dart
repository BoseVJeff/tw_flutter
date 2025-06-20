import 'package:csslib/visitor.dart';

class SpacingVisitor extends Visitor {
  static const String prop = "--spacing";

  double parsedSpacing = -1;

  @override
  visitDeclarationGroup(DeclarationGroup node) {
    for (var e in node.declarations.whereType<Declaration>().where(
      (e) => e.property == prop,
    )) {
      e.visit(this);
    }
  }

  @override
  visitRemTerm(RemTerm node) {
    parsedSpacing = (node.value as double) * 16;
  }
}
