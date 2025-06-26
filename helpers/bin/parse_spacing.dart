import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:csslib/parser.dart' as p;
import 'package:csslib/visitor.dart' as v;
import 'package:dart_style/dart_style.dart';
import 'package:helpers/container_breakpoint_visitor.dart';
import 'package:helpers/spacing_visitor.dart';
import 'package:logging/logging.dart';

void main(List<String> args) {
  Logger.root.level = Level.INFO;
  // Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((e) => print("[${e.loggerName}::] ${e.message}"));

  String path = args[0];

  File cssFile = File(path);
  File outFile = File("lib/src/tailwind_sizes.dart");
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
      )
  //
  ;

  v.StyleSheet tree = p.parse(contents);

  SpacingVisitor visitor = SpacingVisitor();
  tree.visit(visitor);

  ContainerBreakpointVisitor containerBreakpointVisitor =
      ContainerBreakpointVisitor();
  tree.visit(containerBreakpointVisitor);

  print(visitor.parsedSpacing);
  print(containerBreakpointVisitor.parsedBreakpoints);

  LibraryBuilder lib = LibraryBuilder();
  Reference doubleRef = Reference("double");
  Reference mapRef = Reference("Map<String,Size>", "dart:ui");
  Reference sizeRef = Reference("Size", "dart:ui");

  Class sizeClass = Class((ClassBuilder cb) {
    cb.name = "TwSize";
    cb.abstract = true;

    // Base size
    cb.fields.add(
      Field((FieldBuilder f) {
        f.name = "baseSize";
        f.type = doubleRef;
        f.static = true;
        f.modifier = FieldModifier.constant;
        f.assignment = Code(visitor.parsedSpacing.toString());
      }),
    );

    // Container sizes
    for (var e in containerBreakpointVisitor.parsedBreakpoints.entries) {
      // Square boxes
      cb.fields.add(
        Field((FieldBuilder f) {
          f.name = e.key;
          f.type = sizeRef;
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.assignment = Code("Size.square(${e.value})");
        }),
      );
      // Widths
      cb.fields.add(
        Field((FieldBuilder f) {
          f.name =
              "w${e.key.substring(0, 1).toUpperCase()}${e.key.substring(1)}";
          f.type = doubleRef;
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.assignment = Code(e.value.toString());
        }),
      );
      // Heights
      cb.fields.add(
        Field((FieldBuilder f) {
          f.name =
              "h${e.key.substring(0, 1).toUpperCase()}${e.key.substring(1)}";
          f.type = doubleRef;
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.assignment = Code(e.value.toString());
        }),
      );
    }

    cb.fields.add(
      Field((FieldBuilder f) {
        f.name = "px";
        f.type = sizeRef;
        f.static = true;
        f.modifier = FieldModifier.constant;
        f.assignment = Code("Size.square(1)");
      }),
    );

    cb.fields.add(
      Field((FieldBuilder f) {
        f.name = "sizes";
        f.static = true;
        f.modifier = FieldModifier.constant;
        f.assignment = Code(
          '{${containerBreakpointVisitor.parsedBreakpoints.keys.map((e) => '"$e":$e').join(",")}}',
        );
      }),
    );
  });

  lib.body.add(sizeClass);

  lib.directives.addAll(
    [
      doubleRef,
      mapRef,
      sizeRef,
    ].where((e) => e.url != null).toSet().map((e) => Directive.import(e.url!)),
  );

  DartEmitter emitter = DartEmitter();
  DartFormatter formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  String code = formatter.format(lib.build().accept(emitter).toString());

  // print("// ${outFile.path}\n$code");

  outFile.writeAsStringSync(code);
}
