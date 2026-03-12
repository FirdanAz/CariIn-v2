// ignore_for_file: must_be_immutable

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/currency_format.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:cariin_v2/ui/widget/svg_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../model/company/detail_company_model.dart';
import '../../../service/api_service.dart';

class TabDeskripsi extends StatefulWidget {
  const TabDeskripsi({
    super.key,
    required this.id
  });
  final int id;

  @override
  State<TabDeskripsi> createState() => _TabDeskripsiState();
}

class _TabDeskripsiState extends State<TabDeskripsi> {
  DetailJobCompanyModel? detailCompanyModel;
  bool _isLoad = false;
  DateTime? date;

  getdata() async {
    _isLoad = true;
    if (kDebugMode) {
      print('id :  ${widget.id}');
    }
    DetailJobCompanyModel details = await ApiService().jobDetailCompany(widget.id);
    setState(() {
      detailCompanyModel = details;
      date = DateTime.parse(details.data!.jobCreated.toString());
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  TextStyle _textStyle(Color color, FontWeight fontWeight) => TextStyle(
    fontSize: Responsive.fontSize(14),
    fontWeight: fontWeight,
    color: color,
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad ? const Center(child: CircularProgressIndicator(),) : Padding(
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
              '${detailCompanyModel!.data!.description!.description}',
              textAlign: TextAlign.justify,
              style: _textStyle(color.onSurfaceVariant, FontWeight.w400),
            ),

            // Rincian pekerjaan
            const SizedBox(height: 20),
            _buildRincianPekerjaan(
              color: color,
              timeType: '${detailCompanyModel!.data!.timeType}',
              name: '${detailCompanyModel!.data!.title}',
              salary: CurrencyFormat.convertToIdr(detailCompanyModel!.data!.salary, 0),
              gender: '${detailCompanyModel!.data!.gender}',
              education: 'Semua',
              age: '17 - 35 Tahun',
            ),

            const SizedBox(height: 20),
            _buildTanggungJawab(
              color: color,
              responsibility: [
                "${detailCompanyModel!.data!.companyName}",
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
        const SizedBox(height: 8,),
        Text(
          'Tags :',
          style: _textStyle(color.onSurface, FontWeight.w500),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: detailCompanyModel!.data!.description!.tags!.length,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemBuilder: (context, index) {
            var data = detailCompanyModel!.data!.description!.tags![index];
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
                    data.name!,
                    textAlign: TextAlign.justify,
                    style: _textStyle(color.onSurfaceVariant, FontWeight.w400),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
