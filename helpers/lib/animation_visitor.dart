import 'package:csslib/visitor.dart' as v;
import 'package:sass_api/sass_api.dart';

class AnimationVisitor extends v.Visitor {
  @override
  visitDeclaration(v.Declaration node) {
    node.expression!.visit(this);
    print(node.property);
  }

  @override
  visitKeyFrameDirective(v.KeyFrameDirective node) {
    super.visitKeyFrameDirective(node);
    print(node.keyFrameName);
  }

  @override
  visitKeyFrameBlock(v.KeyFrameBlock node) {
    super.visitKeyFrameBlock(node);
    print(node.toDebugString());
  }
}

class AnimationStatementVisitor implements StatementVisitor {
  String name = "";
  List<String> rules = [];
  List<Map<String, String>> dec = [];
  Map<String, String> tempDec = {};

  @override
  visitAtRootRule(AtRootRule node) {
    // TODO: implement visitAtRootRule
    throw UnimplementedError();
  }

  @override
  visitAtRule(AtRule node) {
    print("[@Name] ${node.name.asPlain}");
    print("[Value] ${node.value}");
    name = node.value!.asPlain!;
    for (var child in node.children ?? []) {
      child.accept(this);
    }
  }

  @override
  visitContentBlock(ContentBlock node) {
    // TODO: implement visitContentBlock
    throw UnimplementedError();
  }

  @override
  visitContentRule(ContentRule node) {
    // TODO: implement visitContentRule
    throw UnimplementedError();
  }

  @override
  visitDebugRule(DebugRule node) {
    // TODO: implement visitDebugRule
    throw UnimplementedError();
  }

  @override
  visitDeclaration(Declaration node) {
    print("[Declaration] ${node.name.asPlain} -> ${node.value!.span.text}");
    tempDec.addAll({node.name.asPlain!: node.value!.span.text});
    // for (var child in node.children ?? []) {
    //   child.accept(this);
    // }
    // EVisitor visitor = EVisitor();
    // node.value!.accept(visitor);
  }

  @override
  visitEachRule(EachRule node) {
    // TODO: implement visitEachRule
    throw UnimplementedError();
  }

  @override
  visitErrorRule(ErrorRule node) {
    // TODO: implement visitErrorRule
    throw UnimplementedError();
  }

  @override
  visitExtendRule(ExtendRule node) {
    // TODO: implement visitExtendRule
    throw UnimplementedError();
  }

  @override
  visitForRule(ForRule node) {
    // TODO: implement visitForRule
    throw UnimplementedError();
  }

  @override
  visitForwardRule(ForwardRule node) {
    // TODO: implement visitForwardRule
    throw UnimplementedError();
  }

  @override
  visitFunctionRule(FunctionRule node) {
    // TODO: implement visitFunctionRule
    throw UnimplementedError();
  }

  @override
  visitIfRule(IfRule node) {
    // TODO: implement visitIfRule
    throw UnimplementedError();
  }

  @override
  visitImportRule(ImportRule node) {
    // TODO: implement visitImportRule
    throw UnimplementedError();
  }

  @override
  visitIncludeRule(IncludeRule node) {
    // TODO: implement visitIncludeRule
    throw UnimplementedError();
  }

  @override
  visitLoudComment(LoudComment node) {
    // TODO: implement visitLoudComment
    throw UnimplementedError();
  }

  @override
  visitMediaRule(MediaRule node) {
    // TODO: implement visitMediaRule
    throw UnimplementedError();
  }

  @override
  visitMixinRule(MixinRule node) {
    // TODO: implement visitMixinRule
    throw UnimplementedError();
  }

  @override
  visitReturnRule(ReturnRule node) {
    // TODO: implement visitReturnRule
    throw UnimplementedError();
  }

  @override
  visitSilentComment(SilentComment node) {
    // TODO: implement visitSilentComment
    throw UnimplementedError();
  }

