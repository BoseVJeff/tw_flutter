import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Spin"),
        Container(
          decoration: BoxDecoration(
            color: TwColors.indigo[500],
            borderRadius: BorderRadius.all(TwRadius.lg),
          ),
          padding: TwPadding.p(2),
          width: TwSize.baseSize * 8,
          height: TwSize.baseSize * 8,
          child: TwAnimationSpin(
            child: CircularProgressIndicator(
              value: 0.25,
              color: TwBasicColors.white,
              backgroundColor: TwBasicColors.white.withAlpha(128),
              strokeWidth: 2,
            ),
          ),
        ),
        Text("Ping"),
        Padding(
          padding: TwPadding.px(1),
          child: Stack(
            children: [
              TwAnimatedPing(
                child: Opacity(
                  opacity: 0.75,
                  child: Icon(
                    Icons.circle,
                    color: TwColors.sky[400],
                    size: TwSize.baseSize * 5,
                  ),
                ),
              ),
              Icon(
                Icons.circle,
                color: TwColors.sky[500],
                size: TwSize.baseSize * 5,
              ),
            ],
          ),
        ),
        Text("Pulse"),
        TwAnimatedPulse(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: TwSize.baseSize * 2,
            children: [
              Icon(
                Icons.circle,
                color: TwColors.gray[200],
                size: TwSize.baseSize * 6,
              ),
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadiusGeometry.all(TwRadius.xl4),
                child: Container(
                  width: TwSize.wXs3,
                  height: TwSize.baseSize * 4,
                  color: TwColors.gray[200],
                ),
              ),
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadiusGeometry.all(TwRadius.xl4),
                child: Container(
                  width: TwSize.baseSize * 8,
                  height: TwSize.baseSize * 4,
                  color: TwColors.gray[200],
                ),
              ),
            ],
          ),
        ),
        Text("Bounce"),
        TwAnimatedBounce(
          // Boundary here is to fix the icon bouncing seemingly out of sync with the outline
          child: RepaintBoundary(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: TwColors.gray[500]!.withAlpha(128)),
              ),
              width: TwSize.baseSize * 10,
              height: TwSize.baseSize * 10,
              child: Icon(
                Icons.arrow_downward,
                color: TwColors.violet[500],
                size: TwSize.baseSize * 6,
              ),
            ),
          ),
        ),
        // SizeBuilder(child: FlutterLogo()),
      ],
    );
  }
}
