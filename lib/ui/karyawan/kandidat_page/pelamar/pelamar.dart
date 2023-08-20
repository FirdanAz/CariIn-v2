// ignore_for_file: must_be_immutable

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/lowongan/lowongan.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/pelamar/tab_worker/semua.dart';
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';
import '../../../bottom_navigation/bottom_navigation_karyawan.dart';

class PelamarTab extends StatefulWidget {
  const PelamarTab({Key? key}) : super(key: key);

  @override
  State<PelamarTab> createState() => _PelamarTabState();
}

class _PelamarTabState extends State<PelamarTab> {
  bool _isLoad = false;

  waiting() async {
    _isLoad = true;
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isLoad = false;
    });;
  }

  @override
  void initState() {
    // TODO: implement initState
    waiting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(indexs: 1),), (route) => false),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: double.maxFinite,
                child: Column(
                  children: [
                    _isLoad ? CustomShimmer(width: double.maxFinite, height: 300, radius: 0) : Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      color: color.background,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  size: 30,
                                  color: color.secondary,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Pelamar Perusahaan',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const Divider(),
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                InkWell(
                                    onTap: () {
                                      PublicFunction.navigatorPush(context, SemuaTabs(all: true, value: 'null', titlePage: 'Semua Pelamar',));
                                    },
                                    child: PelamarCard(
                                      icon: AppAssets.flaticonSemuaWorker,
                                      title: 'Semua Pelamar',
                                    )),
                                InkWell(
                                    onTap: () {
                                      PublicFunction.navigatorPush(context, SemuaTabs(all: false, value: 'mengirim', titlePage: 'Belum Direview',));
                                    },
                                    child: PelamarCard(
                                      icon: AppAssets.flaticonSedangReview,
                                      title: 'Belum Direview',
                                    )),
                                InkWell(
                                    onTap: () {
                                      PublicFunction.navigatorPush(context, SemuaTabs(all: false, value: 'direview', titlePage: 'Direview',));
                                    },
                                    child: PelamarCard(
                                      icon: AppAssets.flaticonSudahReview,
                                      title: 'Sudah Direview',
                                    )),
                                InkWell(
                                  onTap: () {
                                    PublicFunction.navigatorPush(context, SemuaTabs(all: false, value: 'wawancara', titlePage: 'Proses Wawancara',));
                                  },
                                  child: PelamarCard(
                                    icon: AppAssets.flaticonWawancaraWorker,
                                    title: 'Proses Wawancara',
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    PublicFunction.navigatorPush(context, SemuaTabs(all: false, value: 'diterima', titlePage: 'Pelamar Diterima',));
                                  },
                                  child: PelamarCard(
                                    icon: AppAssets.flaticonPelamarDiterima,
                                    title: 'Pelamar Diterima',
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    PublicFunction.navigatorPush(context, SemuaTabs(all: false, value: 'ditolak', titlePage: 'Pelamar Ditolak'));
                                  },
                                  child: PelamarCard(
                                    icon: AppAssets.flaticonPelamarDitolak,
                                    title: 'Pelamar Ditolak',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    _isLoad ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomShimmer(width: double.maxFinite, height: 40, radius: 0),
                    ) : InkWell(
                      onTap: () {
                        PublicFunction.navigatorPush(context, const LowonganPage());
                      },
                      child: Card(
                        color: color.background,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Hasil Lamaran',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                    ),
                    _isLoad ? CustomShimmer(width: double.maxFinite, height: 100, radius: 0) : Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      color: color.background,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.live_help_outlined,
                                  size: 30,
                                  color: color.primary,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Penjelasan Fitur',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const Divider(),
                            HelpCard(text: 'Menunggu Direview'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    // final List<Widget> tabView = [
    //   const SemuaTabs(),
    //   const DiterimaTabs(),
    //   const MenungguTabs(),
    //   const DitolakTabs(),
    // ];
    // return SingleChildScrollView(
    //     child: Container(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Align(
    //           alignment: Alignment.centerLeft,
    //           child: ChipTabBar(
    //             length: 4,
    //             itemDistance: Responsive.byWidth(12),
    //             padding: EdgeInsets.symmetric(
    //               horizontal: Responsive.byWidth(15),
    //               vertical: Responsive.byWidth(10),
    //             ),
    //             tabLabels: const [
    //               "Semua",
    //               "Diterima",
    //               "Direview",
    //               "Ditolak",
    //             ],
    //             onTap: (value) => _tabIndex.value = value,
    //           ),
    //         ),
    //
    //         // TabBar View
    //         ValueListenableBuilder<int>(
    //           valueListenable: _tabIndex,
    //           builder: (context, value, child) {
    //             return tabView[value];
    //           },
    //         ),
    //         // SizedBox(height: 50,)
    //       ],
    //     ),
    //   ),
    // );
  }
}

class PelamarCard extends StatelessWidget {
  PelamarCard(
      {Key? key, required this.icon, required this.title})
      : super(key: key);
  String icon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 110),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(icon, width: double.maxFinite,)),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class HelpCard extends StatelessWidget {
  HelpCard({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    final color = AppColor.theme(Theme.of(context).brightness);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.help,
              size: 25,
              color: color.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                const Text(
                  'Apa itu ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16, color: color.primary),
                ),
                const Text(
                  '?',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const Icon(Icons.navigate_next)
      ],
    );
  }
}
