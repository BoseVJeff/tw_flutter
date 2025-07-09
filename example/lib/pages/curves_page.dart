import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

class CurvesPage extends StatefulWidget {
  const CurvesPage({super.key});

  @override
  State<CurvesPage> createState() => _CurvesPageState();
}

class _CurvesPageState extends State<CurvesPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  final double startOffset = 0.1;
  final double endOffset = 0.9;

  @override
  void initState() {
    super.initState();
    // _controller.addStatusListener(animationStatusListner);
  }

  @override
  void dispose() {
    // _controller.removeStatusListener(animationStatusListner);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaticDynamicListView(
      children: [
        ListTile(
          title: Text(
            "linear",
            style: TextStyle(color: TwColors.gray[950]).withMono(),
          ),
          subtitle: Container(
            height: TwSize.baseSize * 16,
            padding: TwPadding.px(4),
            // decoration: BoxDecoration(color: TwColors.red),
            child: LayoutBuilder(
              builder: (context, constraints) {
                Size biggest = constraints.biggest;
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Text("Hello"),
                    // CurveMovementWidget(curve: Curves.bounceIn),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: TwColors.gray[950]!.withAlpha(128),
                      ),
                    ),
                    RelativePositionedTransition(
                      rect:
                          RectTween(
                            begin: Rect.fromCircle(
                              center: Offset(0, biggest.height / 2),
                              radius: 8,
                            ),
                            end: Rect.fromCircle(
                              center: Offset(biggest.width, biggest.height / 2),
                              radius: 8,
                            ),
                          ).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(
                                startOffset,
                                endOffset,
                                curve: Curves.linear,
                              ),
                            ),
                          ),
                      size: biggest,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: TwColors.sky[400],
                          borderRadius: BorderRadius.all(TwRadius.lg),
                          boxShadow: TwShadow.lg,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        ListTile(
          title: Text(
            "ease-in",
            style: TextStyle(color: TwColors.gray[950]).withMono(),
          ),
          subtitle: Container(
            height: TwSize.baseSize * 16,
            padding: TwPadding.px(4),
            // decoration: BoxDecoration(color: TwColors.red),
            child: LayoutBuilder(
              builder: (context, constraints) {
                Size biggest = constraints.biggest;
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Text("Hello"),
                    // CurveMovementWidget(curve: Curves.bounceIn),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: TwColors.gray[950]!.withAlpha(128),
                      ),
                    ),
                    RelativePositionedTransition(
                      rect:
                          RectTween(
                            begin: Rect.fromCircle(
                              center: Offset(0, biggest.height / 2),
                              radius: 8,
                            ),
                            end: Rect.fromCircle(
                              center: Offset(biggest.width, biggest.height / 2),
                              radius: 8,
                            ),
                          ).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(
                                startOffset,
                                endOffset,
                                curve: TwCurves.easeIn,
                              ),
                            ),
                          ),
                      size: biggest,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: TwColors.purple[400],
                          borderRadius: BorderRadius.all(TwRadius.lg),
                          boxShadow: TwShadow.lg,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        ListTile(
          title: Text(
            "ease-out",
            style: TextStyle(color: TwColors.gray[950]).withMono(),
          ),
          subtitle: Container(
            height: TwSize.baseSize * 16,
            padding: TwPadding.px(4),
            // decoration: BoxDecoration(color: TwColors.red),
            child: LayoutBuilder(
              builder: (context, constraints) {
                Size biggest = constraints.biggest;
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Text("Hello"),
                    // CurveMovementWidget(curve: Curves.bounceIn),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: TwColors.gray[950]!.withAlpha(128),
                      ),
                    ),
                    RelativePositionedTransition(
                      rect:
                          RectTween(
                            begin: Rect.fromCircle(
                              center: Offset(0, biggest.height / 2),
                              radius: 8,
                            ),
                            end: Rect.fromCircle(
                              center: Offset(biggest.width, biggest.height / 2),
                              radius: 8,
                            ),
                          ).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(
                                startOffset,
                                endOffset,
                                curve: TwCurves.easeOut,
                              ),
                            ),
                          ),
                      size: biggest,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: TwColors.pink[400],
                          borderRadius: BorderRadius.all(TwRadius.lg),
                          boxShadow: TwShadow.lg,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        ListTile(
          title: Text(
            "ease-in-out",
            style: TextStyle(color: TwColors.gray[950]).withMono(),
          ),
          subtitle: Container(
            height: TwSize.baseSize * 16,
            padding: TwPadding.px(4),
            // decoration: BoxDecoration(color: TwColors.red),
            child: LayoutBuilder(
              builder: (context, constraints) {
                Size biggest = constraints.biggest;
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Text("Hello"),
                    // CurveMovementWidget(curve: Curves.bounceIn),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: TwColors.gray[950]!.withAlpha(128),
                      ),
                    ),
                    RelativePositionedTransition(
                      rect:
                          RectTween(
                            begin: Rect.fromCircle(
                              center: Offset(0, biggest.height / 2),
                              radius: 8,
                            ),
                            end: Rect.fromCircle(
                              center: Offset(biggest.width, biggest.height / 2),
                              radius: 8,
                            ),
                          ).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(
                                startOffset,
                                endOffset,
                                curve: TwCurves.easeInOut,
                              ),
                            ),
                          ),
                      size: biggest,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: TwColors.indigo[400],
                          borderRadius: BorderRadius.all(TwRadius.lg),
                          boxShadow: TwShadow.lg,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CurveMovementWidget extends StatefulWidget {
  final Curve curve;

  const CurveMovementWidget({super.key, required this.curve});

  @override
  State<CurveMovementWidget> createState() => _CurveMovementWidgetState();
}

class _CurveMovementWidgetState extends State<CurveMovementWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size biggest = constraints.biggest;
        return RelativePositionedTransition(
          rect: RectTween(
            begin: Rect.fromCircle(center: Offset.zero, radius: 8),
            end: Rect.fromCircle(center: Offset(biggest.width, 0), radius: 8),
          ).animate(CurvedAnimation(parent: _controller, curve: widget.curve)),
          size: biggest,
          child: SizedBox.square(dimension: 8),
        );
      },
    );
  }
}
