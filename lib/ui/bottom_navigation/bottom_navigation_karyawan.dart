import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/karyawan/home_page/home.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/kandidat.dart';
import 'package:cariin_v2/ui/karyawan/notification/notification.dart';
import 'package:cariin_v2/ui/karyawan/wawancara/wawancara.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KaryawanBottomNavigation extends StatefulWidget {
  const KaryawanBottomNavigation({super.key});

  @override
  State<KaryawanBottomNavigation> createState() => _KaryawanBottomNavigationState();
}

class _KaryawanBottomNavigationState extends State<KaryawanBottomNavigation> {
  int _pageIndex = 0;
  final List<Widget> _page = [
    HomePageKaryawan(),
    KandidatPage(),
    WawancaraPage(),
    NotificationPage()
  ];

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: _page[_pageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _pageIndex,
        height: 73,
        destinations: [
          NavigationDestination(
              icon: SvgPicture.asset(AppAssets.homeIcon,
                color: _pageIndex == 0
                  ? color.white
                  : Theme.of(context).iconTheme.color!.withOpacity(0.5),),
              label: "Beranda"
          ),
          NavigationDestination(
              icon: SvgPicture.asset(AppAssets.kandidatIcon,
                color: _pageIndex == 1
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),),
              label: "Kandidat"
          ),
          NavigationDestination(
              icon: SvgPicture.asset(AppAssets.companyIcon,
                color: _pageIndex == 2
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),),
              label: "Wawancara"
          ),
          NavigationDestination(
              icon: SvgPicture.asset(AppAssets.contactIcon,
                color: _pageIndex == 3
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),),
              label: "Kontak"
          ),
        ],
        onDestinationSelected: (value) => setState(() {
          _pageIndex = value;
        }),
      ),
    );
  }
}
