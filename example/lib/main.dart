import 'dart:ui';

import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor seedColor = Colors.purple;
  DynamicSchemeVariant schemeVariant = DynamicSchemeVariant.fidelity;
  ThemeMode mode = ThemeMode.system;
  List<BoxShadow> shadow = TwShadow.md;
  List<BoxShadow> textShadow = TwTextShadow.md;
  ImageFilter blur = TwBlur.sm;
  Radius radius = TwRadius.lg;
  double breakpoint = TwBreakpoints.md;
  double containerBreakpoint = TwContainerBreakpoint.md;

  void switchSeedColor(MaterialColor newColor) => setState(() {
    seedColor = newColor;
  });

  void swictchSchemeVariant(DynamicSchemeVariant variant) => setState(() {
    schemeVariant = variant;
  });

  void switchThemeMode(ThemeMode newMode) => setState(() {
    mode = newMode;
  });

  void switchShadow(List<BoxShadow> newShadow) => setState(() {
    shadow = newShadow;
  });

  void switchTextShadow(List<BoxShadow> newShadow) => setState(() {
    textShadow = newShadow;
  });

  void switchBlur(ImageFilter filter) => setState(() {
    blur = filter;
  });

  void switchRadius(Radius newRadius) => setState(() {
    radius = newRadius;
  });

  void switchBreakpoint(double newBreakpoint) => setState(() {
    breakpoint = newBreakpoint;
  });

  void switchContainerBreakpoint(double newBreakpoint) => setState(() {
    containerBreakpoint = newBreakpoint;
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: mode,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          dynamicSchemeVariant: schemeVariant,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          dynamicSchemeVariant: schemeVariant,
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Tailwind")),
        body: StaticDynamicListView(
          padding: EdgeInsets.only(bottom: 72),
          children: [
            // Text("Dynamic Scheme Variant"),
            // SegmentedButton(
            //   segments: DynamicSchemeVariant.values
            //       .map(
            //         (e) => ButtonSegment<DynamicSchemeVariant>(
            //           value: e,
            //           label: Text(e.name),
            //         ),
            //       )
            //       .toList(),
            //   selected: {schemeVariant},
            //   onSelectionChanged: (Set<DynamicSchemeVariant> p0) {
            //     Set<DynamicSchemeVariant> newVariants = p0.difference({
            //       schemeVariant,
            //     });
            //     swictchSchemeVariant(newVariants.first);
            //   },
            // ),
            Text("App Theme Mode"),
            Wrap(
              spacing: 8,
              children: ThemeMode.values
                  .map(
                    (e) => (e == mode)
                        ? FilledButton(
                            onPressed: () {
                              switchThemeMode(e);
                            },
                            child: Text(e.name),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              switchThemeMode(e);
                            },
                            child: Text(e.name),
                          ),
                  )
                  .toList(),
            ),
            Text("Material Colors"),
            Wrap(
              children: Colors.primaries
                  .map(
                    (e) => IconButton(
                      onPressed: () {
                        switchSeedColor(e);
                      },
                      icon: Icon(
                        (seedColor == e) ? Icons.check_circle : Icons.circle,
                        color: e,
                      ),
                    ),
                  )
                  .toList(),
            ),
            Text("Tailwind Colors"),
            Wrap(
              children: TwMaterialColors.colorList.entries
                  .map(
                    (e) => IconButton(
                      onPressed: () {
                        switchSeedColor(e.value);
                      },
                      icon: Icon(
                        (seedColor == e.value)
                            ? Icons.check_circle
                            : Icons.circle,
                        color: e.value,
                      ),
                      tooltip: e.key,
                    ),
                  )
                  .toList(),
            ),
            Text("Material Elevation Shadow"),
            SegmentedButton<List<BoxShadow>>(
              segments: kElevationToShadow.entries
                  .map<ButtonSegment<List<BoxShadow>>>(
                    (e) => ButtonSegment(
                      value: e.value,
                      label: Text(e.key.toRadixString(10)),
                    ),
                  )
                  .toList(),
              selected: {shadow},
              onSelectionChanged: (p0) {
                Set<List<BoxShadow>> diff = p0.difference({shadow});
                switchShadow(diff.first);
              },
            ),
            Text("Box Shadow"),
            SegmentedButton<List<BoxShadow>>(
              segments: [
                ButtonSegment(
                  value: TwShadow.xs2,
                  label: Text("2xs"),
                  enabled: shadow != TwShadow.xs2,
                ),
                ButtonSegment(
                  value: TwShadow.xs,
                  label: Text("xs"),
                  enabled: shadow != TwShadow.xs,
                ),
                ButtonSegment(
                  value: TwShadow.sm,
                  label: Text("sm"),
                  enabled: shadow != TwShadow.sm,
                ),
                ButtonSegment(
                  value: TwShadow.md,
                  label: Text("md"),
                  enabled: shadow != TwShadow.md,
                ),
                ButtonSegment(
                  value: TwShadow.xl,
                  label: Text("xl"),
                  enabled: shadow != TwShadow.xl,
                ),
                ButtonSegment(
                  value: TwShadow.xl2,
                  label: Text("xl2"),
                  enabled: shadow != TwShadow.xl2,
                ),
              ],
              selected: {shadow},
              onSelectionChanged: (p0) {
                Set<List<BoxShadow>> diff = p0.difference({shadow});
                switchShadow(diff.first);
              },
            ),
            Container(
              margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 56),
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: shadow,
              ),
              child: Center(
                child: Text(
                  "The quick brown fox jumped over the lazy dog.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    shadows: textShadow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text("Text Shadow"),
            SegmentedButton<List<BoxShadow>>(
              segments: [
                ButtonSegment(
                  value: TwTextShadow.xs2,
                  label: Text("2xs"),
                  enabled: textShadow != TwTextShadow.xs2,
                ),
                ButtonSegment(
                  value: TwTextShadow.xs,
                  label: Text("xs"),
                  enabled: textShadow != TwTextShadow.xs,
                ),
                ButtonSegment(
                  value: TwTextShadow.sm,
                  label: Text("sm"),
                  enabled: textShadow != TwTextShadow.sm,
                ),
                ButtonSegment(
                  value: TwTextShadow.md,
                  label: Text("md"),
                  enabled: textShadow != TwTextShadow.md,
                ),
                ButtonSegment(
                  value: TwTextShadow.lg,
                  label: Text("lg"),
                  enabled: textShadow != TwTextShadow.lg,
                ),
              ],
              selected: {textShadow},
              onSelectionChanged: (p0) {
                Set<List<BoxShadow>> diff = p0.difference({textShadow});
                switchTextShadow(diff.first);
              },
            ),
            Text("Gradients"),
            SizedBox.square(
              dimension: 96,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.red,
                  gradient: TailwindGradient.linear(Alignment.centerRight, [
                    TwSwatchHexColors.cyan[500]!,
                    TwSwatchHexColors.blue[500]!,
                  ]),
                ),
              ),
            ),
            SizedBox.square(
              dimension: 96,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.red,
                  gradient: TailwindGradient.linear(Alignment.topCenter, [
                    TwSwatchHexColors.sky[500]!,
                    TwSwatchHexColors.indigo[500]!,
                  ]),
                ),
              ),
            ),
            SizedBox.square(
              dimension: 96,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.red,
                  gradient: TailwindGradient.linear(Alignment.bottomLeft, [
                    TwSwatchHexColors.violet[500]!,
                    TwSwatchHexColors.fuchsia[500]!,
                  ]),
                ),
              ),
            ),
            SizedBox.square(
              dimension: 96,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.red,
                  gradient: TailwindGradient.linear(Alignment.centerRight, [
                    TwSwatchHexColors.purple[500]!,
                    TwSwatchHexColors.pink[500]!,
                  ], to: 65),
                ),
              ),
            ),
            Text("Radial Gradients"),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: TailwindGradient.radial(
                      [
                        TwSwatchHexColors.pink[400]!,
                        TwSwatchHexColors.fuchsia[700]!,
                      ],
                      center: Alignment.center,
                      from: 40,
                    ),
                  ),
                ),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: TailwindGradient.radialWithStops({
                      0: TwSwatchHexColors.sky[200]!,
                      50: TwSwatchHexColors.blue[400]!,
                      90: TwSwatchHexColors.indigo[900]!,
                    }, at: Alignment(0, 0.25)),
                  ),
                ),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: TailwindGradient.radialWithStops({
                      0: TwBasicColors.white,
                      75: TwSwatchHexColors.zinc[900]!,
                    }, at: Alignment(-0.25, -0.25)),
                  ),
                ),
              ],
            ),
            Text("Conic Gradients"),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: TailwindGradient.conic([
                      TwSwatchHexColors.blue[600]!,
                      TwSwatchHexColors.sky[400]!,
                    ], to: 50),
                  ),
                ),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: TailwindGradient.conic([
                      TwSwatchHexColors.indigo[600]!,
                      TwSwatchHexColors.indigo[50]!,
                      TwSwatchHexColors.indigo[600]!,
                    ], rotation: 180),
                  ),
                ),
                // TODO: Look into gradient traversal direction.
                // This demo goes in the decreasing direction of hue.
                // Possibly unimplemented in Flutter.
                // Container(
                //   width: 96,
                //   height: 96,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     gradient: TailwindGradient.conic([
                //       TwSwatchHexColors.violet[700]!,
                //       TwSwatchHexColors.lime[300]!,
                //       TwSwatchHexColors.violet[700]!,
                //     ]),
                //   ),
                // ),
              ],
            ),
            Text("Blurs"),
            SegmentedButton<ImageFilter>(
              segments: [
                ButtonSegment(value: ImageFilter.blur(), label: Text("none")),
                ButtonSegment(value: TwBlur.xs, label: Text("xs")),
                ButtonSegment(value: TwBlur.sm, label: Text("sm")),
                ButtonSegment(value: TwBlur.lg, label: Text("lg")),
                ButtonSegment(value: TwBlur.xl, label: Text("xl")),
                ButtonSegment(value: TwBlur.xl2, label: Text("xl2")),
                ButtonSegment(value: TwBlur.xl3, label: Text("xl3")),
              ],
              selected: {blur},
              onSelectionChanged: (p0) {
                Set<ImageFilter> diff = p0.difference({blur});
                switchBlur(diff.first);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageFiltered(
                // imageFilter: ImageFilter.blur(),
                imageFilter: blur,
                child: Image.network(
                  "https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&h=1000&q=90",
                  width: 256,
                  height: 256,
                ),
              ),
            ),
            Text("Border Radii"),
            SegmentedButton<Radius>(
              segments: [
                ButtonSegment(value: Radius.circular(0), label: Text("none")),
                ButtonSegment(value: TwRadius.xs, label: Text("xs")),
                ButtonSegment(value: TwRadius.sm, label: Text("sm")),
                ButtonSegment(value: TwRadius.lg, label: Text("lg")),
                ButtonSegment(value: TwRadius.xl, label: Text("xl")),
                ButtonSegment(value: TwRadius.xl2, label: Text("xl2")),
                ButtonSegment(value: TwRadius.xl3, label: Text("xl3")),
                ButtonSegment(value: TwRadius.xl4, label: Text("xl4")),
              ],
              selected: {radius},
              onSelectionChanged: (p0) {
                Set<Radius> diff = p0.difference({radius});
                switchRadius(diff.first);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Durations.medium2,
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: TwSwatchHexColors.purple[500]!,
                      borderRadius: BorderRadius.all(radius),
                    ),
                    width: 128,
                    height: 128,
                  ),
                ],
              ),
            ),
            Text("Breakpoints"),
            SegmentedButton<double>(
              segments: [
                ButtonSegment(value: TwBreakpoints.sm, label: Text("sm")),
                ButtonSegment(value: TwBreakpoints.lg, label: Text("lg")),
                ButtonSegment(value: TwBreakpoints.xl, label: Text("xl")),
                ButtonSegment(value: TwBreakpoints.xl2, label: Text("xl2")),
              ],
              selected: {breakpoint},
              onSelectionChanged: (p0) {
                Set<double> diff = p0.difference({breakpoint});
                switchBreakpoint(diff.first);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Durations.medium2,
                  curve: Curves.easeInOut,
                  color: TwSwatchHexColors.purple[500]!,
                  width: breakpoint,
                  height: 96,
                ),
              ],
            ),
            Text("Conatiner Breakpoints"),
            SegmentedButton<double>(
              segments: [
                ButtonSegment(
                  value: TwContainerBreakpoint.xs3,
                  label: Text("xs3"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xs2,
                  label: Text("xs2"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xs,
                  label: Text("xs"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.sm,
                  label: Text("sm"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.lg,
                  label: Text("lg"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xl,
                  label: Text("xl"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xl2,
                  label: Text("xl2"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xl3,
                  label: Text("xl3"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xl4,
                  label: Text("xl4"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xl5,
                  label: Text("xl5"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xl6,
                  label: Text("xl6"),
                ),
                ButtonSegment(
                  value: TwContainerBreakpoint.xl7,
                  label: Text("xl7"),
                ),
              ],
              selected: {containerBreakpoint},
              onSelectionChanged: (p0) {
                Set<double> diff = p0.difference({containerBreakpoint});
                switchContainerBreakpoint(diff.first);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Durations.medium2,
                  curve: Curves.easeInOut,
                  color: TwSwatchHexColors.purple[500]!,
                  width: containerBreakpoint,
                  height: 96,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text("Button"),
          icon: Icon(Icons.info),
        ),
      ),
    );
  }
}
