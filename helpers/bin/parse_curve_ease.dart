import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:csslib/parser.dart' as p;
import 'package:csslib/visitor.dart' as v;
import 'package:dart_style/dart_style.dart';
import 'package:helpers/curve_ease_visitor.dart';
import 'package:logging/logging.dart';

void main(List<String> args) {
  Logger.root.level = Level.INFO;
  // Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((e) => print(e.message));

  String path = args[0];

  File cssFile = File(path);
  File outFile = File("lib/src/tailwind_curves.dart");
  if (!outFile.existsSync()) {
    outFile.createSync(recursive: true);
  }

  // print(cssFile.existsSync());

  String contents = cssFile
      .readAsStringSync()
      .replaceFirst("@theme default", "html")
      .replaceAll(
        // Regex from [Claude](https://claude.ai/share/8f758465-bb49-4a51-8bd0-ad6dffefd407) to get rid of all keyframe definitions for now.
        // We do this because the the parser, for some unknown reason, stops parsing at the first keyframe element itself.
        // The parser itself seems to halt, as evidenced by `tree.toDebugString()` not showing any output beyond the first keyframe.
        RegExp(r"@keyframes\s+([^{]+)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}"),
        "",
      );

  v.StyleSheet tree = p.parse(contents);

  CurveEaseVisitor visitor = CurveEaseVisitor();
  tree.visit(visitor);

  // print(tree.toDebugString());
  print(visitor.parsedCurves);

  LibraryBuilder lib = LibraryBuilder();
  lib.directives.add(Directive.import("package:flutter/animation.dart"));

  Class radiusClass = Class((cb) {
    cb.name = "TwCurves";
    cb.abstract = true;
    cb.docs.add("/// Curves as defined in Tailwind CSS");

    for (var el in visitor.parsedCurves.entries) {
      cb.fields.add(
        Field((f) {
          f.name =
              "ease${el.key.split("-").map((e) => "${e.substring(0, 1).toUpperCase()}${e.substring(1)}").join("")}";
          f.type = Reference("Cubic");
          f.static = true;
          f.modifier = FieldModifier.final$;
          f.assignment = Code(
            "Cubic(${el.value.params.map((e) => e.toString()).join(",")})",
          );
        }),
      );
    }
  });

  lib.body.add(radiusClass);

  DartEmitter emitter = DartEmitter();
  DartFormatter formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  String code = formatter.format('${lib.build().accept(emitter)}');

  // print(code);

  outFile.writeAsStringSync(code);
}
