import 'package:cariin_v2/ui/karyawan/lowongan/tab/lowongan_result.dart';
import 'package:cariin_v2/ui/karyawan/lowongan/tab/wawancara_procces.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class LowonganPage extends StatefulWidget {
  const LowonganPage({Key? key}) : super(key: key);

  @override
  State<LowonganPage> createState() => _LowonganPageState();
}

class _LowonganPageState extends State<LowonganPage> with TickerProviderStateMixin{
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
        centerTitle: true,
        title: const Text('Lowongan', style: TextStyle(fontWeight: FontWeight.w500),),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
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
                child: const Text("Lowongan Anda"),

              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Lowongan Aktif"),
                    SizedBox(width: 5,),
                    CircleAvatar(backgroundColor: Colors.green, radius: 5,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          LowonganProccesPage(),
          LowonganResultPage(),
        ],
      ),
    );
  }
}
