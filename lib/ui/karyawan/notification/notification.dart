import 'package:cariin_v2/ui/karyawan/notification/chat/chat.dart';
import 'package:cariin_v2/ui/karyawan/notification/notifikasi/notif_page.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with TickerProviderStateMixin{
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
                child: Text("Notifikasi"),

              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Text("Chat"),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NotifPage(),
          ChatPage(),
        ],
      ),
    );
  }
}
