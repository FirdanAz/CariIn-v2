// ignore_for_file: sized_box_for_whitespace

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/model/worker/worker_profile_model.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/Keterampilan.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/Pencapaian.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/Pendidikan.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/profile_settings.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/Pengalaman.dart';
import 'package:cariin_v2/ui/view_image/view_image.dart';
import 'package:cariin_v2/ui/widget/chip_tab_bar.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../../model/worker/worker_model.dart';
import '../../../service/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);
  WorkerModel? workerModels;
  ProfileWorkerModel? profileWorkerModel;
  bool _isLoad = false;

  final List<Widget> _tabView = const [
    PengalamanPage(),
    PendidikanPage(),
    KeterampilanPage(),
    PencapaianPage(),
  ];

  getdata() async {
    _isLoad = true;
    WorkerModel workerData = await ApiService().getWorker();
    ProfileWorkerModel workerModel = await ApiService().getWorkerProfile();
    setState(() {
      workerModels = workerData;
      profileWorkerModel = workerModel;
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
                  toolbarHeight: 320,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 230,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: Image.asset(
                              AppAssets.backImageProfil,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 50, right: 30),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileSettingPage(),
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 17,
                              child: Icon(
                                Icons.settings,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 200,
                            margin: const EdgeInsets.only(top: 130),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: InkWell(
                                    onTap: () => PublicFunction.navigatorPush(context, ViewImagePage(title: '${workerModels!.data!.username}', urlImage: 'https://cariin.my.id/storage/${profileWorkerModel!.data!.profileImage}')),
                                    child: Container(
                                      width: 130,
                                      height: 200,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: profileWorkerModel!.data!.profileImage == 'null' ? Image.asset(
                                          AppAssets.firdanImg,
                                          fit: BoxFit.cover,
                                        ): Image.network('https://cariin.my.id/storage/${profileWorkerModel!.data!.profileImage}', fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        workerModels!.data!.username.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: color.white),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        'Front end developer',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: color.white),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_on_rounded,
                                                color: color.white,
                                                size: 14,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  '${workerModels!.data!.address}, Indonesia',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: color.white),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.man,
                                                color: color.white,
                                                size: 16,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                '${workerModels!.data!.gender}',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: color.white),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.email,
                                            size: 17,
                                            color: color.primary,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            '${workerModels!.data!.email}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: color.primary),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sentiment_dissatisfied,
                                            size: 17,
                                            color: color.primary,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            '19 Tahun',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: color.primary),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ChipTabBar(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            length: 4,
                            tabLabels: const [
                              'Pengalaman',
                              'Pendidikan',
                              'Keterampilan',
                              'Pencapaian'
                            ],
                            onTap: (value) => _tabIndex.value = value),
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: _tabIndex,
                        builder: (context, value, child) {
                          return _tabView[value];
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
