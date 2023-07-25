import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:flutter/material.dart';

class ChipTabBar extends StatefulWidget {
  const ChipTabBar({
    super.key,
    required this.length,
    this.itemDistance = 12,
    required this.tabLabels,
    this.padding = EdgeInsets.zero,
    required this.onTap,
  });
  final int length;
  final double itemDistance;
  final List<String> tabLabels;
  final EdgeInsetsGeometry padding;
  final ValueChanged<int> onTap;

  @override
  State<ChipTabBar> createState() => _ChipTabBarState();
}

class _ChipTabBarState extends State<ChipTabBar> {
  int tabIndex = 0;

  void _handleTap(int index) {
    assert(index >= 0 && index < widget.length);
    widget.onTap.call(index);
  }

  // Tab
  Widget _chip({
    required int index,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tabIndex = index;
        });
        _handleTap(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.byWidth(12),
          vertical: Responsive.byWidth(6),
        ),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          widget.tabLabels[index],
          style: TextStyle(
            fontSize: Responsive.fontSize(14),
            fontWeight: FontWeight.w500,
            color: foregroundColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColor.theme(Theme.of(context).brightness);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                right: index < widget.length - 1 ? widget.itemDistance / 2 : 0,
                left: index > 0 ? widget.itemDistance / 2 : 0,
              ),
              child: tabIndex == index
                  ? _chip(
                      index: index,
                      foregroundColor: color.onPrimary,
                      backgroundColor: color.primary,
                    )
                  : _chip(
                      index: index,
                      foregroundColor: color.onPrimaryContainer,
                      backgroundColor: color.primaryContainer,
                    ),
            );
          }),
        ),
      ),
    );
  }
}
