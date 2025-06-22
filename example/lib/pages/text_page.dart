import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  late List<BoxShadow> textShadow;

  @override
  void initState() {
    super.initState();
    textShadow = TwShadow.md;
  }

  @override
  Widget build(BuildContext context) {
    return StaticDynamicListView(
      children: [
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
            setState(() {
              textShadow = diff.first;
            });
          },
        ),
        ListTile(
          title: Text("font-sans"),
          subtitle: Text("The quick brown fox jumps over the lazy dog."),
          titleTextStyle: Theme.of(
            context,
          ).textTheme.labelSmall!.xs().withSans(),
          subtitleTextStyle: Theme.of(context).textTheme.labelMedium!
              .lg()
              .withSans()
              .copyWith(shadows: textShadow),
        ),
        ListTile(
          title: Text("font-serif"),
          subtitle: Text("The quick brown fox jumps over the lazy dog."),
          titleTextStyle: Theme.of(
            context,
          ).textTheme.labelSmall!.xs().withSerif(),
          subtitleTextStyle: Theme.of(context).textTheme.labelMedium!
              .lg()
              .withSerif()
              .copyWith(shadows: textShadow),
        ),
        ListTile(
          title: Text("font-mono"),
          subtitle: Text("The quick brown fox jumps over the lazy dog."),
          titleTextStyle: Theme.of(
            context,
          ).textTheme.labelSmall!.xs().withMono(),
          subtitleTextStyle: Theme.of(context).textTheme.labelMedium!
              .lg()
              .withMono()
              .copyWith(shadows: textShadow),
        ),
      ],
    );
  }
}
