/// All font families as defined in Tailwind
abstract class TwFontsRaw {
  static const List<String> sans = [
    "ui-sans-serif",
    "system-ui",
    "sans-serif",
    "Apple Color Emoji",
    "Segoe UI Emoji",
    "Segoe UI Symbol",
    "Noto Color Emoji",
  ];

  static const List<String> serif = [
    "ui-serif",
    "Georgia",
    "Cambria",
    "Times New Roman",
    "Times",
    "serif",
  ];

  static const List<String> mono = [
    "ui-monospace",
    "SFMono-Regular",
    "Menlo",
    "Monaco",
    "Consolas",
    "Liberation Mono",
    "Courier New",
    "monospace",
  ];
}

/// Resolved font families for `windows`
abstract class TwFontsWindows {
  static const List<String> sans = [
    "Segoe UI",
    "Arial",
    "Apple Color Emoji",
    "Segoe UI Emoji",
    "Segoe UI Symbol",
    "Noto Color Emoji",
  ];

  static const List<String> serif = [
    "Times New Roman",
    "Georgia",
    "Cambria",
    "Times",
  ];

  static const List<String> mono = [
    "Cascadia Mono",
    "SFMono-Regular",
    "Menlo",
    "Monaco",
    "Consolas",
    "Liberation Mono",
    "Courier New",
  ];
}

/// Resolved font families for `macos`
abstract class TwFontsMacos {
  static const List<String> sans = [
    "SF Pro",
    "Helvetica",
    "Apple Color Emoji",
    "Segoe UI Emoji",
    "Segoe UI Symbol",
    "Noto Color Emoji",
  ];

  static const List<String> serif = [
    "New York",
    "Georgia",
    "Cambria",
    "Times New Roman",
    "Times",
  ];

  static const List<String> mono = [
    "SF Mono",
    "SFMono-Regular",
    "Menlo",
    "Monaco",
    "Consolas",
    "Liberation Mono",
    "Courier New",
  ];
}

/// Resolved font families for `ios`
abstract class TwFontsIos {
  static const List<String> sans = [
    "SF Pro",
    "Helvetica",
    "Apple Color Emoji",
    "Segoe UI Emoji",
    "Segoe UI Symbol",
    "Noto Color Emoji",
  ];

  static const List<String> serif = [
    "New York",
    "Georgia",
    "Cambria",
    "Times New Roman",
    "Times",
  ];

  static const List<String> mono = [
    "SF Mono",
    "SFMono-Regular",
    "Menlo",
    "Monaco",
    "Consolas",
    "Liberation Mono",
    "Courier New",
  ];
}

/// Resolved font families for `linux`
abstract class TwFontsLinux {
  static const List<String> sans = [
    "Ubuntu",
    "DejaVu Sans",
    "Apple Color Emoji",
    "Segoe UI Emoji",
    "Segoe UI Symbol",
    "Noto Color Emoji",
  ];

  static const List<String> serif = [
    "Times New Roman",
    "Georgia",
    "Cambria",
    "Times",
    "DejaVu Serif",
  ];

  static const List<String> mono = [
    "Ubuntu Mono",
    "SFMono-Regular",
    "Menlo",
    "Monaco",
    "Consolas",
    "Liberation Mono",
    "Courier New",
    "DejaVu Mono",
  ];
}

/// Resolved font families for `android`
abstract class TwFontsAndroid {
  static const List<String> sans = [
    "Roboto",
    "Noto Sans",
    "Apple Color Emoji",
    "Segoe UI Emoji",
    "Segoe UI Symbol",
    "Noto Color Emoji",
  ];

  static const List<String> serif = [
    "Noto Serif",
    "Georgia",
    "Cambria",
    "Times New Roman",
    "Times",
  ];

  static const List<String> mono = [
    "Roboto Mono",
    "SFMono-Regular",
    "Menlo",
    "Monaco",
    "Consolas",
    "Liberation Mono",
    "Courier New",
    "Noto Sans Mono",
  ];
}
