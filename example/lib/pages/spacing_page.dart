import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: TwSize.baseSize * 48,
        height: TwSize.baseSize * 48,
        decoration: BoxDecoration(
          color: TwColors.purple[100]!,
          borderRadius: BorderRadius.all(TwRadius.xl),
        ),
        child: Container(
          padding: TwPadding.p(8),
          margin: TwMargin.m(8),
          decoration: BoxDecoration(
            color: TwColors.purple[300]!,
            borderRadius: BorderRadius.all(TwRadius.lg),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: TwColors.purple[500]!,
              borderRadius: BorderRadius.all(TwRadius.sm),
            ),
          ),
        ),
      ),
    );
  }
}