  @override
  visitStyleRule(StyleRule node) {
    String rule = node.selector.asPlain!
        .replaceAll(" ", "")
        .replaceAll("\n", "")
        .replaceAll("\r", "");
    print("[StyleRule] $rule");
    rules.add(rule);
    tempDec = {};
    for (var child in node.children) {
      child.accept(this);
    }
    dec.add(tempDec);
  }

  @override
  visitStylesheet(Stylesheet node) {
    print("[StyleSheet] ${node.children.length}");
    for (var c in node.children) {
      c.accept(this);
    }
  }

  @override
  visitSupportsRule(SupportsRule node) {
    // TODO: implement visitSupportsRule
    throw UnimplementedError();
  }

  @override
  visitUseRule(UseRule node) {
    // TODO: implement visitUseRule
    throw UnimplementedError();
  }

  @override
  visitVariableDeclaration(VariableDeclaration node) {
    // TODO: implement visitVariableDeclaration
    throw UnimplementedError();
  }

  @override
  visitWarnRule(WarnRule node) {
    // TODO: implement visitWarnRule
    throw UnimplementedError();
  }

  @override
  visitWhileRule(WhileRule node) {
    // TODO: implement visitWhileRule
    throw UnimplementedError();
  }
}

class EVisitor implements ExpressionVisitor {
  String name = "";
  List<String> values = [];

  @override
  visitBinaryOperationExpression(BinaryOperationExpression node) {
    // TODO: implement visitBinaryOperationExpression
    throw UnimplementedError();
  }

  @override
  visitBooleanExpression(BooleanExpression node) {
    // TODO: implement visitBooleanExpression
    throw UnimplementedError();
  }

  @override
  visitColorExpression(ColorExpression node) {
    // TODO: implement visitColorExpression
    throw UnimplementedError();
  }

  @override
  visitFunctionExpression(FunctionExpression node) {
    print(
      "[ExFunc] ${node.originalName} -> ${node.arguments.positional} | ${node.arguments.named}",
    );
  }

  @override
  visitIfExpression(IfExpression node) {
    // TODO: implement visitIfExpression
    throw UnimplementedError();
  }

  @override
  visitInterpolatedFunctionExpression(InterpolatedFunctionExpression node) {
    // TODO: implement visitInterpolatedFunctionExpression
    throw UnimplementedError();
  }

  @override
  visitListExpression(ListExpression node) {
    // TODO: implement visitListExpression
    throw UnimplementedError();
  }

  @override
  visitMapExpression(MapExpression node) {
    // TODO: implement visitMapExpression
    throw UnimplementedError();
  }

  @override
  visitNullExpression(NullExpression node) {
    // TODO: implement visitNullExpression
    throw UnimplementedError();
  }

  @override
  visitNumberExpression(NumberExpression node) {
    print("[ExNumber] ${node.value} ${node.unit}");
  }

  @override
  visitParenthesizedExpression(ParenthesizedExpression node) {
    // TODO: implement visitParenthesizedExpression
    throw UnimplementedError();
  }

  @override
  visitSelectorExpression(SelectorExpression node) {
    // TODO: implement visitSelectorExpression
    throw UnimplementedError();
  }

  @override
  visitStringExpression(StringExpression node) {
    print("[ExString] ${node.text.asPlain}");
  }

  @override
  visitSupportsExpression(SupportsExpression node) {
    // TODO: implement visitSupportsExpression
    throw UnimplementedError();
  }

  @override
  visitUnaryOperationExpression(UnaryOperationExpression node) {
    // TODO: implement visitUnaryOperationExpression
    throw UnimplementedError();
  }

  @override
  visitValueExpression(ValueExpression node) {
    // TODO: implement visitValueExpression
    throw UnimplementedError();
  }

  @override
  visitVariableExpression(VariableExpression node) {
    // TODO: implement visitVariableExpression
    throw UnimplementedError();
  }
}
