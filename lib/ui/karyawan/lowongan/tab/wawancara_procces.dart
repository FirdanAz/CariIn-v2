// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:cariin_v2/ui/karyawan/lowongan/tab/procces_tabs/diterima.dart';
import 'package:cariin_v2/ui/karyawan/lowongan/tab/procces_tabs/expired.dart';
import 'package:cariin_v2/ui/karyawan/lowongan/tab/procces_tabs/menunggu.dart';
import 'package:cariin_v2/ui/karyawan/lowongan/tab/procces_tabs/semua.dart';
import 'package:flutter/material.dart';
import '../../../../common/responsive.dart';
import '../../../widget/chip_tab_bar.dart';

class LowonganProccesPage extends StatefulWidget {
  const LowonganProccesPage({Key? key}) : super(key: key);

  @override
  State<LowonganProccesPage> createState() => _LowonganProccesPageState();
}

class _LowonganProccesPageState extends State<LowonganProccesPage> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabView = [
      const ProccesSemuaTab(),
      const ProccesMenungguTab(),
      const ProccesDiterimaTab(),
      const ProccessExpiredTab()
    ];
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(indexs: 2),), (route) => false);
      },
      child: SingleChildScrollView(
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
                  "Belum Terverifikasi",
                  "Terverifikasi",
                  "Kadaluarsa"
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
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
