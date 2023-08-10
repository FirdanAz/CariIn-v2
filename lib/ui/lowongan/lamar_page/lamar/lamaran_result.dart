import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/diterima.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/ditolak.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/menunggu.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/semua.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../common/responsive.dart';
import '../../../widget/chip_tab_bar.dart';

class LamaranResult extends StatefulWidget {
  const LamaranResult({Key? key}) : super(key: key);

  @override
  State<LamaranResult> createState() => _LamaranResultState();
}

class _LamaranResultState extends State<LamaranResult> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  color: color.background,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: 30,
                              color: color.primary,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Hasil Lamaran',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Divider(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SemuaTabs(all: true, value: 'null', titlePage: 'Semua Lamaran'),));
                                  },
                                  child: PelamarCard(
                                    icon: Icons.work_history_outlined,
                                    color: color.black,
                                    title: 'Semua Lamaran',
                                  )),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SemuaTabs(all: false, value: 'mengirim', titlePage: 'Belum Direview'),));
                                  },
                                  child: PelamarCard(
                                    icon: Icons.work_history_outlined,
                                    color: Colors.orange,
                                    title: 'Belum Direview',
                                  )),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SemuaTabs(all: false, value: 'direview', titlePage: 'Sedang Direview'),));
                                  },
                                  child: PelamarCard(
                                    icon: Icons.work_history_outlined,
                                    color: Colors.orange,
                                    title: 'Sedang Direview',
                                  )),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SemuaTabs(all: false, value: 'wawancara', titlePage: 'Wawancara'),));
                                },
                                child: PelamarCard(
                                  icon: Icons.work_history_outlined,
                                  color: color.primary,
                                  title: 'Proses Wawancara',
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SemuaTabs(all: false, value: 'diterima', titlePage: 'Lamaran Diterima'),));
                                },
                                child: PelamarCard(
                                  icon: Icons.work_history_outlined,
                                  color: Colors.green,
                                  title: 'Lamaran Diterima',
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SemuaTabs(all: false, value: 'ditolak', titlePage: 'Lamaran Ditolak'),));
                                },
                                child: PelamarCard(
                                  icon: Icons.work_history_outlined,
                                  color: Colors.red,
                                  title: 'Lamaran Ditolak',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {

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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Pekerjaan Dilamar',
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
                Card(
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
    );
  }
}

class PelamarCard extends StatelessWidget {
  PelamarCard(
      {Key? key, required this.icon, required this.color, required this.title})
      : super(key: key);
  IconData icon;
  Color color;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 110),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
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

