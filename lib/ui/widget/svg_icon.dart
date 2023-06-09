import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.path, {super.key, this.size, this.color});
  final String path;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final appColor = AppColor.theme(Theme.of(context).brightness);
    final double iconSize = size ?? 24;
    final Color iconColor = color ?? appColor.onSurface;
    return SvgPicture.asset(
      path,
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  }
}
