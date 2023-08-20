import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';

class HasilWawancara extends StatefulWidget {
  const HasilWawancara({super.key});

  @override
  State<HasilWawancara> createState() => _HasilWawancaraState();
}

class _HasilWawancaraState extends State<HasilWawancara> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      backgroundColor: color.surfaceContainer,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(true),
            child: Icon(Icons.arrow_back_ios),
          ),
          margin: EdgeInsets.only(left: 15),
        ),
        centerTitle: true,
        title: Text(
          'Hasil Wawancara',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.maxFinite,
            color: color.secondary,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  color: color.background,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 30,
                              color: color.primary,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Pelamar Pekerjaan',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(AppAssets.firdanImg),
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              width: double.maxFinite,
                              child: Text(
                                'Muhammad Firdan Azhari',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              width: double.maxFinite,
                              child: Text(
                                '17 Tahun',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              width: double.maxFinite,
                              child: Text(
                                'Jl.Kudus, Indonesia',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  color: color.background,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              size: 30,
                              color: color.primary,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Pekerjaan Dilamar',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Container(
                                width: 55,
                                height: 55,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: color.black,
                                    borderRadius: BorderRadius.circular(10)),
                                child: SvgPicture.asset(
                                  AppAssets.gsDriveIcon,
                                  color: color.white,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 15)),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Sr. Visual Designer',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(1)),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Google Drive | Feb 2019 - 2020',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(1)),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Selamat Datang di Google Drive, temp...',
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
