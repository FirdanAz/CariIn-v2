import 'package:flutter/material.dart';

import '../../common/app_color.dart';

class DangerZoneButton extends StatelessWidget {
  const DangerZoneButton(
      {super.key,
      required this.context,
      required this.title,
      required this.onTap});
  final BuildContext context;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
