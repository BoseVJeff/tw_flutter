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
  late FontWeight weight;
  late bool isItalic;

  @override
  void initState() {
    super.initState();
    textShadow = TwShadow.md;
    weight = TwFontWeightRaw.medium;
    isItalic = false;
  }

  @override
  Widget build(BuildContext context) {
    return StaticDynamicListView(
      children: [
        Padding(
          padding: TwPadding.p(2),
          child: SegmentedButton<FontWeight>(
            showSelectedIcon: false,
            multiSelectionEnabled: false,
            segments: [
              ButtonSegment(
                value: TwFontWeightRaw.thin,
                label: Text("thin"),
                enabled: weight != TwFontWeightRaw.thin,
              ),
              ButtonSegment(
                value: TwFontWeightRaw.extralight,
                label: Text("extralight"),
                enabled: weight != TwFontWeightRaw.extralight,
              ),
              ButtonSegment(
                value: TwFontWeightRaw.light,
                label: Text("light"),
                enabled: weight != TwFontWeightRaw.light,
              ),
              ButtonSegment(
                value: TwFontWeightRaw.normal,
                label: Text("normal"),
                enabled: weight != TwFontWeightRaw.normal,
              ),
              ButtonSegment(
                value: TwFontWeightRaw.medium,
                label: Text("medium"),
                enabled: weight != TwFontWeightRaw.medium,
              ),
              ButtonSegment(
                value: TwFontWeightRaw.semibold,
                label: Text("semibold"),
                enabled: weight != TwFontWeightRaw.semibold,
              ),
              ButtonSegment(
                value: TwFontWeightRaw.bold,
                label: Text("bold"),
                enabled: weight != TwFontWeightRaw.bold,
              ),
              ButtonSegment(
                value: TwFontWeightRaw.extrabold,
                label: Text("extrabold"),
                enabled: weight != TwFontWeightRaw.extrabold,
              ),
              ButtonSegment(
                value: TwFontWeightRaw.black,
                label: Text("black"),
                enabled: weight != TwFontWeightRaw.black,
              ),
            ],
            selected: {weight},
            onSelectionChanged: (Set<FontWeight> w) {
              Set<FontWeight> diff = w.difference({weight});
              setState(() {
                weight = diff.first;
              });
            },
          ),
        ),
        Padding(
          padding: TwPadding.p(2),
          child: SegmentedButton<List<BoxShadow>>(
            showSelectedIcon: false,
            multiSelectionEnabled: false,
            segments: [
              ButtonSegment(
                value: [],
                label: Text("none"),
                enabled: textShadow.isNotEmpty,
              ),
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
        ),
        ListTile(
          title: Text("Italic Text"),
          onTap: () => setState(() {
            isItalic = !isItalic;
          }),
          leading: Checkbox(
            value: isItalic,
            onChanged: (bool? newValue) {
              setState(() {
                isItalic = newValue ?? isItalic;
              });
            },
          ),
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
              .copyWith(
                shadows: textShadow,
                fontWeight: weight,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              ),
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
              .copyWith(
                shadows: textShadow,
                fontWeight: weight,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              ),
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
              .copyWith(
                shadows: textShadow,
                fontWeight: weight,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              ),
        ),
      ],
    );
  }
}
