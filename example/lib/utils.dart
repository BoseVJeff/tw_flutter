import 'package:flutter/widgets.dart';

class StaticDynamicListView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const StaticDynamicListView({
    super.key,
    this.children = const [],
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => children[index],
      itemCount: children.length,
      padding: padding,
    );
  }
}
