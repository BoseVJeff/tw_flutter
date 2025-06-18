const Map<String, String> nameMapping = {
  "4xs": "xs4",
  "3xs": "xs3",
  "2xs": "xs2",
  "2xl": "xl2",
  "3xl": "xl3",
  "4xl": "xl4",
  "5xl": "xl5",
  "6xl": "xl6",
  "7xl": "xl7",
  "8xl": "xl8",
  "9xl": "xl9",
};

const Map<String, Map<String, String>> fontMapping = {
  // `Segoe`/`Times New Roman`/`Cascadia` for `ui-`, `Arial`/`Times New Roman`/`Consolas` otherwise.
  "windows": {
    "system-ui": "Segoe UI",
    "ui-sans-serif": "Segoe UI",
    "ui-serif": "Times New Roman",
    "ui-monospace": "Cascadia Mono",
    "sans-serif": "Arial",
    "serif": "Times New Roman",
    "monospace": "Consolas",
  },
  // `San Fransisco`/`New York` for `ui-`, `Helvetica`/`Times`/`Menlo` otherwise
  "macos": {
    "system-ui": "SF Pro",
    "ui-sans-serif": "SF Pro",
    "ui-serif": "New York",
    "ui-monospace": "SF Mono",
    "sans-serif": "Helvetica",
    "serif": "Times",
    "monospace": "Menlo",
  },
  // `San Fransisco`/`New York` for `ui-`, `Helvetica`/`Times`/`Menlo` otherwise
  "ios": {
    "system-ui": "SF Pro",
    "ui-sans-serif": "SF Pro",
    "ui-serif": "New York",
    "ui-monospace": "SF Mono",
    "sans-serif": "Helvetica",
    "serif": "Times",
    "monospace": "Menlo",
  },
  // `Ubuntu`/`Times New Roman` for `ui-`, `DejaVu` otherwise
  "linux": {
    "system-ui": "Ubuntu",
    "ui-sans-serif": "Ubuntu",
    "ui-serif": "Times New Roman",
    "ui-monospace": "Ubuntu Mono",
    "sans-serif": "DejaVu Sans",
    "serif": "DejaVu Serif",
    "monospace": "DejaVu Mono",
  },
  // `Roboto`/`Noto` for `ui-`, `Noto` otherwise
  "android": {
    "system-ui": "Roboto",
    "ui-sans-serif": "Roboto",
    "ui-serif": "Noto Serif",
    "ui-monospace": "Roboto Mono",
    "sans-serif": "Noto Sans",
    "serif": "Noto Serif",
    // "serif": "Times New Roman",
    "monospace": "Noto Sans Mono",
  },
};

// Subset of all possible generic families
// Taken from https://drafts.csswg.org/css-fonts/#generic-font-families
const List<String> genericFontFamilies = [
  "serif",
  "sans-serif",
  "cursive",
  "fantasy",
  "monospace",
  "system-ui",
  "math",
  "generic(fangsong)",
  "generic(kai)",
  "generic(khmer-mul)",
  "generic(nastaliq)",
  "ui-serif",
  "ui-sans-serif",
  "ui-monospace",
  "ui-rounded",
];
