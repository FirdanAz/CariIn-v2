import 'package:cariin_v2/common/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_color.dart';

class PelamarTab extends StatelessWidget {
  PelamarTab({Key? key}) : super(key: key);
  bool isHavePelamar = false;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return isHavePelamar ?
    ListView.separated(
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
    ): Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: color.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppAssets.wIcon, width: 40,),
                ),
              ),
              SizedBox(height: 25,),
              Text(
                'Belum ada pelamar',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 50,),
              Container(
                width: 200,
                child: Text(
                  'Buat lowongan untuk mendapatkan Pelamar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: double.maxFinite,
                height: 50,
                margin: EdgeInsets.symmetric(
                  horizontal: 40
                ),
                decoration: BoxDecoration(
                  color: color.secondary,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    'Buat Lowongan',
                    style: TextStyle(
                      fontSize: 15,
                      color: color.white
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
