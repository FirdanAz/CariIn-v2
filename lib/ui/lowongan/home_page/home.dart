// ignore_for_file: deprecated_member_use, non_constant_identifier_names, use_build_context_synchronously

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_function.dart';
import 'package:cariin_v2/model/worker/all_job_worker_model.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/karyawan/form/fill_data_worker/fill_data.dart';
import 'package:cariin_v2/ui/lowongan/detail_lowongan/page.dart';
import 'package:cariin_v2/ui/lowongan/home_page/all_categories.dart';
import 'package:cariin_v2/ui/lowongan/home_page/search/custom_search.dart';
import 'package:cariin_v2/ui/lowongan/home_page/search/search_page.dart';
import 'package:cariin_v2/ui/lowongan/home_page/search/search_page_result.dart';
import 'package:cariin_v2/ui/lowongan/notification/notification_lowongan.dart';
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_color.dart';
import '../../../model/worker/worker_profile_model.dart';
import '../../../service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllJobWorkerModel? allJobWorkerModel;
  bool _isLoad = false;
  ProfileWorkerModel? profileWorkerModel;

  getData() async {
    _isLoad = true;
    final token = await PublicFunction.getToken('worker');
    await ApiService().RefreshToken('worker', token);
    AllJobWorkerModel allJob = await ApiService().AllJobsWorker();
    ProfileWorkerModel workerModel = await ApiService().getWorkerProfile();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    //upload device token
    await DataService().editMyDeviceToken(fcmToken!, 'worker');
    setState(() {
      allJobWorkerModel = allJob;
      profileWorkerModel = workerModel;
    });

    if(workerModel.data!.profileImage == 'null'){
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text('Lengkapi Profilmu!', style: TextStyle(fontSize: 16, color: Colors.black),),
          actions: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('lengkapi datamu sekarang'),
                SizedBox(height: 20,)
              ],
            ),
            ElevatedButton(onPressed: () {
              PublicFunction.navigatorPush(context, const FillDataWorker());
            }, child: const Text('Lengkapi'))
          ],
        );
      },);
    }
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getData();
          });
        },
        child: CustomScrollView(
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
                    onTap: () =>
                        Navigate.push(context, const NotificationPage()),
                    child: _isLoad ? CustomShimmer(width: 30, height: 30, radius: 0) : const Icon(Icons.notifications),
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
                        _isLoad ? CustomShimmer(width: 130, height: 20, radius: 0) : const  Text(
                          'Semangat Kerja',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        _isLoad ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CustomShimmer(width: 180, height: 25, radius: 0),
                        ) : Text(
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
                child: _isLoad ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomShimmer(width: double.maxFinite, height: 70, radius: 10),
                ) :  InkWell(
                  onTap: () {
                    showSearch(context: context, delegate: CustomSearch());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                        _isLoad ? CustomShimmer(width: 150, height: 25, radius: 0) :
                        Text('Kategori Pekerjaan',
                            style: GoogleFonts.outfit(
                                color: color.onSecondaryContainer,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CategoryPage(),
                            ));
                      },
                      child: _isLoad ? CustomShimmer(width: 90, height: 20, radius: 0) :
                      Text('Lebih banyak',
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
                          const SizedBox(
                            width: 10,
                          ),
                          _isLoad ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.5),
                            child: CustomShimmer(width: 90, height: 110, radius: 10),
                          ) :
                          _isLoad ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.5),
                            child: CustomShimmer(width: 90, height: 110, radius: 10),
                          ): InkWell(
                              child: CategoryCard('Developer', AppAssets.codeIcon, context)),
                          _isLoad ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.5),
                            child: CustomShimmer(width: 90, height: 110, radius: 10),
                          ) : CategoryCard('Designer', AppAssets.designIcon, context),
                          _isLoad ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.5),
                            child: CustomShimmer(width: 90, height: 110, radius: 10),
                          ) : CategoryCard(
                              'Guru', AppAssets.teacherIcon, context),
                          _isLoad ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.5),
                            child: CustomShimmer(width: 90, height: 110, radius: 10),
                          ) : CategoryCard(
                              'Medis', AppAssets.medicalIcon, context),
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
                        _isLoad ? CustomShimmer(width: 100, height: 25, radius: 0) :
                        Text('Pekerjaan',
                            style: GoogleFonts.outfit(
                                color: color.onSecondaryContainer,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                      ],
                    ),
                    _isLoad ? CustomShimmer(width: 90, height: 20, radius: 0) :
                    Text('Lebih banyak',
                        style: GoogleFonts.outfit(
                            color: color.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                  ],
                ),
              ),
            ),
            _isLoad ? SliverToBoxAdapter(child: ShimmerJobCard(marginHorizon: 0),) : SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: allJobWorkerModel!.data!.length,
                      (context, index) {
                    var data = allJobWorkerModel!.data![index];
                    int count;
                    if (data.tags!.length == 1) {
                      count = 1;
                    } else if (data.tags!.length == 2) {
                      count = 2;
                    } else {
                      count = 3;
                    }
                    DateTime? date = DateTime.parse(data.createdAt.toString());
                    if (kDebugMode) {
                      print(date);
                    }
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailPage(
                                id: allJobWorkerModel!.data![index].id!.toInt()),
                          )),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: double.maxFinite,
                            margin:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: color.white,
                              boxShadow: [
                                BoxShadow(
                                  color: color.primaryContainer.withOpacity(0.5),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            color: color.black.withOpacity(0.6),
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
                                            color: color.black.withOpacity(0.6),
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            margin: const EdgeInsets.only(right: 7),
                                            decoration: BoxDecoration(
                                                color: color.primaryContainer,
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            child: Text(
                                              '${data.tags![indexs].name}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 4,
                                          margin: const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              color:
                                              color.tertiary.withOpacity(0.5),
                                              borderRadius:
                                              BorderRadius.circular(2)),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.company!.name.toString(),
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
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: color.primary,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: color.primaryContainer.withOpacity(0.5),
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
            ),
          ],
        ),
      ),
    );
  }
}

Widget CategoryCard(String title, String assetsName, BuildContext context) {
  var color = AppColor.theme(Theme.of(context).brightness);
  return InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultPage(value: title),)),
    child: Container(
      height: 110,
      constraints: const BoxConstraints(minWidth: 90),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 4.5),
      decoration: BoxDecoration(
          color: color.primaryContainer, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 22,
              backgroundColor: color.primary,
              child: SvgPicture.asset(
                assetsName,
                color: color.white,
              )),
          const SizedBox(
            height: 9.5,
          ),
          Text(
            title.toString(),
            style: TextStyle(
              fontSize: 15,
              color: color.primary,
            ),
          )
        ],
      ),
    ),
  );
}
