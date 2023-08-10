import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/lamaran_procces.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/lamaran_result.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class LamaranPage extends StatefulWidget {
  LamaranPage({Key? key}) : super(key: key);

  @override
  State<LamaranPage> createState() => _LamaranPageState();
}

class _LamaranPageState extends State<LamaranPage> with TickerProviderStateMixin{
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
                child: Text("Hasil Lamaran"),

              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Text("Pekerjaan Dilamar"),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          LamaranResult(),
          LamaranProcces()
        ],
      ),
    );
  }
}
