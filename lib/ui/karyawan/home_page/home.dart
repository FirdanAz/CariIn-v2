import 'package:cariin_v2/common/svg_assets.dart';
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
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.secondaryContainer),
            pinned: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20
                ),
                child: SvgPicture.asset(companyIcon,width: 28, color: color.tertiary),
              )
            ],
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 10
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    foregroundImage: AssetImage('assets/local/firdan.jpeg'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    const Text(
                      'Hai, Dadang',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      'Tap untuk mengubah profil',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 14
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(
                top: 10
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: color.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30
                        ),
                        child: SvgPicture.asset(filterIcon, height: 30,),
                      ),
                      Container(
                        width: 250,
                        margin: EdgeInsets.only(
                          top: 5
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Apakah hasilnya kurang relevan?',
                              style: GoogleFonts.outfit(
                                  color: color.onSecondaryContainer,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              )
                            ),
                            Text(
                              'Update minat dan preferensi usaha anda untuk rekomendasi yang lebih akurat.',
                              style: GoogleFonts.outfit(
                                color: color.onSecondaryContainer,
                                fontSize: 13
                              )
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Perbarui Sekarang',
                              style: GoogleFonts.outfit(
                                color: color.secondary,
                                fontWeight: FontWeight.w500,
                                fontSize: 14
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Pekerja Siap Direkurt',
                          style: GoogleFonts.outfit(
                              color: color.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          )
                      ),
                      Text(
                          'Pilih dan kirim undangan rekurt',
                          style: GoogleFonts.outfit(
                              color: color.onSecondaryContainer.withOpacity(0.4),
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          )
                      ),
                    ],
                  ),
                  Text(
                      'Lebih banyak',
                      style: GoogleFonts.outfit(
                          color: color.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                      )
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5
                ),
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 160,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage('assets/local/firdan.jpeg'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10,
                                  top: 10
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kalam',
                                    style: GoogleFonts.outfit(
                                        color: color.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Pria, 99 Tahun',
                                    style: GoogleFonts.outfit(
                                        color: color.black.withOpacity(0.5),
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Kabupaten Kudus',
                                    style: GoogleFonts.outfit(
                                        color: color.black.withOpacity(0.5),
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Programmer',
                                    style: GoogleFonts.outfit(
                                        color: color.secondary,
                                        fontSize: 15
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        width: 160,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage('assets/local/firdan.jpeg'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10,
                                  top: 10
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kalam',
                                    style: GoogleFonts.outfit(
                                        color: color.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Pria, 99 Tahun',
                                    style: GoogleFonts.outfit(
                                        color: color.black.withOpacity(0.5),
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Kabupaten Kudus',
                                    style: GoogleFonts.outfit(
                                        color: color.black.withOpacity(0.5),
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Programmer',
                                    style: GoogleFonts.outfit(
                                        color: color.secondary,
                                        fontSize: 15
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        width: 160,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage('assets/local/firdan.jpeg'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10,
                                  top: 10
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kalam',
                                    style: GoogleFonts.outfit(
                                        color: color.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Pria, 99 Tahun',
                                    style: GoogleFonts.outfit(
                                        color: color.black.withOpacity(0.5),
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Kabupaten Kudus',
                                    style: GoogleFonts.outfit(
                                        color: color.black.withOpacity(0.5),
                                        fontSize: 14
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Programmer',
                                    style: GoogleFonts.outfit(
                                        color: color.secondary,
                                        fontSize: 15
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(
                  top: 20,
                  left: 15,
                  right: 15
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Pekerjaan Disekitarmu',
                          style: GoogleFonts.outfit(
                              color: color.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          )
                      ),
                      Text(
                          'Temukan Lowongan Terdekat',
                          style: GoogleFonts.outfit(
                              color: color.onSecondaryContainer.withOpacity(0.4),
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          )
                      ),
                    ],
                  ),
                  Text(
                      'Lebih banyak',
                      style: GoogleFonts.outfit(
                          color: color.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                      )
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 140,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          top: 20,
                          left: 15,
                          right: 15
                      ),
                      decoration: BoxDecoration(
                        color: color.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Front End Web Developer',
                              style: GoogleFonts.outfit(
                                  color: color.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  'Pengalaman',
                                  style: GoogleFonts.outfit(
                                      color: color.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 5,),
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: color.black.withOpacity(0.5),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  '1 - 3 Tahun',
                                  style: GoogleFonts.outfit(
                                      color: color.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Front End',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Ui/Ux Designer',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Hacker',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 7,
                                  left: 2
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 4,
                                    margin: EdgeInsets.only(
                                        right: 10
                                    ),
                                    decoration: BoxDecoration(
                                        color: color.tertiary.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(2)
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pt. Muria Jaya',
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w600,
                                            color: color.tertiary.withOpacity(0.8)
                                        ),
                                      ),
                                      Text(
                                        'Surabaya, Indonesia',
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w500,
                                            color: color.tertiary.withOpacity(0.8)
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          left: 15,
                          right: 15
                      ),
                      decoration: BoxDecoration(
                        color: color.secondary,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '2 Jam yang lalu',
                              style: GoogleFonts.outfit(
                                  color: color.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                              )
                          ),
                          SizedBox(width: 13,)
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 140,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          top: 20,
                          left: 15,
                          right: 15
                      ),
                      decoration: BoxDecoration(
                        color: color.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Front End Web Developer',
                              style: GoogleFonts.outfit(
                                  color: color.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  'Pengalaman',
                                  style: GoogleFonts.outfit(
                                      color: color.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 5,),
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: color.black.withOpacity(0.5),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  '1 - 3 Tahun',
                                  style: GoogleFonts.outfit(
                                      color: color.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Front End',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Ui/Ux Designer',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Hacker',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 7,
                                  left: 2
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 4,
                                    margin: EdgeInsets.only(
                                        right: 10
                                    ),
                                    decoration: BoxDecoration(
                                        color: color.tertiary.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(2)
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pt. Muria Jaya',
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w600,
                                            color: color.tertiary.withOpacity(0.8)
                                        ),
                                      ),
                                      Text(
                                        'Surabaya, Indonesia',
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w500,
                                            color: color.tertiary.withOpacity(0.8)
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          left: 15,
                          right: 15
                      ),
                      decoration: BoxDecoration(
                        color: color.secondary,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '2 Jam yang lalu',
                              style: GoogleFonts.outfit(
                                  color: color.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                              )
                          ),
                          SizedBox(width: 13,)
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 140,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          top: 20,
                          left: 15,
                          right: 15
                      ),
                      decoration: BoxDecoration(
                        color: color.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Front End Web Developer',
                              style: GoogleFonts.outfit(
                                  color: color.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  'Pengalaman',
                                  style: GoogleFonts.outfit(
                                      color: color.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 5,),
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: color.black.withOpacity(0.5),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  '1 - 3 Tahun',
                                  style: GoogleFonts.outfit(
                                      color: color.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Front End',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Ui/Ux Designer',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 7
                                  ),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    'Hacker',
                                    style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 7,
                                  left: 2
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 4,
                                    margin: EdgeInsets.only(
                                        right: 10
                                    ),
                                    decoration: BoxDecoration(
                                        color: color.tertiary.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(2)
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pt. Muria Jaya',
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w600,
                                            color: color.tertiary.withOpacity(0.8)
                                        ),
                                      ),
                                      Text(
                                        'Surabaya, Indonesia',
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w500,
                                            color: color.tertiary.withOpacity(0.8)
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          left: 15,
                          right: 15
                      ),
                      decoration: BoxDecoration(
                        color: color.secondary,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '2 Jam yang lalu',
                              style: GoogleFonts.outfit(
                                  color: color.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                              )
                          ),
                          SizedBox(width: 13,)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
