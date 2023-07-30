import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/diterima.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/ditolak.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/menunggu.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/semua.dart';
import 'package:flutter/material.dart';

import '../../../../common/responsive.dart';
import '../../../widget/chip_tab_bar.dart';

class LamaranResult extends StatefulWidget {
  const LamaranResult({Key? key}) : super(key: key);

  @override
  State<LamaranResult> createState() => _LamaranResultState();
}

class _LamaranResultState extends State<LamaranResult> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    //final color = AppColor.theme(Theme.of(context).brightness);

    final List<Widget> tabView = [
      const SemuaTabs(),
      const DiterimaTabs(),
      const MenungguTabs(),
      const DitolakTabs(),
    ];
    return Container(
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
        ],
      ),
    );
  }
}
