// ignore_for_file: must_be_immutable

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/detail_profile/detail.dart';
import 'package:cariin_v2/ui/karyawan/form/rincian_usaha/rincian_usaha.dart';
import 'package:cariin_v2/ui/lowongan/detail_lowongan/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_color.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FormRincianUsaha(),)),
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.only(top: 10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              constraints: const BoxConstraints(minHeight: 100),
              decoration: BoxDecoration(
                color: color.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: color.primaryContainer.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SvgPicture.asset(
                      AppAssets.filterIcon,
                      // ignore: deprecated_member_use
                      color: color.primary,
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
                                color: color.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        Text(
                            'Update minat dan preferensi usaha anda untuk rekomendasi yang lebih akurat.',
                            style: TextStyle(
                                color: color.onPrimaryContainer, fontSize: 13)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Perbarui Sekarang',
                            style: TextStyle(
                                color: color.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class JobListCard extends StatelessWidget {
  const JobListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 7, (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetailPage(id: 1,),
              )),
          child: Column(
            children: [
              Container(
                height: 140,
                width: double.maxFinite,
                margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: color.white,
                  boxShadow: [
                    BoxShadow(
                      color: color.primaryContainer.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                            backgroundColor: color.black.withOpacity(0.5),
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
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            margin: const EdgeInsets.only(right: 7),
                            decoration: BoxDecoration(
                                color: color.primaryContainer,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              'Front End',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            margin: const EdgeInsets.only(right: 7),
                            decoration: BoxDecoration(
                                color: color.primaryContainer,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              'Ui/Ux Designer',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            margin: const EdgeInsets.only(right: 7),
                            decoration: BoxDecoration(
                                color: color.primaryContainer,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              'Hacker',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 7, left: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 4,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: color.tertiary.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pt. Muria Jaya',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: color.tertiary.withOpacity(0.8)),
                                ),
                                Text(
                                  'Surabaya, Indonesia',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: color.tertiary.withOpacity(0.8)),
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
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: color.primaryContainer.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(2, 2), // changes position of shadow
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
    );
  }
}

class CategoryButton extends StatelessWidget {
  CategoryButton({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return ActionChip(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 11),
      backgroundColor: color.primary,
      labelPadding: EdgeInsets.zero,
      onPressed: () {},
      elevation: 10,
      pressElevation: 16,
      shadowColor: const Color(0x80AAAACC),
      label: Text(
        text,
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}

class NewJobListCard extends StatefulWidget {
  const NewJobListCard({Key? key}) : super(key: key);

  @override
  State<NewJobListCard> createState() => _NewJobListCardState();
}

class _NewJobListCardState extends State<NewJobListCard> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailPage(id: 1,),
          )),
      child: Column(
        children: [
          Container(
            height: 140,
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            decoration: BoxDecoration(
              color: color.white,
              boxShadow: [
                BoxShadow(
                  color: color.primaryContainer.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(2, 2), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'title',
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
                        'experience',
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
                        backgroundColor: color.black.withOpacity(0.5),
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 5),
                        margin: const EdgeInsets.only(right: 7),
                        decoration: BoxDecoration(
                            color: color.primaryContainer,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'Front End',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 5),
                        margin: const EdgeInsets.only(right: 7),
                        decoration: BoxDecoration(
                            color: color.primaryContainer,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'Ui/Ux Designer',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 5),
                        margin: const EdgeInsets.only(right: 7),
                        decoration: BoxDecoration(
                            color: color.primaryContainer,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'Hacker',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 7, left: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 4,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: color.tertiary.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pt. Muria Jaya',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: color.tertiary.withOpacity(0.8)),
                            ),
                            Text(
                              'Surabaya, Indonesia',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: color.tertiary.withOpacity(0.8)),
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
              borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: color.primaryContainer.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(2, 2), // changes position of shadow
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
                const SizedBox(
                  width: 13,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WorkerCards extends StatelessWidget {
  WorkerCards({Key? key, required this.id, required this.name, required this.gender, required this.age, required this.location, required this.selection, required this.urlProfileImage}) : super(key: key);
  int id;
  String name;
  String gender;
  String age;
  String location;
  String selection;
  String urlProfileImage;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return InkWell(
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProfil(id: id),
          )),
      child: Container(
        width: 160,
        height: 230,
        margin: const EdgeInsets.only(
            left: 10, right: 10, top: 5, bottom: 10),
        decoration: BoxDecoration(
          color: color.white,
          boxShadow: [
            BoxShadow(
              color: color.primaryContainer.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: urlProfileImage == 'null' ? NetworkImage('https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png') : NetworkImage('https://cariin.my.id/storage/$urlProfileImage'),
              )
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    style: TextStyle(
                        color: color.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$gender, $age Tahun',
                    style: TextStyle(
                        color: color.black.withOpacity(0.5),
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    location,
                    maxLines: 1,
                    style: TextStyle(
                        color: color.black.withOpacity(0.5),
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    selection,
                    maxLines: 1,
                    style: TextStyle(
                        color: color.primary, fontSize: 15),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



