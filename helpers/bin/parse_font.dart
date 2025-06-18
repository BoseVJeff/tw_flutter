import 'dart:collection';
import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:csslib/parser.dart' as p;
import 'package:csslib/visitor.dart' as v;
import 'package:dart_style/dart_style.dart';
import 'package:helpers/consts.dart';
import 'package:helpers/font_visitor.dart';
import 'package:logging/logging.dart';

void main(List<String> args) {
  Logger.root.level = Level.INFO;
  // Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((e) => print("[${e.loggerName}::] ${e.message}"));

  String path = args[0];

  File cssFile = File(path);
  File outFile = File("lib/src/tailwind_fonts.dart");
  if (!outFile.existsSync()) {
    outFile.createSync(recursive: true);
  }

  print(cssFile.existsSync());

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

  FontVisitor visitor = FontVisitor();
  tree.visit(visitor);

  print(visitor.parsedFonts);
  // print("");
  print(
    fontMapping.keys
        .map(
          (os) =>
              "$os: ${visitor.parsedFonts.map((k, v) => MapEntry(k, v.map((e) => fontMapping[os]?[e] ?? e).toList()))}",
        )
        .join("\n"),
  );

  LibraryBuilder lib = LibraryBuilder();

  // Reference textStyleRef = Reference(
  //   "TextStyle",
  //   "package:flutter/painting.dart",
  // );
  Reference stringListRef = Reference("List<String>");

  lib.directives.addAll(
    [
      // textStyleRef,
      stringListRef,
    ].where((e) => e.url != null).map((e) => Directive.import(e.url!)),
  );

  Class fontsRawClass = Class((ClassBuilder cb) {
    cb.name = "TwFontsRaw";
    cb.abstract = true;
    cb.docs.add("/// All font families as defined in Tailwind");

    for (var e in visitor.parsedFonts.entries) {
      cb.fields.add(
        Field((FieldBuilder f) {
          f.name = e.key;
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.assignment = Code("[${e.value.map((e) => "\"$e\"").join(",")}]");
          f.type = stringListRef;
        }),
      );
    }
  });

  final List<Class> osSpecificFonts = [];

  for (var os in fontMapping.keys) {
    Class osFontClass = Class((ClassBuilder cb) {
      cb.name = "TwFonts${os[0].toUpperCase()}${os.substring(1)}";
      cb.abstract = true;
      cb.docs.add("/// Resolved font families for `$os`");

      for (var e in visitor.parsedFonts.entries) {
        // Map generic families to the specific font for the os
        List<String> fonts = e.value
            .map((f) => fontMapping[os]![f] ?? f)
            .toList();

        // Remove duplicates
        fonts = LinkedHashSet<String>.from(fonts).toList();

        cb.fields.add(
          Field((FieldBuilder f) {
            f.name = e.key;
            f.static = true;
            f.modifier = FieldModifier.constant;
            f.type = stringListRef;
            f.assignment = Code("[${fonts.map((e) => "\"$e\"").join(",")}]");
          }),
        );
      }
    });

    osSpecificFonts.add(osFontClass);
  }

  lib.body.add(fontsRawClass);
  lib.body.addAll(osSpecificFonts);

  DartEmitter emitter = DartEmitter();
  DartFormatter formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  String code = formatter.format('${lib.build().accept(emitter)}');

  // print("// ${outFile.path}\n$code");

  outFile.writeAsStringSync(code);
}
