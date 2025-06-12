import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:csslib/visitor.dart' as v;
import 'package:csslib/parser.dart' as p;
import 'package:dart_style/dart_style.dart';
import 'package:helpers/shadow_visitor.dart';
import 'package:sass_api/sass_api.dart' show SassColor, ColorSpace;

void main(List<String> args) {
  String path = args[0];

  File cssFile = File(path);
  File outFile = File("lib/src/tailwind_shadows.dart");
  if (!outFile.existsSync()) {
    outFile.createSync(recursive: true);
  }

  // print(cssFile.existsSync());

  String contents = cssFile.readAsStringSync().replaceFirst(
    "@theme default",
    "html",
  );

  v.StyleSheet tree = p.parse(contents);

  ShadowVisitor visitor = ShadowVisitor();

  tree.visit(visitor);

  // print(tree.toDebugString());
  print(
    visitor.parsedShadows.entries.map((e) => "${e.key}: ${e.value.length}"),
  );

  LibraryBuilder lib = LibraryBuilder();
  lib.directives.add(Directive.import("dart:ui"));
  lib.directives.add(Directive.import("package:flutter/painting.dart"));

  Class shadowClass = Class((cb) {
    cb.name = "TwShadow";
    cb.abstract = true;
    cb.docs.add("/// All shadows as defined in Tailwind");
    for (var shadow in visitor.parsedShadows.entries) {
      cb.fields.add(
        Field((f) {
          f.name = shadow.key;
          f.modifier = FieldModifier.constant;
          f.static = true;
          f.type = Reference("List<BoxShadow>");

          f.assignment = Code(
            '[${shadow.value.map((RawBoxShadow e) {
              SassColor color = e.color!;
              String colorSpace;
              if (color.space == ColorSpace.rgb) {
                colorSpace = "sRGB";
              } else {
                color = color.toSpace(ColorSpace.displayP3);
                colorSpace = "displayP3";
              }

              return """
              BoxShadow(
              offset: Offset(${e.x},${e.y}),
              blurRadius: ${e.blur},
              spreadRadius: ${e.spread},
              color: Color.from(alpha:${color.alpha}, red:${color.channel("red")}, green:${color.channel("green")}, blue:${color.channel("blue")}, colorSpace: ColorSpace.$colorSpace),
              )
            """;
            }).join(",")}]',
          );
        }),
      );
    }
  });

  lib.body.add(shadowClass);

  Library library = lib.build();

  DartEmitter emitter = DartEmitter();
  DartFormatter formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  String code = formatter.format('${library.accept(emitter)}');

  // print(code);

  outFile.writeAsStringSync(code);
}
