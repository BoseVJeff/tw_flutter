import 'dart:io';

import 'package:dart_style/dart_style.dart';

final RegExp regExp = RegExp(
  r'const hexColors = ([a-zA-Z{:}\s\n0-9"#,]*) as any',
  multiLine: true,
);

const String typePrefix = "const Map<String,Map<int,String>> hexColors=";

void main(List<String> args) {
  String path = args[0];

  File hexColorFile = File(path);
  File destFile = File("helpers/lib/hex_colors.dart");

  print("Reading file...");
  String contents = hexColorFile.readAsStringSync();

  print("Getting colors...");
  RegExpMatch? match = regExp.firstMatch(contents);

  print("Generating code...");
  String map = match!.group(1)!;
  map = map.replaceAllMapped(RegExp(r"([a-z]+):"), (s) => '"${s.group(1)!}":');
  String codeString = "$typePrefix $map;";

  DartFormatter formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  // print(formatter.format(codeString));

  if (!destFile.existsSync()) {
    destFile.createSync(recursive: true);
  }

  print("Writing code to file...");
  destFile.writeAsStringSync(formatter.format(codeString));

  print("Saved generated code to ${destFile.absolute.path}");
}
