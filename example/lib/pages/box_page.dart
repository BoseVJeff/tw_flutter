import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

class BoxPage extends StatefulWidget {
  const BoxPage({super.key});

  @override
  State<BoxPage> createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {
  late List<BoxShadow> shadow;
  late Size size;
  late Radius radius;

  @override
  void initState() {
    super.initState();
    shadow = TwShadow.md;
    size = TwSize.md;
    radius = TwRadius.xl;
  }

  void switchShadow(List<BoxShadow> newShadow) => setState(() {
    shadow = newShadow;
  });

  void switchRadius(Radius newRadius) => setState(() {
    radius = newRadius;
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Box Sizes"),
                SegmentedButton<Size>(
                  multiSelectionEnabled: false,
                  showSelectedIcon: false,
                  segments: TwSize.sizes.entries
                      .map(
                        (e) => ButtonSegment(
                          value: e.value,
                          label: Text(e.key),
                          enabled: size != e.value,
                        ),
                      )
                      .toList(),
                  selected: {size},
                  onSelectionChanged: (p0) {
                    Set<Size> diff = p0.difference({size});
                    setState(() {
                      size = diff.first;
                    });
                  },
                ),
                Text("Box Radius"),
                SegmentedButton<Radius>(
                  multiSelectionEnabled: false,
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: Radius.circular(0),
                      label: Text("none"),
                    ),
                    ButtonSegment(
                      value: TwRadius.xs,
                      label: Text("xs"),
                      enabled: radius != TwRadius.xs,
                    ),
                    ButtonSegment(
                      value: TwRadius.sm,
                      label: Text("sm"),
                      enabled: radius != TwRadius.sm,
                    ),
                    ButtonSegment(
                      value: TwRadius.lg,
                      label: Text("lg"),
                      enabled: radius != TwRadius.lg,
                    ),
                    ButtonSegment(
                      value: TwRadius.xl,
                      label: Text("xl"),
                      enabled: radius != TwRadius.xl,
                    ),
                    ButtonSegment(
                      value: TwRadius.xl2,
                      label: Text("xl2"),
                      enabled: radius != TwRadius.xl2,
                    ),
                    ButtonSegment(
                      value: TwRadius.xl3,
                      label: Text("xl3"),
                      enabled: radius != TwRadius.xl3,
                    ),
                    ButtonSegment(
                      value: TwRadius.xl4,
                      label: Text("xl4"),
                      enabled: radius != TwRadius.xl4,
                    ),
                  ],
                  selected: {radius},
                  onSelectionChanged: (p0) {
                    Set<Radius> diff = p0.difference({radius});
                    switchRadius(diff.first);
                  },
                ),
                Text("Tailwind Shadows"),
                SegmentedButton<List<BoxShadow>>(
                  multiSelectionEnabled: false,
                  showSelectedIcon: false,
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
                Text("Material Elevation Shadows"),
                SegmentedButton<List<BoxShadow>>(
                  multiSelectionEnabled: false,
                  showSelectedIcon: false,
                  segments: kElevationToShadow.entries
                      .map(
                        (s) => ButtonSegment(
                          value: s.value,
                          label: Text("E${s.key}"),
                          enabled: shadow != s.value,
                        ),
                      )
                      .toList(),
                  selected: {shadow},
                  onSelectionChanged: (p0) {
                    Set<List<BoxShadow>> diff = p0.difference({shadow});
                    switchShadow(diff.first);
                  },
                ),
                AnimatedContainer(
                  duration: TwTransition.duration,
                  // duration: Duration(seconds: 2),
                  curve: TwTransition.curve,
                  width: size.width,
                  height: TwSize.baseSize * 32,
                  // margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    boxShadow: shadow,
                    // color: TwBasicColors.white,
                    color: TwColors.neutral[200],
                    borderRadius: BorderRadius.all(radius),
                  ),
                  padding: EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, BoxConstraints c) {
                      // return Text("Size: ${size.width.toStringAsFixed(2)}");
                      return Center(child: Text(c.maxWidth.toStringAsFixed(2)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
