import 'package:cariin_v2/common/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import '../../common/app_color.dart';
import '../karyawan/auth/login.dart';
import '../karyawan/auth/register.dart';
import '../karyawan/form/intoduction/intro_page.dart';
import '../lowongan/auth_page/login.dart';
import '../lowongan/auth_page/register.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 20, backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.primaryContainer),),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Opsi',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: color.black
                ),
              ),
              Row(
                children: [
                  Text(
                    'Sedang mencari ',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: color.black
                    ),
                  ),
                  Text(
                    'Lowongan?',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: color.primary
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Atau cari ',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: color.black
                    ),
                  ),
                  Text(
                    'Karyawan?',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: color.primary
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KaryawanIntroPage(loginPage: const LoginLowonganPage(), registerPage: const RegisterLowonganPage()),
                                ),
                                    (route) => false);
                          },
                          child: Container(
                            height: 300,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              border: Border.all(color: color.primaryContainer, width: 3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(AppAssets.lottieSearchJob, width: 200),
                                const SizedBox(height: 20,),
                                Text(
                                  'Cari Lowongan',
                                  style: TextStyle(
                                    color: color.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KaryawanIntroPage(loginPage: const LoginKaryawanPage(), registerPage: const CompanyRegisterPage())
                                ),
                                    (route) => false);
                          },
                          child: Container(
                            height: 300,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              border: Border.all(color: color.primaryContainer, width: 3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(AppAssets.lottieSearchWorker, width: 200),
                                SizedBox(height: 20,),
                                Text(
                                  'Cari Karyawan',
                                  style: TextStyle(
                                       color: color.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
