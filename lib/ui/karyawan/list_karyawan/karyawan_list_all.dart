// ignore_for_file: non_constant_identifier_names

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/detail_profile/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_color.dart';

class ListKaryawan extends StatelessWidget {
  const ListKaryawan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.primaryContainer),
            title: Text(
              'Pekerja Siap Direkurt',
              style: TextStyle(
                  color: color.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return KaryawanListCard(context);
            },
              childCount: 10
            ),
          )
        ],
      ),
    );
  }
}

Widget KaryawanListCard(BuildContext context) {
  var color = AppColor.theme(Theme.of(context).brightness);

  return InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProfil(id: 1),)),
    child: Container(
      width: double.maxFinite,
      height: 150,
      margin: const EdgeInsets.symmetric(
          horizontal: 10
      ),
      decoration: BoxDecoration(
        color: color.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset:
            const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 20
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppAssets.firdanImg),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 5
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kalam',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: color.black,
                      fontSize: 17
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  '99 Tahun',
                  style: TextStyle(
                      color: color.black,
                      fontSize: 14
                  ),
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
                          color: color.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Text(
                  'UI/UX Designer',
                  style: TextStyle(
                      color: color.primary,
                      fontSize: 14
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
