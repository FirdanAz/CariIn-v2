import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/model/accepted_job_model.dart';
import 'package:cariin_v2/ui/karyawan/list_karyawan/karyawan_list_all.dart';
import 'package:cariin_v2/ui/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';
import '../../../model/all_job_company_model.dart';
import '../../../service/api_service.dart';
import '../../lowongan/detail_lowongan/page.dart';
import '../auth/login.dart';

class HomePageKaryawan extends StatefulWidget {
  const HomePageKaryawan({Key? key}) : super(key: key);

  @override
  State<HomePageKaryawan> createState() => _HomePageKaryawanState();
}

class _HomePageKaryawanState extends State<HomePageKaryawan> {
  //sementara
  AcceptedJobCompany? acceptedJobCompany;
  bool _isLoad = false;

  void _logOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "Ingin keluar dari akun ini ?",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("No")),
            TextButton(
                onPressed: () async => await PublicFunction.removeToken('tokenCompany')
                    .then((value) => PublicFunction.navigatorPushAndRemoved(
                    context, const LoginPage())),
                child: const Text("Yes", style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }

  getdata() async {
    _isLoad = true;
    AcceptedJobCompany allJob = await ApiService().AcceptedJob();
    setState(() {
      acceptedJobCompany = allJob;
    });
    print(allJob);
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      backgroundColor: color.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 95,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: color.primaryContainer),
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
                InkWell(
                  onTap: () => _logOut(),
                  child: Column(
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
                  ),
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
                              color: color.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text('Pilih dan kirim undangan rekurt',
                          style: GoogleFonts.outfit(
                              color:
                                  color.onPrimaryContainer.withOpacity(0.4),
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
                            color: color.primary,
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
                              color: color.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text('Temukan Lowongan Terdekat',
                          style: GoogleFonts.outfit(
                              color:
                                  color.onPrimaryContainer.withOpacity(0.4),
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ],
                  ),
                  Text('Lebih banyak',
                      style: GoogleFonts.outfit(
                          color: color.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ],
              ),
            ),
          ),
          //sementara
          _isLoad ? SliverToBoxAdapter() : SliverList(
            delegate: SliverChildBuilderDelegate(childCount: acceptedJobCompany!.data!.length,(context, index) {
              var data = acceptedJobCompany!.data![index];
              return  InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailPage(),)),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
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
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title.toString(),
                              style: TextStyle(
                                  color: color.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Pengalaman',
                                  style: TextStyle(
                                      color: color.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: color.black.withOpacity(0.5),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '1 - 3 Tahun',
                                  style: TextStyle(
                                      color: color.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: color.primaryContainer,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Front End',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: color.primaryContainer,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Ui/Ux Designer',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: color.primaryContainer,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Hacker',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7, left: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 4,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: color.tertiary.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(2)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.city.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: color.tertiary
                                                .withOpacity(0.8)),
                                      ),
                                      Text(
                                        data.company!.location.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: color.tertiary
                                                .withOpacity(0.8)),
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
                      margin: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: color.primary,
                        borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20)),
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
                          Text('2 Jam yang lalu',
                              style: TextStyle(
                                  color: color.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                          SizedBox(
                            width: 13,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
