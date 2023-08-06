import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/auth/login.dart';
import 'package:cariin_v2/ui/karyawan/auth/register.dart';
import 'package:cariin_v2/ui/karyawan/form/intoduction/intro_page.dart';
import 'package:cariin_v2/ui/karyawan/form/intoduction/introduction_screen.dart';
import 'package:cariin_v2/ui/lowongan/auth_page/login.dart';
import 'package:cariin_v2/ui/lowongan/auth_page/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/app_color.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 100, bottom: 200),
                child: SvgPicture.asset(AppAssets.appsLogo),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    hoverColor: color.secondary.withOpacity(0.1),
                    onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KaryawanIntroPage(loginPage: const LoginLowonganPage(), registerPage: const RegisterLowonganPage()),
                        ),
                        (route) => false),
                    child: Container(
                      width: 150,
                      height: 220,
                      color: color.primary,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: color.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: SvgPicture.asset(
                                AppAssets.cariLowonganIcon,
                                color: color.primary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Cari Lowongan?',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: color.white),
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompanyIntroductionPage()
                          ),
                          (route) => false);
                    },
                    child: Container(
                      width: 150,
                      height: 220,
                      color: color.secondary.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: color.primary,
                            child: SvgPicture.asset(
                              AppAssets.cariKaryawanIcon,
                              color: color.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Cari Karyawan?',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: color.primary),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
