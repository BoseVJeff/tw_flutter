import 'package:flutter/widgets.dart';

class SwatchWidget extends StatelessWidget {
  final ColorSwatch<int> color;

  const SwatchWidget({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: color.keys
          .map(
            (e) => Container(
              height: 240,
              width: 48,
              decoration: BoxDecoration(color: color[e]),
              alignment: Alignment.center,
              // duration: Duration(milliseconds: 100),
              child: Text(
                e.toString(),
                style: TextStyle(
                  color: (color[e]!.computeLuminance() > 0.3)
                      ? Color(0xFF000000)
                      : Color(0xFFFFFFFF),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
