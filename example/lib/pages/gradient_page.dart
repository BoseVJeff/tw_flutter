import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

class GradientPage extends StatelessWidget {
  const GradientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StaticDynamicListView(
      children: [
        Text("Linear Gradients"),
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
                gradient: TailwindGradient.radial([
                  TwSwatchHexColors.pink[400]!,
                  TwSwatchHexColors.fuchsia[700]!,
                ], from: 0.40),
              ),
            ),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: TailwindGradient.radialWithStops({
                  0: TwSwatchHexColors.sky[200]!,
                  0.50: TwSwatchHexColors.blue[400]!,
                  0.90: TwSwatchHexColors.indigo[900]!,
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
                  0.75: TwSwatchHexColors.zinc[900]!,
                }, at: Alignment(-0.5, -0.5)),
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
      ],
    );
  }
}
