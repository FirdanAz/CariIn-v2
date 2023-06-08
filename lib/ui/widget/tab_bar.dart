import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final _chip = Container(
    height: 30,
    padding: EdgeInsets.symmetric(horizontal: 60),
    color: Colors.amber,
    child: Text('Tab 1'),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ColoredBox(
        color: Colors.green,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(2, (index) {
            return _chip;
          }),
        ),
      ),
    );
  }
}
