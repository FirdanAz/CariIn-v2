import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/list_karyawan/karyawan_list_all.dart';
import 'package:cariin_v2/ui/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_color.dart';

class HomePageKaryawan extends StatefulWidget {
  const HomePageKaryawan({Key? key}) : super(key: key);

  @override
  State<HomePageKaryawan> createState() => _HomePageKaryawanState();
}

class _HomePageKaryawanState extends State<HomePageKaryawan> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 95,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: color.secondaryContainer),
            pinned: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(AppAssets.companyIcon,
                    width: 28, color: color.tertiary),
              )
            ],
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: CircleAvatar(
                    radius: 25,
                    foregroundImage: AssetImage(AppAssets.firdanImg),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Hai, Dadang',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'Tap untuk mengubah profil',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4), fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          ),
          const HomeCard(),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pekerja Siap Direkurt',
                          style: GoogleFonts.outfit(
                              color: color.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text('Pilih dan kirim undangan rekurt',
                          style: GoogleFonts.outfit(
                              color:
                                  color.onSecondaryContainer.withOpacity(0.4),
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ListKaryawan(),));
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
          const WorkerCard(),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pekerjaan Disekitarmu',
                          style: GoogleFonts.outfit(
                              color: color.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text('Temukan Lowongan Terdekat',
                          style: GoogleFonts.outfit(
                              color:
                                  color.onSecondaryContainer.withOpacity(0.4),
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
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
