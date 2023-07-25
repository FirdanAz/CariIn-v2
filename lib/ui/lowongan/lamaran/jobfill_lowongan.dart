import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LamaranDetailPage extends StatelessWidget {
  LamaranDetailPage({Key? key}) : super(key: key);
  bool isHaveLamaran = false;

  List<String> items = [
    "Semua",
    "Diterima",
    "Ditolak",
    "Direkrut",
    "Wawancara",
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return isHaveLamaran
        ? ListView.separated(
            itemCount: 1,
            padding: EdgeInsets.all(25),
            separatorBuilder: (context, index) => Divider(
              height: 20,
              color: Colors.transparent,
            ),
            itemBuilder: (context, index) {
              return Container(
                width: double.maxFinite,
                height: 50,
                color: Colors.blue,
              );
            },
          )
        : Scaffold(
            body: Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: double.maxFinite,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            current = index;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.all(5),
                            width: 95,
                            height: 45,
                            decoration: BoxDecoration(
                                color: current == index
                                    ? Colors.white70
                                    : Colors.grey.shade100,
                                borderRadius: current == index
                                    ? BorderRadius.circular(10)
                                    : BorderRadius.circular(10),
                                border: current == index
                                    ? Border.all(
                                        color: Colors.deepPurpleAccent,
                                        width: 2)
                                    : null),
                            child: Center(
                              child: Text(
                                items[index],
                                style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w500,
                                    color: current == index
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 105),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: color.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                AppAssets.wIcon,
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Lamaran Belum Diproses',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              'Lamar untuk mendapatkan Lowongan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 50,
                            margin: EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            decoration: BoxDecoration(
                                color: color.primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Buat Lamaran',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: color.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
