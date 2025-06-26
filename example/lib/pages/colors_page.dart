import 'package:example/utils.dart';
import 'package:example/utils/consts.dart';
import 'package:example/widgets/swatch_widget.dart';
import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

class ColorsPage extends StatefulWidget {
  const ColorsPage({super.key});

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  late ColorSwatch<int> swatch;

  @override
  void initState() {
    super.initState();
    swatch = TwMaterialColors.neutral;
  }

  void switchSwatch(ColorSwatch<int> newSwatch) => setState(() {
    swatch = newSwatch;
  });

  Map<double, Color> toColorMap(ColorSwatch<int> s) {
    Map<double, Color> m = {};

    for (var e in s.keys) {
      m.addAll({e / 1000: s[e]!});
    }

    return m;
  }

  @override
  Widget build(BuildContext context) {
    return StaticDynamicListView(
      children: [
        Text("Material Colors"),
        Wrap(
          children: materialColors.entries
              .map(
                (e) => IconButton(
                  onPressed: () {
                    switchSwatch(e.value);
                  },
                  icon: Icon(
                    (swatch == e.value) ? Icons.check_circle : Icons.circle,
                    color: e.value,
                  ),
                  tooltip: e.key,
                ),
              )
              .toList(),
        ),
        Text("Tailwind Colors"),
        Wrap(
          // children: TwMaterialColors.colorList.entries
          children: TwColors.colorList.entries
              .map(
                (e) => IconButton(
                  onPressed: () {
                    switchSwatch(e.value);
                  },
                  icon: Icon(
                    (swatch == e.value) ? Icons.check_circle : Icons.circle,
                    color: e.value,
                  ),
                  tooltip: e.key,
                ),
              )
              .toList(),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: SwatchWidget(color: swatch),
        ),
        // Container(
        //   padding: const EdgeInsets.all(8.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     gradient: TailwindGradient.linearWithStops(
        //       Alignment.centerRight,
        //       toColorMap(swatch),
        //     ),
        //   ),
        //   // child: SwatchWidget(color: swatch),
        // ),
      ],
    );
  }
}
