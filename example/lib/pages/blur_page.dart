import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tw_flutter/blurs.dart';
import 'package:tw_flutter/radii.dart';
import 'package:tw_flutter/sizes.dart';

class BlurPage extends StatefulWidget {
  const BlurPage({super.key});

  @override
  State<BlurPage> createState() => _BlurPageState();
}

class _BlurPageState extends State<BlurPage> {
  late ImageFilter blur;

  @override
  void initState() {
    super.initState();
    blur = ImageFilter.blur();
  }

  void switchBlur(ImageFilter newBlur) => setState(() {
    blur = newBlur;
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedButton<ImageFilter>(
          showSelectedIcon: false,
          multiSelectionEnabled: false,
          segments: [
            ButtonSegment(
              value: ImageFilter.blur(),
              label: Text("none"),
              enabled: ImageFilter.blur() != blur,
            ),
            ButtonSegment(
              value: TwBlur.xs,
              label: Text("xs"),
              enabled: TwBlur.xs != blur,
            ),
            ButtonSegment(
              value: TwBlur.sm,
              label: Text("sm"),
              enabled: TwBlur.sm != blur,
            ),
            ButtonSegment(
              value: TwBlur.lg,
              label: Text("lg"),
              enabled: TwBlur.lg != blur,
            ),
            ButtonSegment(
              value: TwBlur.xl,
              label: Text("xl"),
              enabled: TwBlur.xl != blur,
            ),
            ButtonSegment(
              value: TwBlur.xl2,
              label: Text("xl2"),
              enabled: TwBlur.xl2 != blur,
            ),
            ButtonSegment(
              value: TwBlur.xl3,
              label: Text("xl3"),
              enabled: TwBlur.xl3 != blur,
            ),
          ],
          selected: {blur},
          onSelectionChanged: (p0) {
            Set<ImageFilter> diff = p0.difference({blur});
            switchBlur(diff.first);
          },
        ),
        Expanded(
          child: Center(
            child: ImageFiltered(
              imageFilter: blur,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(TwRadius.lg),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  "images/mountain.jpg",
                  width: TwSize.baseSize * 48,
                  height: TwSize.baseSize * 48,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
