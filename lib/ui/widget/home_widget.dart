import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/detail_profile/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_color.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return SliverToBoxAdapter(
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: color.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SvgPicture.asset(
                    AppAssets.filterIcon,
                    height: 30,
                  ),
                ),
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Apakah hasilnya kurang relevan?',
                          style: TextStyle(
                            color: color.onSecondaryContainer,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          )),
                      Text(
                          'Update minat dan preferensi usaha anda untuk rekomendasi yang lebih akurat.',
                          style: TextStyle(
                            color: color.onSecondaryContainer,
                            fontSize: 13
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Perbarui Sekarang',
                          style: TextStyle(
                            color: color.secondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class WorkerCard extends StatelessWidget {
  const WorkerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return SliverToBoxAdapter(
        child: Container(
            height: 250,
            margin: EdgeInsets.only(top: 15),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              padding: EdgeInsets.only(
                left: 10
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailProfil(),)),
                  child: Container(
                    width: 160,
                    height: 230,
                    margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 5,
                        bottom: 10
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                          Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                            AssetImage(AppAssets.firdanImg),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kalam',
                                style: TextStyle(
                                    color: color.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Pria, 99 Tahun',
                                style: TextStyle(
                                    color: color.black.withOpacity(0.5),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Kabupaten Kudus',
                                style: TextStyle(
                                    color: color.black.withOpacity(0.5),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Programmer',
                                style: TextStyle(
                                    color: color.secondary, fontSize: 15),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
        )
    );
  }
}
class JobListCard extends StatelessWidget {
  const JobListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 7,(context, index) {
        return Column(
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
                      'Front End Web Developer',
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
                              color: color.secondaryContainer,
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
                              color: color.secondaryContainer,
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
                              color: color.secondaryContainer,
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
                                'Pt. Muria Jaya',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: color.tertiary
                                        .withOpacity(0.8)),
                              ),
                              Text(
                                'Surabaya, Indonesia',
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
                color: color.secondary,
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
        );
      }),
    );
  }
}


