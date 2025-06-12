set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

build: build-hex-json build-hex build-css build-css-hex build-css-material build-shadow build-text-shadow

build-hex-json:
    dart run helpers/bin/parse_hex.dart helpers\tailwindcss.com\src\components\color.tsx

build-hex:
    dart run helpers/bin/parse_hex.dart helpers/tailwindcss.com/src/components/color.tsx

build-css:
    dart run helpers/bin/parse_css.dart helpers/tailwindcss/packages/tailwindcss/theme.css

build-css-hex:
    dart run helpers/bin/parse_css_hex.dart helpers/tailwindcss/packages/tailwindcss/theme.css

build-css-material:
    dart run helpers/bin/parse_css_material.dart helpers/tailwindcss/packages/tailwindcss/theme.css

build-shadow:
    dart run helpers/bin/parse_shadow.dart helpers/tailwindcss/packages/tailwindcss/theme.css

build-text-shadow:
    dart run helpers/bin/parse_shadow_text.dart helpers/tailwindcss/packages/tailwindcss/theme.css

build-blur:
    dart run helpers/bin/parse_blur.dart helpers/tailwindcss/packages/tailwindcss/theme.css

build-radius:
    dart run helpers/bin/parse_radius.dart helpers/tailwindcss/packages/tailwindcss/theme.css

build-breakpoint:
    dart run helpers/bin/parse_breakpoint.dart helpers/tailwindcss/packages/tailwindcss/theme.css

build-container-breakpoint:
    dart run helpers/bin/parse_container_breakpoints.dart helpers/tailwindcss/packages/tailwindcss/theme.css