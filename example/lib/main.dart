import 'package:example/pages/animation_page.dart';
import 'package:example/pages/blur_page.dart';
import 'package:example/pages/box_page.dart';
import 'package:example/pages/breaks_page.dart';
import 'package:example/pages/colors_page.dart';
import 'package:example/pages/curves_page.dart';
import 'package:example/pages/gradient_page.dart';
import 'package:example/pages/home_page.dart';
import 'package:example/pages/spacing_page.dart';
import 'package:example/pages/text_page.dart';
import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

void main() {
  runApp(const TailwindApp());
}

class TailwindApp extends StatefulWidget {
  const TailwindApp({super.key});

  @override
  State<TailwindApp> createState() => _TailwindAppState();
}

class _TailwindAppState extends State<TailwindApp> {
  late ({Widget page, String name, Widget icon, Widget? selectedIcon})
  currentPage;
  late int selectedIndex;
  late bool isExpanded;

  static const Map<
    String,
    ({Widget page, String name, Widget icon, Widget? selectedIcon})
  >
  routes = {
    "/": (
      name: "Home",
      page: HomePage(),
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
    ),
    "/colors": (
      name: "Colors",
      page: ColorsPage(),
      icon: Icon(Icons.color_lens_outlined),
      selectedIcon: Icon(Icons.color_lens),
    ),
    "/box": (
      name: "Box Properties",
      page: BoxPage(),
      icon: Icon(Icons.crop_square_outlined),
      selectedIcon: Icon(Icons.crop_square),
    ),
    "/spacing": (
      name: "Spacing",
      page: SpacingPage(),
      icon: Icon(Icons.expand_outlined),
      selectedIcon: Icon(Icons.expand),
    ),
    "/curves": (
      name: "Curves",
      page: CurvesPage(),
      icon: Icon(Icons.linear_scale),
      selectedIcon: Icon(Icons.linear_scale_rounded),
    ),
    "/blur": (
      name: "Blurs",
      page: BlurPage(),
      icon: Icon(Icons.blur_circular_outlined),
      selectedIcon: Icon(Icons.blur_circular_outlined),
    ),
    "/text": (
      name: "Text",
      page: TextPage(),
      icon: Icon(Icons.text_snippet_outlined),
      selectedIcon: Icon(Icons.text_snippet),
    ),
    "/breaks": (
      name: "Breakpoints",
      page: BreaksPage(),
      icon: Icon(Icons.window_outlined),
      selectedIcon: Icon(Icons.window),
    ),
    "/gradients": (
      name: "Gradients",
      page: GradientPage(),
      icon: Icon(Icons.gradient_outlined),
      selectedIcon: Icon(Icons.gradient),
    ),
    "/animation": (
      name: "Animation",
      page: AnimationPage(),
      icon: Icon(Icons.animation_outlined),
      selectedIcon: Icon(Icons.animation),
    ),
  };

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    currentPage = routes.entries.elementAt(selectedIndex).value;
    isExpanded = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tw_flutter Demo",
      theme: ThemeData(
        scaffoldBackgroundColor: TwBasicColors.white,
        brightness: Brightness.light,
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: ButtonStyle(alignment: Alignment.center),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: TwBasicColors.white,
          titleTextStyle: TextStyle(
            color: TwColors.gray[950],
            fontFamily: TwFonts.sans.first,
            fontFamilyFallback: TwFonts.sans,
            fontSize: TwFontSizeRaw.xl,
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          // centerTitle: true,
        ),
        navigationRailTheme: NavigationRailThemeData(
          elevation: 0,
          // useIndicator: false,
          indicatorColor: Colors.transparent,
          minExtendedWidth: TwSize.wXs2,
          selectedIconTheme: IconThemeData(color: TwColors.gray[950]),
          unselectedIconTheme: IconThemeData(color: TwColors.gray[600]),
          backgroundColor: TwBasicColors.white,
          selectedLabelTextStyle: TextStyle(
            fontFamily: TwFonts.sans.first,
            fontFamilyFallback: TwFonts.sans,
            color: TwColors.gray[950],
            fontWeight: TwFontWeightRaw.semibold,
            fontSize: TwFontSizeRaw.sm,
            height: TwLineHeightRaw.sm,
          ),
          unselectedLabelTextStyle: TextStyle(
            fontFamily: TwFonts.sans.first,
            fontFamilyFallback: TwFonts.sans,
            color: TwColors.gray[600],
            fontSize: TwFontSizeRaw.sm,
            height: TwLineHeightRaw.sm,
          ),
        ),
        fontFamily: TwFonts.sans.first,
        fontFamilyFallback: TwFonts.sans,
        primaryColor: TwBasicColors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: TwBasicColors.white,
          dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: TwColors.gray[950],
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      themeAnimationDuration: TwTransition.duration,
      themeAnimationCurve: TwTransition.curve,
      home: Row(
        children: [
          NavigationRail(
            destinations: routes.entries
                .map<NavigationRailDestination>(
                  (e) => NavigationRailDestination(
                    icon: e.value.icon,
                    selectedIcon: e.value.selectedIcon,
                    label: Text(e.value.name),
                  ),
                )
                .toList(),
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
                currentPage = routes.entries.elementAt(value).value;
              });
            },
            extended: true,
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(title: Text(currentPage.name)),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    // width: constraints.maxWidth,
                    // height: constraints.maxHeight,
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft / 64,
                        end: Alignment.bottomRight / 64,
                        colors: [
                          TwColors.gray[950]!.withAlpha(0x1a),
                          TwColors.gray[950]!.withAlpha(0x1a),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                        stops: [0, 0.05, 0.05, 1],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    child: Container(
                      margin: TwMargin.mx(4),
                      padding: TwPadding.px(2),
                      decoration: BoxDecoration(
                        color: TwBasicColors.white,
                        border: Border.all(
                          color: TwColors.gray[950]!.withAlpha(13),
                        ),
                        borderRadius: BorderRadius.all(TwRadius.xs),
                      ),
                      child: currentPage.page,
                    ),
                  );
                },
              ),
              // drawer: DrawerWidget(
              //   pages: routes,
              //   onTap: (String path) {
              //     setState(() {
              //       currentPage = routes[path]!;
              //     });
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
