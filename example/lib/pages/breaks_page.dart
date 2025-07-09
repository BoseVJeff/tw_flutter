import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

const Map<String, double> containerSizes = {
  "xs3": TwContainerBreakpoint.xs3,
  "xs2": TwContainerBreakpoint.xs2,
  "xs": TwContainerBreakpoint.xs,
  "sm": TwContainerBreakpoint.sm,
  "md": TwContainerBreakpoint.md,
  "lg": TwContainerBreakpoint.lg,
  "xl": TwContainerBreakpoint.xl,
  "xl2": TwContainerBreakpoint.xl2,
  "xl3": TwContainerBreakpoint.xl3,
  "xl4": TwContainerBreakpoint.xl4,
  "xl5": TwContainerBreakpoint.xl5,
  "xl6": TwContainerBreakpoint.xl6,
  "xl7": TwContainerBreakpoint.xl7,
};

const Map<String, double> windowSizes = {
  "sm": TwBreakpoints.sm,
  "md": TwBreakpoints.md,
  "lg": TwBreakpoints.lg,
  "xl": TwBreakpoints.xl,
  "xl2": TwBreakpoints.xl2,
};

class BreaksPage extends StatelessWidget {
  const BreaksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double w = constraints.maxWidth;
        return StaticDynamicListView(
          children: [
            Center(child: Text("Window Breakpoints")),
            ...windowSizes.entries.map(
              (e) => Center(
                child: Container(
                  margin: TwMargin.m(2),
                  height: TwSize.baseSize * 8,
                  width: e.value,
                  decoration: BoxDecoration(
                    color: MediaQuery.sizeOf(context).width < e.value
                        ? TwColors.green
                        : TwColors.red,
                    borderRadius: BorderRadius.all(TwRadius.lg),
                  ),
                  child: Center(child: Text(e.key)),
                ),
              ),
            ),
            Center(child: Text("Container Breakpoints")),
            ...containerSizes.entries.map(
              (e) => Center(
                child: Container(
                  margin: TwMargin.m(2),
                  height: TwSize.baseSize * 8,
                  width: e.value,
                  decoration: BoxDecoration(
                    color: w < e.value ? TwColors.green : TwColors.red,
                    borderRadius: BorderRadius.all(TwRadius.lg),
                  ),
                  child: Center(child: Text(e.key)),
                ),
              ),
            ),
          ],
          // [
          //   Center(
          //     child: Container(
          //       margin: TwMargin.p(2),
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xs3,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xs3
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xs3")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xs2,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xs2
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xs2")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xs,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xs
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xs")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.sm,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.sm
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("sm")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.md,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.md
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("md")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.lg,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.lg
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("lg")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xl,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xl
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xl")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xl2,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xl2
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xl2")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xl3,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xl3
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xl3")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xl4,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xl4
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xl4")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xl5,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xl5
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xl5")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xl6,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xl6
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xl6")),
          //     ),
          //   ),
          //   Center(
          //     child: Container(
          //       height: TwSize.baseSize * 16,
          //       width: TwContainerBreakpoint.xl7,
          //       decoration: BoxDecoration(
          //         color: w < TwContainerBreakpoint.xl7
          //             ? TwColors.green
          //             : TwColors.red,
          //         borderRadius: BorderRadius.all(TwRadius.lg),
          //       ),
          //       child: Center(child: Text("xl7")),
          //     ),
          //   ),
          // ],
        );
      },
    );
  }
}
