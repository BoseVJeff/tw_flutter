import 'package:flutter/material.dart';
import 'package:tw_flutter/tw_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        child: BackdropFilter(
          filter: TwBlur.xs,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: TwColors.neutral),
              borderRadius: BorderRadius.all(TwRadius.xl),
            ),
            padding: TwPadding.p(8),
            child: RichText(
              text: TextSpan(
                text: "Welcome to ",
                style: TwFont.sans.copyWith(color: TwColors.gray),
                children: [
                  TextSpan(
                    text: "tw_flutter",
                    style: TwFont.mono, //.copyWith(color: TwBasicColors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
