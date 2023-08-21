// ignore_for_file: deprecated_member_use, use_build_context_synchronously, non_constant_identifier_names

import 'dart:io';

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/karyawan/detail_lowongan/page.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar_process_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pdf/pdf.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../model/company/detail_pelamar_model.dart';
import '../../../../model/company/profil_company_model.dart';
import '../../../../service/api_service.dart';
import '../../../../service/firebase_api_service.dart';

class DetailPelamarPage extends StatefulWidget {
  DetailPelamarPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailPelamarPage> createState() => _DetailPelamarPageState();
}

class _DetailPelamarPageState extends State<DetailPelamarPage> {
  DetailPelamarModel? detailPelamarModel;
  ProfilCompanyModel? profilCompanyModel;
  bool _isLoad = false;
  PdfDocument? document;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? workerDeviceToken;

  getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    DetailPelamarModel detail = await ApiService().detailPelamar(widget.id, 'company');
    ProfilCompanyModel profilCompany = await ApiService().ProfilCompany();
    var token =
        await EditService().getWorkerDevice(detail.data!.worker!.id.toString());
    setState(() {
      detailPelamarModel = detail;
      profilCompanyModel = profilCompany;
      workerDeviceToken = token;
    });
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
    return _isLoad
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: color.primaryContainer),
                  title: Text(
                    'Detail Pelamar',
                    style: TextStyle(
                        color: color.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w600),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.maxFinite,
                    height: 140,
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(AppAssets.firdanImg),
                            radius: 60,
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 120,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: color.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${detailPelamarModel!.data!.worker!.username}',
                                          style: TextStyle(
                                              color: color.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          '${detailPelamarModel!.data!.worker!.age} Tahun',
                                          style: TextStyle(
                                              color: color.black, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Kudus, Jawa Tengah, ',
                                    style: TextStyle(
                                        color: color.black, fontSize: 14),
                                  ),
                                  Text(
                                    'Indonesia',
                                    style: TextStyle(
                                        color: color.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 5),
                                    margin: const EdgeInsets.only(right: 7),
                                    decoration: BoxDecoration(
                                        color: color.primary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Ui/Ux Designer',
                                      style: TextStyle(
                                          fontSize: 12, color: color.white),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 5),
                                    margin: const EdgeInsets.only(right: 7),
                                    decoration: BoxDecoration(
                                        color: color.primary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Front End',
                                      style: TextStyle(
                                          fontSize: 12, color: color.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          PublicFunction.navigatorPush(
                              context,
                              CompanyJobDetailPage(
                                  id: detailPelamarModel!.data!.job!.id!));
                        },
                        child: Row(
                          children: [
                            Text(
                              'Melamar di lowongan ',
                            ),
                            Text(
                              '${detailPelamarModel!.data!.job!.title}',
                              style: TextStyle(
                                  color: color.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          File file = await ApiService().loadPdf(
                              'https://cariin.my.id/storage/${detailPelamarModel!.data!.cvFile}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CvPage(filePath: file.path),
                              ));
                        },
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        child: Container(
                          width: double.maxFinite,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(),
                          child: Card(
                            color: color.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.cvIcon,
                                        height: 25,
                                        color: color.primary,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Curriculum Vitae ',
                                        style: TextStyle(color: color.black),
                                      ),
                                      Text(
                                        detailPelamarModel!
                                            .data!.worker!.username!,
                                        style: TextStyle(color: color.primary),
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: color.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ProfileCard(
                          context,
                          AppAssets.activityIcon,
                          'Deskripsi Lamaran',
                          '${detailPelamarModel!.data!.description}'),
                      ProfileCard(
                          context,
                          AppAssets.genderIcon,
                          'Jenis Kelamin',
                          '${detailPelamarModel!.data!.worker!.gender}'),
                      detailPelamarModel!.data!.confirmedStatus == 'ditolak'
                          ? Container(
                              height: 100,
                              width: double.maxFinite,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: color.error.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  'Pengguna ini sudah anda tolak!',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              color: color.white,
              child: InkWell(
                onTap: () async {
                  if (detailPelamarModel!.data!.confirmedStatus == 'direview') {
                    bool isSuccess = await ApiService().defineConfirmation(
                        context,
                        'wawancara',
                        '${detailPelamarModel!.data!.id}');
                    if (isSuccess == true) {
                      await FirebaseApiService().firebaseSendNotif(
                          workerDeviceToken!,
                          'Lamaran masuk sesi Wawancara',
                          'Selamat, lamaranmu sudah mencapai sesi wawancara, tunggu informasi dari perusahaan melalui email',
                          'https://cariin.my.id/storage/${profilCompanyModel!.data!.profileImage}');
                      setState(() {
                        getdata();
                      });
                      await _firestore
                          .collection('users')
                          .doc(
                              '${detailPelamarModel!.data!.worker!.id}_${detailPelamarModel!.data!.job!.id}')
                          .set({
                        'uid': detailPelamarModel!.data!..worker!.id,
                        'userName': detailPelamarModel!.data!.worker!.username
                      });
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PublicFunction.showDialog(
                              context, 'Undangan Terkirim');
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PublicFunction.showDialog(
                              context, 'Ups, Ada kesalahan :(');
                        },
                      );
                    }
                  } else if (detailPelamarModel!.data!.confirmedStatus ==
                      'wawancara') {
                    bool isSuccess = await ApiService().defineConfirmation(
                        context, 'diterima', '${detailPelamarModel!.data!.id}');
                    if (isSuccess == true) {
                      await FirebaseApiService().firebaseSendNotif(
                          workerDeviceToken!,
                          'Lamaranmu Diterima!!',
                          'Selamat, lamaran pekerjaan ${detailPelamarModel!.data!.job!.title} di perusahaan ${detailPelamarModel!.data!.job!.company!.name} Sudah diterima oleh perusahaan!',
                          'https://cariin.my.id/storage/${profilCompanyModel!.data!.profileImage}');
                      await _firestore
                          .collection('users')
                          .doc(
                              '${detailPelamarModel!.data!.worker!.id}_${detailPelamarModel!.data!.job!.id}')
                          .set({
                        'uid': detailPelamarModel!.data!.id,
                        'userName': detailPelamarModel!.data!.worker!.username
                      }, SetOptions(merge: true));
                      setState(() {
                        getdata();
                      });
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PublicFunction.showDialog(
                              context, 'Pelamar Diterima');
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PublicFunction.showDialog(
                              context, 'Ups, Ada kesalahan :(');
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PublicFunction.showDialog(
                            context, 'Segera Hadir');
                      },
                    );
                  }
                },
                hoverColor: Colors.black,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color:
                                    detailPelamarModel!.data!.confirmedStatus ==
                                            'ditolak'
                                        ? color.primary.withOpacity(0.4)
                                        : color.primary,
                                borderRadius: BorderRadius.circular(12)),
                            child: detailPelamarModel!.data!.confirmedStatus ==
                                    'diterima'
                                ? Text(
                                    'Mulai Kontak',
                                    style: TextStyle(
                                        color: color.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : detailPelamarModel!.data!.confirmedStatus ==
                                        'ditolak'
                                    ? Text(
                                        'Terima Pelamar',
                                        style: TextStyle(
                                            color: color.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : detailPelamarModel!
                                                .data!.confirmedStatus ==
                                            'direview'
                                        ? Text(
                                            'Mulai Wawancara',
                                            style: TextStyle(
                                                color: color.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : detailPelamarModel!
                                                    .data!.confirmedStatus ==
                                                'wawancara'
                                            ? Text(
                                                'Terima Pelamar',
                                                style: TextStyle(
                                                    color: color.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                'Undang Wawancara',
                                                style: TextStyle(
                                                    color: color.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                      ),
                      detailPelamarModel!.data!.confirmedStatus == 'direview'
                          ? Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Tolak Lamaran ${detailPelamarModel!.data!.worker!.username}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text("Batal"),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                bool isSuccess = await ApiService()
                                                    .defineConfirmation(
                                                        context,
                                                        'ditolak',
                                                        '${detailPelamarModel!.data!.id}');
                                                if (isSuccess == true) {
                                                  await FirebaseApiService().firebaseSendNotif(
                                                      workerDeviceToken!,
                                                      'Lamaranmu Ditolak!!',
                                                      'Sayang sekali, lamaran pekerjaan ${detailPelamarModel!.data!.job!.title} di perusahaan ${detailPelamarModel!.data!.job!.company!.name} Ditolak oleh perushaan',
                                                      'https://cariin.my.id/storage/${profilCompanyModel!.data!.profileImage}');
                                                  setState(() {
                                                    getdata();
                                                  });
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return PublicFunction
                                                          .showDialog(context,
                                                              'Lamaran Ditolak');
                                                    },
                                                  );
                                                }
                                              },
                                              child: Text(
                                                "Iya",
                                                style: TextStyle(
                                                    color: color.error),
                                              )),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.maxFinite,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: color.primaryContainer,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Tolak Lamaran',
                                    style: TextStyle(
                                        color: color.error,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      detailPelamarModel!.data!.confirmedStatus == 'wawancara'
                          ? Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Tolak Lamaran ${detailPelamarModel!.data!.worker!.username}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text("Batal"),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                bool isSuccess = await ApiService()
                                                    .defineConfirmation(
                                                        context,
                                                        'ditolak',
                                                        '${detailPelamarModel!.data!.id}');
                                                if (isSuccess == true) {
                                                  setState(() {
                                                    getdata();
                                                  });
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return PublicFunction
                                                          .showDialog(context,
                                                              'Lamaran Ditolak');
                                                    },
                                                  );
                                                }
                                              },
                                              child: Text(
                                                "Iya",
                                                style: TextStyle(
                                                    color: color.error),
                                              )),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.maxFinite,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: color.primaryContainer,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Tolak Lamaran',
                                    style: TextStyle(
                                        color: color.error,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

Widget ProfileCard(
    BuildContext context, String image, String title, String desc) {
  var color = AppColor.theme(Theme.of(context).brightness);

  return Container(
    width: double.maxFinite,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Card(
      color: color.white,
      elevation: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            margin:
                const EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 40),
            child: Stack(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25, top: 25),
                  child: SvgPicture.asset(
                    image,
                    color: color.primary,
                    width: 25,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: color.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 13,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      desc,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: color.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
