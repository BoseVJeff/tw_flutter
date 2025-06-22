import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:tw_flutter/colors.dart';

class DrawerWidget extends StatelessWidget {
  final void Function(String path) onTap;
  final Map<String, ({Widget page, String name})> pages;

  const DrawerWidget({super.key, required this.onTap, required this.pages});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StaticDynamicListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: TwColors.blue),
            child: Center(child: Text('tw_flutter')),
          ),
          ...pages.entries.map(
            (e) => ListTile(
              title: Text(e.value.name),
              onTap: () {
                onTap(e.key);
              },
            ),
          ),
          // ListTile(
          //   title: Text("Home"),
          //   onTap: () {
          //     onTap("/");
          //   },
          // ),
          // ListTile(
          //   title: Text("Colors"),
          //   onTap: () {
          //     onTap("/colors");
          //   },
          // ),
          // ListTile(
          //   title: Text("Box Properties"),
          //   onTap: () {
          //     onTap("/box");
          //   },
          // ),
          // ListTile(
          //   title: Text("Blurs"),
          //   onTap: () {
          //     onTap("/blur");
          //   },
          // ),
        ],
      ),
    );
  }
}
