import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/lowongan/lowongan.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/pelamar/pelamar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_color.dart';

class KandidatPage extends StatefulWidget {
  KandidatPage({Key? key}) : super(key: key);

  @override
  State<KandidatPage> createState() => _KandidatPageState();
}

class _KandidatPageState extends State<KandidatPage> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: TabBar(
            controller: _tabController,
            unselectedLabelColor: color.black,
            labelColor: color.black,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 5,
                color: color.primary,
              ),
            ),
            tabs: [
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Text("Pelamar"),

              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Text("Lowongan"),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PelamarTab(),
          LowonganPage(),
        ],
      ),
    );
  }
}
