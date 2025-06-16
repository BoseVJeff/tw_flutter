import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:csslib/parser.dart' as p;
import 'package:csslib/visitor.dart' as v;
import 'package:dart_style/dart_style.dart';
import 'package:helpers/text_visitor.dart';
import 'package:helpers/tracking_visitor.dart';
import 'package:logging/logging.dart';

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

  TextVisitor visitor = TextVisitor();
  tree.visit(visitor);

  TrackingVisitor trackingVisitor = TrackingVisitor();
  tree.visit(trackingVisitor);

  LeadingVisitor leadingVisitor = LeadingVisitor();
  tree.visit(leadingVisitor);

  WeightVisitor weightVisitor = WeightVisitor();
  tree.visit(weightVisitor);

  print(visitor.parsedSizes);
  print(visitor.parsedHeights);

  print(trackingVisitor.parsedTracking);

  print(leadingVisitor.parsedLeading);

  print(weightVisitor.parsedWeights);

  LibraryBuilder lib = LibraryBuilder();
  lib.directives.add(Directive.import("dart:ui"));
  lib.directives.add(Directive.import("package:flutter/painting.dart"));

  Class sizeClass = Class((ClassBuilder cb) {
    cb.name = "TwFontSizeRaw";
    cb.docs.add("/// All font sizes as defined in Tailwind");
    cb.abstract = true;

    for (var e in visitor.parsedSizes.entries) {
      cb.fields.add(
        Field((FieldBuilder f) {
          f.name = e.key;
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.assignment = Code(e.value.toString());
        }),
      );
    }
  });

  Class heightClass = Class((ClassBuilder cb) {
    cb.name = "TwLineHeightRaw";
    cb.docs.add("/// All line heights as defined in Tailwind");
    cb.abstract = true;

    for (var e in visitor.parsedHeights.entries) {
      cb.fields.add(
        Field((FieldBuilder f) {
          f.name = e.key;
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.assignment = Code(e.value.toString());
        }),
      );
    }
  });

  Extension sizeExtension = Extension((ExtensionBuilder eb) {
    eb.name = "TwFontSize";
    eb.on = Reference("TextStyle");
    for (var e in visitor.parsedSizes.keys) {
      eb.methods.add(
        Method((MethodBuilder m) {
          m.name = e;
          // m.name = "TwFontSize${e[0].toUpperCase()}${e.substring(1)}";
          m.returns = Reference("TextStyle");
          m.body = Code(
            "return copyWith(fontSize: TwFontSizeRaw.$e ,height: TwLineHeightRaw.$e );",
          );
        }),
      );
    }
  });

  Class spacingClass = Class((ClassBuilder cb) {
    cb.name = "TwCharSpacingRaw";
    cb.docs.add("/// All character spacings as defined in Tailwind");
    cb.abstract = true;

    for (var e in trackingVisitor.parsedTracking.entries) {
      cb.fields.add(
        Field((FieldBuilder f) {
          f.name = e.key;
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.assignment = Code(e.value.toString());
        }),
      );
    }
  });

  Extension spacingExtension = Extension((ExtensionBuilder eb) {
    eb.name = "TwCharSpacing";
    eb.on = Reference("TextStyle");

    for (var e in trackingVisitor.parsedTracking.keys) {
      eb.methods.add(
        Method((MethodBuilder m) {
          m.name = "char${e[0].toUpperCase()}${e.substring(1)}";
          m.returns = Reference("TextStyle");
          m.body = Code(
            "return copyWith(letterSpacing: TwCharSpacingRaw.$e * (fontSize??16));",
          );
        }),
      );
    }
  });

  Class moreHeightClass = Class((ClassBuilder cb) {
    cb.abstract = true;
    cb.name = "TwLeadingRaw";
    cb.docs.add("/// All leading/line heights defined in Tailwind");

    for (var e in leadingVisitor.parsedLeading.entries) {
      cb.fields.add(
        Field((FieldBuilder f) {
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.name = e.key;
          f.assignment = Code(e.value.toString());
        }),
      );
    }
  });

  Extension leadingExtension = Extension((ExtensionBuilder eb) {
    eb.name = "TwLeading";
    eb.on = Reference("TextStyle");
    for (var e in leadingVisitor.parsedLeading.keys) {
      eb.methods.add(
        Method((MethodBuilder m) {
          m.name = "leading${e[0].toUpperCase()}${e.substring(1)}";
          m.returns = Reference("TextStyle");
          m.body = Code(
            "return copyWith(height: ${leadingVisitor.parsedLeading[e]});",
          );
        }),
      );
    }
  });

  Class weightClass = Class((ClassBuilder cb) {
    cb.name = "TwFontWeightRaw";
    cb.abstract = true;
    cb.docs.add("/// All font weights as defined in Tailwind");

    for (var e in weightVisitor.parsedWeights.entries) {
      cb.fields.add(
        Field((FieldBuilder f) {
          f.static = true;
          f.modifier = FieldModifier.constant;
          f.type = Reference("FontWeight");
          f.name = e.key;
          f.assignment = Code("FontWeight.w${e.value.toInt().toString()}");
        }),
      );
    }
  });

  Extension weightExtension = Extension((ExtensionBuilder eb) {
    eb.name = "TwFontWeight";
    eb.on = Reference("TextStyle");
    for (var e in weightVisitor.parsedWeights.keys) {
      eb.methods.add(
        Method((MethodBuilder m) {
          m.name = "weight${e[0].toUpperCase()}${e.substring(1)}";
          m.returns = Reference("TextStyle");
          m.body = Code("return copyWith(fontWeight: TwFontWeightRaw.$e);");
        }),
      );
    }
  });

  lib.body.addAll([
    sizeClass,
    heightClass,
    spacingClass,
    moreHeightClass,
    weightClass,
    sizeExtension,
    spacingExtension,
    leadingExtension,
    weightExtension,
  ]);

  DartEmitter emitter = DartEmitter();
  DartFormatter formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  String code = formatter.format('${lib.build().accept(emitter)}');

  // print("// ${outFile.path}\n$code");

  outFile.writeAsStringSync(code);
}
