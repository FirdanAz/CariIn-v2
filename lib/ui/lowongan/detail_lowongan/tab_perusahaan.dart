import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:flutter/material.dart';

class TabPerusahaan extends StatelessWidget {
  const TabPerusahaan({super.key});
  TextStyle _textStyle(Color color, FontWeight fontWeight) => TextStyle(
        fontSize: Responsive.fontSize(14),
        fontWeight: fontWeight,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Theme.of(context).brightness);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.byWidth(15),
        vertical: Responsive.byWidth(10),
      ),
      child: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tab 2',
              textAlign: TextAlign.justify,
              style: _textStyle(color.onSurfaceVariant, FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
