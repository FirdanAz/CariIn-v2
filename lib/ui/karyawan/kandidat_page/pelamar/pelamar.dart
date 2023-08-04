import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/pelamar/tab_worker/diterima.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/pelamar/tab_worker/ditolak.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/pelamar/tab_worker/menunggu.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/pelamar/tab_worker/semua.dart';
import 'package:flutter/material.dart';

import '../../../../common/responsive.dart';
import '../../../widget/chip_tab_bar.dart';

class PelamarTab extends StatefulWidget {
  const PelamarTab({Key? key}) : super(key: key);

  @override
  State<PelamarTab> createState() => _PelamarTabState();
}

class _PelamarTabState extends State<PelamarTab> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Theme.of(context).brightness);

    final List<Widget> tabView = [
      const SemuaTabs(),
      const DiterimaTabs(),
      const MenungguTabs(),
      const DitolakTabs(),
    ];
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ChipTabBar(
                length: 4,
                itemDistance: Responsive.byWidth(12),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.byWidth(15),
                  vertical: Responsive.byWidth(10),
                ),
                tabLabels: const [
                  "Semua",
                  "Diterima",
                  "Menunggu",
                  "Ditolak",
                ],
                onTap: (value) => _tabIndex.value = value,
              ),
            ),

            // TabBar View
            ValueListenableBuilder<int>(
              valueListenable: _tabIndex,
              builder: (context, value, child) {
                return tabView[value];
              },
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
