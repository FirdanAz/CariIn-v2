import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_function.dart';
import 'package:cariin_v2/ui/lowongan/home_page/all_categories.dart';
import 'package:cariin_v2/ui/lowongan/notification/notification_lowongan.dart';
import 'package:cariin_v2/ui/widget/home_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 95,
            pinned: false,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: color.onPrimary),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 35, top: 30),
                child: InkWell(
                  onTap: () => Navigate.push(context, const NotificationPage()),
                  child: const Icon(Icons.notifications),
                ),
              ),
            ],
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 35, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Semangat Kerja',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Muhammad Firdan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: color.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Container(
                width: double.maxFinite,
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: color.secondaryContainer,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'UI/UX Designer',
                      style: TextStyle(fontSize: 17),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: color.secondary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.search,
                        color: color.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kategori Pekerjaan',
                          style: GoogleFonts.outfit(
                              color: color.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(),));
                    },
                    child: Text('Lebih banyak',
                        style: GoogleFonts.outfit(
                            color: color.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  width: double.maxFinite,
                  height: 108,
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CategoryCard('Code', AppAssets.codeIcon, context),
                        CategoryCard('Design', AppAssets.designIcon, context),
                        CategoryCard('Teacher', AppAssets.teacherIcon, context),
                        CategoryCard('Medical', AppAssets.medicalIcon, context),
                      ],
                    ),
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pekerjaan',
                          style: GoogleFonts.outfit(
                              color: color.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ],
                  ),
                  Text('Lebih banyak',
                      style: GoogleFonts.outfit(
                          color: color.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ],
              ),
            ),
          ),
          const JobListCard()
        ],
      ),
    );
  }
}

Widget CategoryCard(String title, String assetsName, BuildContext context) {
  var color = AppColor.theme(Theme.of(context).brightness);
  return Container(
    height: 110,
    constraints: const BoxConstraints(minWidth: 90),
    padding: const EdgeInsets.all(15),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: 4.5),
    decoration: BoxDecoration(
        color: color.primary, borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 22,
            backgroundColor: color.white,
            child: SvgPicture.asset(
              assetsName,
              color: color.primary,
            )),
        const SizedBox(
          height: 9.5,
        ),
        Text(
          title.toString(),
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}
