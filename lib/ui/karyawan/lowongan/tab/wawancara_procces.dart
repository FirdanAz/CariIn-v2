import 'package:cariin_v2/ui/karyawan/lowongan/tab/procces_tabs/diterima.dart';
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
      const ProccesDiterimaTab(),
    ];
    return SingleChildScrollView(
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
                "Menunggu",
                "Diterima",
                "Direkrut"
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
    );
  }
}
