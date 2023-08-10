// ignore_for_file: deprecated_member_use

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/detail_lowongan/page.dart';
import 'package:cariin_v2/ui/karyawan/detail_profile/profil_comapny.dart';
import 'package:cariin_v2/ui/karyawan/form/lowongan/create_lowongan.dart';
import 'package:cariin_v2/ui/karyawan/list_karyawan/karyawan_list_all.dart';
import 'package:cariin_v2/ui/widget/home_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';
import '../../../model/company/job_company_model.dart';
import '../../../model/company/list_worker_model.dart';
import '../../../model/company/profil_company_model.dart';
import '../../../service/api_service.dart';
import '../../widget/shimmer_widget.dart';
import '../auth/login.dart';

class HomePageKaryawan extends StatefulWidget {
  const HomePageKaryawan({Key? key}) : super(key: key);

  @override
  State<HomePageKaryawan> createState() => _HomePageKaryawanState();
}

class _HomePageKaryawanState extends State<HomePageKaryawan> {
  //sementara
  JobCompanyModel? acceptedJobCompany;
  ProfilCompanyModel? profilCompanyModel;
  WorkerListModel? workerListModel;
  bool _isLoad = false;

  getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    JobCompanyModel allJob =
        await ApiService().jobsCompany(true, 'terverifikasi');
    ProfilCompanyModel profilCompany = await ApiService().ProfilCompany();
    WorkerListModel workerList = await ApiService().ListWorkerCompany();
    setState(() {
      acceptedJobCompany = allJob;
      profilCompanyModel = profilCompany;
      workerListModel = workerList;
    });

    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

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
                onPressed: () async => await PublicFunction.removeToken('token')
                    .then((value) => PublicFunction.navigatorPushAndRemoved(
                        context, const LoginKaryawanPage())),
                child: const Text("Yes", style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      backgroundColor: color.surface,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getdata();
          });
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 95,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: color.primaryContainer),
              pinned: false,
              actions: [
                InkWell(
                  onTap: () {
                    _logOut();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(AppAssets.companyIcon,
                        width: 28, color: color.primary),
                  ),
                )
              ],
              title: _isLoad
                  ? const ShimmerHomeAppBar()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: CircleAvatar(
                            radius: 25,
                            foregroundImage: NetworkImage(
                                'https://cariin.my.id/storage/${profilCompanyModel!.data!.profileImage}'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => PublicFunction.navigatorPush(
                              context, const ProfilCompanyPage()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              _isLoad
                                  ? Text('Hai user',
                                      style: TextStyle(
                                          color: color.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))
                                  : Row(
                                      children: [
                                        Text(
                                          'Hai, ${profilCompanyModel!.data!.name}',
                                          style: TextStyle(
                                              color: color.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                              Text(
                                'Tap untuk mengubah profil',
                                style: TextStyle(
                                    color: color.black.withOpacity(0.4),
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
            _isLoad
                ? const SliverToBoxAdapter(child: ShimmerHomeCard())
                : const HomeCard(),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListKaryawan(),
                            ));
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
            SliverToBoxAdapter(
                child: _isLoad
                    ? const ShimmerWorkerList()
                    : Container(
                        height: 250,
                        margin: const EdgeInsets.only(top: 15),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: workerListModel!.data!.length,
                          padding: const EdgeInsets.only(left: 10),
                          itemBuilder: (context, index) {
                            var data = workerListModel!.data![index];
                            return WorkerCards(
                              id: data.id!,
                              name: data.username.toString(),
                              gender: data.gender.toString(),
                              age: data.age.toString(),
                              location: data.address.toString(),
                              selection: data.interested.toString(),
                              urlProfileImage: data.profilImage.toString(),
                            )
                            ;
                          },
                        ))),
            SliverToBoxAdapter(
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pekerjaan dari anda',
                            style: GoogleFonts.outfit(
                                color: color.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                        Text('Lowongan yang terverifikasi',
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
            _isLoad
                ? const SliverToBoxAdapter(
                    child: ShimmerJobCard(),
                  )
                : acceptedJobCompany!.data!.isEmpty
                    ? SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 80,
                              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                              decoration: BoxDecoration(
                                color: color.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.primaryContainer.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(child: Text('Belum ada lowongan'),),
                            ),
                            InkWell(
                              onTap: () {
                                PublicFunction.navigatorPush(context, const CreateLowonganPage());
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 50,
                                color: color.primaryContainer,
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Center(child: Text('Buat Lowongan', style: TextStyle(color: color.primary),)),
                              ),
                            )
                          ],
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: acceptedJobCompany!.data!.length,
                            (context, index) {
                          var data = acceptedJobCompany!.data![index];
                          int count;
                          if (data.tags!.length == 1) {
                            count = 1;
                          } else if (data.tags!.length == 2) {
                            count = 2;
                          } else {
                            count = 3;
                          }
                          DateTime? date =
                              DateTime.parse(data.createdAt.toString());
                          if (kDebugMode) {
                            print(date);
                          }
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompanyJobDetailPage(
                                      id: acceptedJobCompany!.data![index].id!
                                          .toInt()),
                                )),
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  width: double.maxFinite,
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    color: color.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.primaryContainer
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            2, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.title.toString(),
                                          style: TextStyle(
                                              color: color.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Pengalaman',
                                              style: TextStyle(
                                                  color: color.black
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                                  color.black.withOpacity(0.5),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '1 - 3 Tahun',
                                              style: TextStyle(
                                                  color: color.black
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: count,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, indexs) {
                                              return Center(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 3,
                                                      horizontal: 5),
                                                  margin: const EdgeInsets.only(
                                                      right: 7),
                                                  decoration: BoxDecoration(
                                                      color: color
                                                          .primaryContainer,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    '${data.tags![indexs].name}',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 7, left: 2, bottom: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 4,
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                    color: color.tertiary
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.company!.name
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: color.tertiary
                                                            .withOpacity(0.8)),
                                                  ),
                                                  Text(
                                                    data.company!.location
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    color: color.primary,
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.primaryContainer
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            2, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(GetTimeAgo.parse(date, locale: 'id'),
                                          style: TextStyle(
                                              color: color.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12)),
                                      const SizedBox(
                                        width: 13,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )
          ],
        ),
      ),
    );
  }
}
