import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:cariin_v2/ui/widget/svg_icon.dart';
import 'package:flutter/material.dart';

class TabDeskripsi extends StatelessWidget {
  const TabDeskripsi({
    super.key,
  });
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
        width: screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dalam pekerjaan Desainer UX, Anda memerlukan kedua jenis keterampilan tersebut untuk mengembangkan produk generasi berikutnya. Anda akan bermitra dengan Peneliti dan Desainer untuk menentukan dan memberikan fitur baru.',
              textAlign: TextAlign.justify,
              style: _textStyle(color.onSurfaceVariant, FontWeight.w400),
            ),

            // Rincian pekerjaan
            const SizedBox(height: 20),
            _buildRincianPekerjaan(
              color: color,
              timeType: 'Full Time',
              name: 'Sr. UX Designer',
              salary: '2 jt/bulan',
              gender: 'Pria & Wanita',
              education: 'Semua',
              age: '17 - 35 Tahun',
            ),

            const SizedBox(height: 20),
            _buildTanggungJawab(
              color: color,
              responsibility: [
                "Understand, evangelize and educate on the businesses value of DeFI and GameFi.",
                "Understand, evangelize and educate on the businesses value of DeFI and GameFi.",
                "Understand, evangelize and educate on the businesses value of DeFI and GameFi.",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRincianPekerjaan({
    required AppColorData color,
    required String timeType,
    required String name,
    required String salary,
    required String gender,
    required String education,
    required String age,
  }) {
    Widget content(String svgIcon, String fill) {
      return Row(
        children: [
          SvgIcon(
            svgIcon,
            size: Responsive.byWidth(20),
            color: color.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Text(
            fill,
            style: _textStyle(color.onSurfaceVariant, FontWeight.w400),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rincian Pekerjaan :',
          style: _textStyle(color.onSurface, FontWeight.w500),
        ),
        const SizedBox(height: 8),
        content(AppAssets.clockIcon, timeType),
        const SizedBox(height: 12),
        content(AppAssets.suitcaseIcon, name),
        const SizedBox(height: 12),
        content(AppAssets.dollarIcon, salary),
        const SizedBox(height: 12),
        content(AppAssets.genderIcon, gender),
        const SizedBox(height: 12),
        content(AppAssets.graduationIcon, education),
        const SizedBox(height: 12),
        content(AppAssets.cakeIcon, age),
      ],
    );
  }

  Widget _buildTanggungJawab({
    required AppColorData color,
    required List responsibility,
  }) {
    Widget content(int index) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            child: Icon(Icons.circle,
                size: Responsive.byWidth(8), color: color.onSurfaceVariant),
          ),
          const SizedBox(width: 1),
          SizedBox(
            width: Responsive.byWidth(297),
            child: Text(
              responsibility[index],
              textAlign: TextAlign.justify,
              style: _textStyle(color.onSurfaceVariant, FontWeight.w400),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tangung Jawab :',
          style: _textStyle(color.onSurface, FontWeight.w500),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < responsibility.length; i++) content(i),
      ],
    );
  }
}
