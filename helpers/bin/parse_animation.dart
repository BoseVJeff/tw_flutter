import 'dart:convert';
import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:csslib/parser.dart' as p;
import 'package:csslib/visitor.dart' as v;
import 'package:dart_style/dart_style.dart';
import 'package:helpers/animation_visitor.dart';
import 'package:helpers/text_visitor.dart';
import 'package:helpers/tracking_visitor.dart';
import 'package:logging/logging.dart';
import 'package:sass_api/sass_api.dart' as sass;

void main(List<String> args) {
  Logger.root.level = Level.INFO;
  // Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((e) => print(e.message));

  String path = args[0];

  File cssFile = File(path);
  File outFile = File("lib/src/tailwind_text.dart");
  if (!outFile.existsSync()) {
    outFile.createSync(recursive: true);
  }

  // print(cssFile.existsSync());

  String contents = cssFile.readAsStringSync().replaceFirst(
    "@theme default",
    "html",
  )
  // .replaceAll(
  //   // Regex from [Claude](https://claude.ai/share/8f758465-bb49-4a51-8bd0-ad6dffefd407) to get rid of all keyframe definitions for now.
  //   // We do this because the the parser, for some unknown reason, stops parsing at the first keyframe element itself.
  //   // The parser itself seems to halt, as evidenced by `tree.toDebugString()` not showing any output beyond the first keyframe.
  //   RegExp(r"@keyframes\s+([^{]+)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}"),
  //   "",
  // )
  //
  ;

  RegExp expr = RegExp(
    r"@keyframes\s+([^{]+)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}",
  );
  Iterable<String> matches = expr.allMatches(contents).map((e) => e[0]!);

  // print(matches.toList().join("\n-----\n"));

  JsonEncoder encoder = JsonEncoder.withIndent("  ");
  Map<String, Map<String, Map<String, String>>> rules = {};

  for (var str in matches) {
    // print(str);

    var s = sass.Stylesheet.parseCss(str);

    AnimationStatementVisitor visitor = AnimationStatementVisitor();
    s.accept(visitor);

    print("-----");
    print("Rule: ${visitor.name}");
    // print(visitor.rules.map((e) => "<$e>").toList());
    // print(visitor.dec.map((e) => e.toString()).join("\n"));
    Map<String, Map<String, String>> m = {};
    for (var i = 0; i < visitor.rules.length; i++) {
      m.addAll({visitor.rules[i]: visitor.dec[i]});
    }
    rules.addAll({visitor.name: m});
    // print(encoder.convert(m));
    print("-----");
  }

  print(encoder.convert(rules));

  // v.StyleSheet tree = p.parse(contents);

  // AnimationVisitor visitor = AnimationVisitor();
  // v.CssPrinter printer = v.CssPrinter();
  // tree.topLevels.first.visit(printer);
  // print(printer.toString());

  // AnimationStatementVisitor visitor = AnimationStatementVisitor();

  // sass.Stylesheet s = sass.Stylesheet.parse(contents, sass.Syntax.css);
  // print(s.children.map((e) => "$e").join("\n-----\n"));
  // print(s.children[0].span.text);
  // s.children[0].accept(visitor);
  // s = sass.Stylesheet.parseCss(s.children[0].span.text);
  // print(s.children.map((e) => e.toString()).join("\n-----\n"));
  // print(s.children.length);
}
