import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/lowongan/chat_page/chat.dart';
import 'package:cariin_v2/ui/lowongan/home_page/home.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamaran.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/Profile.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _pageIndex = 0;
  final List<Widget> _page = [
    const HomePage(),
    LamaranPage(),
    const ChatPage(),
    const ProfilePage()
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar Aplikasi'),
        content: const Text('Yakin untuk keluar dari aplikasi?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _page[_pageIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _pageIndex,
          height: 73,
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.home_filled,
                  color: _pageIndex == 0
                      ? color.white
                      : Theme.of(context).iconTheme.color!.withOpacity(0.5),
                ),
                label: "Beranda"),
            NavigationDestination(
                icon: Icon(
                  Icons.work,
                  color: _pageIndex == 1
                      ? color.white
                      : Theme.of(context).iconTheme.color!.withOpacity(0.5),
                ),
                label: "Pekerjaan"),
            NavigationDestination(
                icon: Icon(
                  Icons.message,
                  color: _pageIndex == 2
                      ? color.white
                      : Theme.of(context).iconTheme.color!.withOpacity(0.5),
                ),
                label: "Pesan"),
            NavigationDestination(
                icon: Icon(
                  Icons.person,
                  color: _pageIndex == 3
                      ? color.white
                      : Theme.of(context).iconTheme.color!.withOpacity(0.5),
                ),
                label: "Profil"),
          ],
          onDestinationSelected: (value) => setState(() {
            _pageIndex = value;
          }),
        ),
      ),
    );
  }
}
