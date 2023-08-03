// ignore_for_file: deprecated_member_use

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/karyawan/home_page/home.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/kandidat.dart';
import 'package:cariin_v2/ui/karyawan/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../karyawan/lowongan/lowongan.dart';

class KaryawanBottomNavigation extends StatefulWidget {
  KaryawanBottomNavigation({super.key, required this.indexs});
  int indexs;

  @override
  State<KaryawanBottomNavigation> createState() => _KaryawanBottomNavigationState();
}

class _KaryawanBottomNavigationState extends State<KaryawanBottomNavigation> {
  final List<Widget> _page = [
    const HomePageKaryawan(),
    const KandidatPage(),
    const LowonganPage(),
    NotificationPage()
  ];

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    setState(() {
      widget.indexs = widget.indexs;
    });
    return Scaffold(
      body: _page[widget.indexs],
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.indexs,
        height: 73,
        destinations: [
          NavigationDestination(
              icon: SvgPicture.asset(AppAssets.homeIcon,
                color: widget.indexs == 0
                  ? color.white
                  : Theme.of(context).iconTheme.color!.withOpacity(0.5),),
              label: "Beranda"
          ),
          NavigationDestination(
              icon: SvgPicture.asset(AppAssets.kandidatIcon,
                color: widget.indexs == 1
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),),
              label: "Kandidat"
          ),
          NavigationDestination(
              icon: SvgPicture.asset(AppAssets.companyIcon,
                color: widget.indexs == 2
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),),
              label: "Lowongan"
          ),
          NavigationDestination(
              icon: SvgPicture.asset(AppAssets.contactIcon,
                color: widget.indexs == 3
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),),
              label: "Kontak"
          ),
        ],
        onDestinationSelected: (value) => setState(() {
          widget.indexs = value;
        }),
      ),
    );
  }
}
