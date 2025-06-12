import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:csslib/parser.dart' as p;
import 'package:csslib/visitor.dart' as v;
import 'package:dart_style/dart_style.dart';
import 'package:helpers/blur_visitor.dart';
import 'package:logging/logging.dart';

void main(List<String> args) {
  // Logger.root.level = Level.ALL;
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((e) => print(e.message));

  String path = args[0];

  File cssFile = File(path);
  File outFile = File("lib/src/tailwind_blurs.dart");
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

  BlurVisitor visitor = BlurVisitor();
  tree.visit(visitor);

  // print(tree.toDebugString());
  print(visitor.parsedBlurs);

  LibraryBuilder lib = LibraryBuilder();
  lib.directives.add(Directive.import("dart:ui"));

  Class blurClass = Class((cb) {
    cb.name = "TwBlur";
    cb.abstract = true;
    cb.docs.add("/// All blurs defined in Tailwind CSS");

    for (var el in visitor.parsedBlurs.entries) {
      cb.fields.add(
        Field((f) {
          f.name = el.key;
          f.type = Reference("ImageFilter");
          f.static = true;
          f.modifier = FieldModifier.final$;
          f.assignment = Code(
            "ImageFilter.blur(sigmaX:${el.value},sigmaY:${el.value})",
          );
        }),
      );
    }

    // cb.fields.add(
    //   Field((f) {
    //     f.name = "blursList";
    //     f.static = true;
    //     f.type = Reference("List<ImageFilter>");
    //     f.assignment = Code("[${visitor.parsedBlurs.keys.join(",")}]");
    //   }),
    // );
  });

  lib.body.add(blurClass);

  DartEmitter emitter = DartEmitter();
  DartFormatter formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  String code = formatter.format('${lib.build().accept(emitter)}');

  // print(code);

  outFile.writeAsStringSync(code);
}
