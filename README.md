<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

Tailwind utilities for Flutter apps.

## Features

This package will let you easily use colors, etc. as defined in Tailwind CSS.

## Getting started

Install this package

```sh
> flutter pub add tw_flutter
```

Then import it into your project.

```dart
import "package:tw_flutter/tw_flutter.dart";
```

Alternatively, you can instead choose to import specifc aspects of this lbrary.
For example, to import just the animation classes, import the library as follows:

```dart
import 'package:tw_flutter/animation.dart';
```

## Usage

The best way to use this package is to import the base library and use the provided constants as required.

For example, to modify some text, try something like so:

```dart
Text("Hello from tw_flutter!",style: style: TwFont.sans.copyWith(color: TwColors.gray),);
```

To animate a widget, use the following pattern instead:

```dart
TwAnimatedPing(
    child: Opacity(
        opacity: 0.75,
        child: Icon(
        Icons.circle,
        color: TwColors.sky[400],
        size: TwSize.baseSize * 5,
        ),
    ),
)
```

## Additional information

Tailwind defines their color palettes in the `oklch` color-space. 
Because Flutter does not support this color-space, all color palettes defined in `TwMaterialColors` are converted to the `sRGB` color space instead. 
To use colors converted to the `Display P3` space (the widest space Flutter supports), use `TwSwatchColors` instead.

This package exposes a portion of the utilities as defined in Tailwind v4 using a combination of source-gen and custom implementation.

Utilities that the author deems are both trivial to implement in Flutter (i.e. having a widget that implements the behaviour in a straight-forward fashion) and have no default values defined in Tailwind are excluded from this library.

For a more substantial showcase of this package's capablities, check out the `examples/` folder in the source repo. 
The example app is relatively straight-forward, with seperate pages (under `examples/pages/`) to showcase each class of utilities.

This library is licensed under the MIT license. I would appreciate attribution and a ping if you found this library useful.
