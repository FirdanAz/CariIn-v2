import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:cariin_v2/ui/karyawan/form/rincian_usaha/rincian_usaha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/app_color.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Opsi',
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                hoverColor: color.secondaryContainer,
                onTap: () {},
                child: Container(
                  width: 150,
                  height: 220,
                  color: color.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: color.secondary,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: SvgPicture.asset(
                            AppAssets.cLowongan,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Cari Lowongan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const FormRincianUsaha(),), (route) => false);
                },
                child: Container(
                  width: 150,
                  height: 220,
                  color: color.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: color.secondary,
                        child: SvgPicture.asset(
                          AppAssets.cKaryawan,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Cari Karyawan',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
