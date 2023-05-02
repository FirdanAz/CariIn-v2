import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/home_page/home.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _pageIndex = 0;
  final List<Widget> _page = const [
    HomePage(),
    Center(child: Text("Car")),
    Center(child: Text("Money")),
    Center(child: Text("Profil")),
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
              icon: Icon(
                Icons.home_outlined,
                color: _pageIndex == 0
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),
              ),
              label: "Home"),
          NavigationDestination(
              icon: Icon(
                Icons.car_crash,
                color: _pageIndex == 1
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),
              ),
              label: "Car"),
          NavigationDestination(
              icon: Icon(
                Icons.money,
                color: _pageIndex == 2
                    ? color.white
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),
              ),
              label: "Money"),
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
    );
  }
}
