import 'package:cariin_v2/common/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_color.dart';

class DetailProfil extends StatelessWidget {
  const DetailProfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.secondaryContainer),
            title: Text(
              'Profil',
              style: TextStyle(
                  color: color.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              height: 140,
              margin: EdgeInsets.symmetric(
                  horizontal: 13
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: 5
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.firdanImg),
                      radius: 60,
                    ),
                  ),
                  Container(
                    width: 5,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: color.secondary,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kalam',
                                    style: TextStyle(
                                        color: color.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '99 Tahun',
                                    style: TextStyle(
                                        color: color.black,
                                        fontSize: 14
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(child: SvgPicture.asset(AppAssets.cvIcon, width: 25,), onTap: () {},)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Kudus, Jawa Tengah, ',
                              style: TextStyle(
                                  color: color.black,
                                  fontSize: 14
                              ),
                            ),
                            Text(
                              'Indonesia',
                              style: TextStyle(
                                  color: color.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: color.secondary,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Ui/Ux Designer',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: color.white
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: color.secondary,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Front End',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: color.white
                                ),
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
            child: Column(
              children: [
                ProfilCard(context, AppAssets.genderIcon, 'Jenis Kelamin', 'Laki - Laki'),
                ProfilCard(context, AppAssets.activityIcon, 'Aktivitas', ' - Belum Ada'),
                ProfilCard(context, AppAssets.fieldIcon, 'Bidang', 'Programmer'),
                ProfilCard(context, AppAssets.motivationIcon, 'Motivasi', 'Berhubungan dengan skil dan pengalaman kerja'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: color.white,
        child: InkWell(
          onTap: () {},
          hoverColor: Colors.black,
          child: Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 18,
            margin: EdgeInsets.symmetric(
                horizontal: 10
            ),
            decoration: BoxDecoration(
                color: color.secondary,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Text(
              'Undang Wawancara',
              style: TextStyle(
                  color: color.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget ProfilCard(BuildContext context, String image, String title, String desc) {
  var color = AppColor.theme(Theme.of(context).brightness);

  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10
    ),
    child: Card(
      elevation: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            margin: EdgeInsets.only(
                left: 10,
                top: 20,
                right: 20,
                bottom: 40
            ),
            child: Stack(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: color.secondaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 25,
                      top: 25
                  ),
                  child: SvgPicture.asset(
                    image,
                    width: 25,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: color.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: color.secondaryContainer,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Container(
                    width: 200,
                    child: Text(
                      desc,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: color.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      ),
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