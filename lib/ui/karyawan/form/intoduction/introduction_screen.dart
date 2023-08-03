import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/auth/login.dart';
import 'package:cariin_v2/ui/karyawan/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/app_color.dart';
import 'intro_page.dart';

class CompanyIntroductionPage extends StatefulWidget {
  const CompanyIntroductionPage({Key? key}) : super(key: key);

  @override
  State<CompanyIntroductionPage> createState() => _CompanyIntroductionPageState();
}

class _CompanyIntroductionPageState extends State<CompanyIntroductionPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return IntroductionScreen(
      showBackButton: true,
      showNextButton: true,
      showSkipButton: false,
      showDoneButton: true,
      back: const Text("Kembali"),
      done: const Text("Mulai"),
      next: const Text('Lanjut'),
      dotsFlex: 1,
      nextFlex: 1,
      dotsDecorator: const DotsDecorator(
        size: Size(8, 8),
        color: Colors.grey,
        activeSize: Size(30, 8),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))
        )
      ),
      onDone: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => KaryawanIntroPage(loginPage: const LoginKaryawanPage(), registerPage: const CompanyRegisterPage()),
            ),
                (route) => false);
      },
      pages: [
        PageViewModel(
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temukan ', style: TextStyle(color: color.black, fontSize: 30, fontWeight: FontWeight.w700),),
                  Text('Karyawan', style: TextStyle(color: color.primary, fontSize: 30, fontWeight: FontWeight.w700),),
                ],
              ),
              Text('Sesuai Kriteria', style: TextStyle(color: color.black, fontSize: 30, fontWeight: FontWeight.w700),),
            ],
          ),
          bodyWidget: Text(
            'Cari lowongan pekerjaan dengan mudah dan tingkatkan pengalamanmu.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.black,
              fontSize: 15
            ),
          ),
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top: 30),
            imageAlignment: Alignment.bottomCenter,
          ),
          image: Lottie.asset(AppAssets.lottieImageJob4)
        ),
        PageViewModel(
          titleWidget: Text('Proses Wawancara Yang Mudah dan Cepat', textAlign: TextAlign.center, style: TextStyle(color: color.primary, fontSize: 25, fontWeight: FontWeight.w700),),
          bodyWidget: Text(
            'Mulai rekrut karyawanmu dan undang untuk diwawancarai',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.black,
              fontSize: 16
            ),
          ),
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top: 30),
            imageAlignment: Alignment.bottomCenter,
          ),
          image: Lottie.asset(AppAssets.lottieImageJob2)
        ),
        PageViewModel(
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Rekrut ', style: TextStyle(color: color.black, fontSize: 30, fontWeight: FontWeight.w700),),
                  Text('Karyawan', style: TextStyle(color: color.primary, fontSize: 30, fontWeight: FontWeight.w700),),
                ],
              ),
              Text('Sesuai yang dibutuhkan', style: TextStyle(color: color.black, fontSize: 30, fontWeight: FontWeight.w700),),
            ],
          ),
          bodyWidget: Text(
            'Merekrut karyawan dengan sekali ketuk :)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.black,
              fontSize: 15
            ),
          ),
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top: 30),
            imageAlignment: Alignment.bottomCenter,
          ),
          image: Lottie.asset(AppAssets.lottieImageJob3)
        ),
        PageViewModel(
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Mulai Pencarian', style: TextStyle(color: color.black, fontSize: 30, fontWeight: FontWeight.w700),),
              Text('Karyawan', style: TextStyle(color: color.primary, fontSize: 30, fontWeight: FontWeight.w700),),
            ],
          ),
          bodyWidget: Text(
            'Ayo Mulai Aplikasimu!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.black,
              fontSize: 15
            ),
          ),
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top: 30),
            imageAlignment: Alignment.bottomCenter,
          ),
          image: Lottie.asset(AppAssets.lottieImageJob1)
        ),
      ],
    );
  }
}

