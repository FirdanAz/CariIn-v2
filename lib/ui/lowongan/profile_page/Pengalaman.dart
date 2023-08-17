import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PengalamanPage extends StatefulWidget {
  const PengalamanPage({super.key});

  @override
  State<PengalamanPage> createState() => _PengalamanPageState();
}

class _PengalamanPageState extends State<PengalamanPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: const EdgeInsets.all(5)),
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: color.black,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: SvgPicture.asset(AppAssets.gsDriveIcon, color: color.white,)
                    ),
                    ]
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.all(1)),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sr. Visual Designer',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(1)),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text('AirBNB | Feb 2019 - 2020',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                          Padding(padding: const EdgeInsets.all(1)),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text('Selamat datang di Google Drive, tempat perpaduan kreatif dan teknologi terbaik untuk mendorong batas inovasi.',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          )
                        ],
                      ),
                    )
              ]
            )
          ),
              Container(
                  decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: BorderRadius.circular(10)),
                  width: double.maxFinite,
                  height: 115,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      'UI/UX Designer',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text('Google Drive | Feb 2020 - Now',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text('Selamat datang di Google Drive.....',
                                    style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                    ),
                                    ),
                                  )
                                ],
                              )
                            ]
                        )
                      ]
                  )
              )
      ]
    );
  }
}