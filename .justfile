set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

build: build-hex-json build-hex build-css build-css-hex build-css-material build-shadow build-text-shadow build-blur build-radius build-breakpoint build-container-breakpoint build-transition build-curves build-text build-font build-sizes

build-hex-json:
    dart run helpers/bin/parse_hex.dart tailwindcss.com\src\components\color.tsx

build-hex:
    dart run helpers/bin/parse_hex.dart tailwindcss.com/src/components/color.tsx

build-css:
    dart run helpers/bin/parse_css.dart tailwindcss/packages/tailwindcss/theme.css

build-css-hex:
    dart run helpers/bin/parse_css_hex.dart tailwindcss/packages/tailwindcss/theme.css

build-css-material:
    dart run helpers/bin/parse_css_material.dart tailwindcss/packages/tailwindcss/theme.css

build-shadow:
    dart run helpers/bin/parse_shadow.dart tailwindcss/packages/tailwindcss/theme.css

build-text-shadow:
    dart run helpers/bin/parse_shadow_text.dart tailwindcss/packages/tailwindcss/theme.css

build-blur:
    dart run helpers/bin/parse_blur.dart tailwindcss/packages/tailwindcss/theme.css

build-radius:
    dart run helpers/bin/parse_radius.dart tailwindcss/packages/tailwindcss/theme.css

build-breakpoint:
    dart run helpers/bin/parse_breakpoint.dart tailwindcss/packages/tailwindcss/theme.css

build-container-breakpoint:
    dart run helpers/bin/parse_container_breakpoints.dart tailwindcss/packages/tailwindcss/theme.css

build-transition:
    dart run helpers/bin/parse_default_transition.dart tailwindcss/packages/tailwindcss/theme.css

build-curves:
    dart run helpers/bin/parse_curve_ease.dart tailwindcss/packages/tailwindcss/theme.css

build-text:
    dart run helpers/bin/parse_text.dart tailwindcss/packages/tailwindcss/theme.css

build-font:
    dart run helpers/bin/parse_font.dart tailwindcss/packages/tailwindcss/theme.css

build-animation:
    dart run helpers/bin/parse_animation.dart tailwindcss/packages/tailwindcss/theme.css

build-sizes:
    dart run helpers/bin/parse_spacing.dart tailwindcss/packages/tailwindcss/theme.css