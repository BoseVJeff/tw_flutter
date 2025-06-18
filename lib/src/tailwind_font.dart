import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';

import 'tailwind_fonts.dart';

abstract class TwFont {
  TextStyle monoFor(TargetPlatform platform) {
    List<String> fonts = TwFonts.monoFor(platform);
    return TextStyle(
      fontFamily: fonts.first,
      fontFamilyFallback: fonts.sublist(1),
    );
  }

  TextStyle serifFor(TargetPlatform platform) {
    List<String> fonts = TwFonts.serifFor(platform);
    return TextStyle(
      fontFamily: fonts.first,
      fontFamilyFallback: fonts.sublist(1),
    );
  }

  TextStyle sansFor(TargetPlatform platform) {
    List<String> fonts = TwFonts.sansFor(platform);
    return TextStyle(
      fontFamily: fonts.first,
      fontFamilyFallback: fonts.sublist(1),
    );
  }

  TextStyle get mono => monoFor(defaultTargetPlatform);

  TextStyle get serif => serifFor(defaultTargetPlatform);

  TextStyle get sans => sansFor(defaultTargetPlatform);
}

extension TwFontEx on TextStyle {
  TextStyle withMono() {
    return copyWith(
      fontFamily: TwFonts.mono.first,
      fontFamilyFallback: TwFonts.mono.sublist(1),
    );
  }

  TextStyle withSerif() {
    return copyWith(
      fontFamily: TwFonts.serif.first,
      fontFamilyFallback: TwFonts.serif.sublist(1),
    );
  }

  TextStyle withSans() {
    return copyWith(
      fontFamily: TwFonts.sans.first,
      fontFamilyFallback: TwFonts.sans.sublist(1),
    );
  }
}

abstract class TwFonts {
  static List<String> monoFor(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return TwFontsWindows.mono;
      case TargetPlatform.fuchsia:
        throw UnimplementedError("No fonts for Fuchsia!");
      case TargetPlatform.iOS:
        return TwFontsIos.mono;
      case TargetPlatform.linux:
        return TwFontsLinux.mono;
      case TargetPlatform.macOS:
        return TwFontsMacos.mono;
      case TargetPlatform.windows:
        return TwFontsWindows.mono;
    }
  }

  static List<String> serifFor(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return TwFontsWindows.serif;
      case TargetPlatform.fuchsia:
        throw UnimplementedError("No fonts for Fuchsia!");
      case TargetPlatform.iOS:
        return TwFontsIos.serif;
      case TargetPlatform.linux:
        return TwFontsLinux.serif;
      case TargetPlatform.macOS:
        return TwFontsMacos.serif;
      case TargetPlatform.windows:
        return TwFontsWindows.serif;
    }
  }

  static List<String> sansFor(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return TwFontsWindows.sans;
      case TargetPlatform.fuchsia:
        throw UnimplementedError("No fonts for Fuchsia!");
      case TargetPlatform.iOS:
        return TwFontsIos.sans;
      case TargetPlatform.linux:
        return TwFontsLinux.sans;
      case TargetPlatform.macOS:
        return TwFontsMacos.sans;
      case TargetPlatform.windows:
        return TwFontsWindows.sans;
    }
  }

  static List<String> get mono => monoFor(defaultTargetPlatform);

  static List<String> get serif => serifFor(defaultTargetPlatform);

  static List<String> get sans => sansFor(defaultTargetPlatform);
}
