import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/options/options.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/app_color.dart';

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
        PublicFunction.navigatorPushAndRemoveUntil(context, const OptionsPage());
      },
      pages: [
        PageViewModel(
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(AppAssets.lottieImageJob4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temukan ', style: TextStyle(color: color.black, fontSize: 30, fontWeight: FontWeight.w700),),
                  Text('Lowongan', style: TextStyle(color: color.primary, fontSize: 30, fontWeight: FontWeight.w700),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Atau ', style: TextStyle(color: color.black, fontSize: 30, fontWeight: FontWeight.w700),),
                  Text('Karyawan', style: TextStyle(color: color.primary, fontSize: 30, fontWeight: FontWeight.w700),),
                ],
              ),
            ],
          ),
          decoration: const PageDecoration(
            bodyAlignment: Alignment.center
          ),
          bodyWidget: Text(
            'Cari lowongan pekerjaan atau karyawan dengan mudah dan tingkatkan pengalamanmu.',
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: TextStyle(
              color: color.black,
              fontSize: 15
            ),
          ),
        ),
        PageViewModel(
          titleWidget: Column(
            children: [
              Lottie.asset(AppAssets.lottieImageJob2),
              const SizedBox(height: 30,),
              Text('Proses Wawancara Yang Mudah dan Cepat', textAlign: TextAlign.center, style: TextStyle(color: color.primary, fontSize: 25, fontWeight: FontWeight.w700),),
            ],
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
          bodyWidget: Text(
            'Mulai rekrut karyawanmu dan undang untuk diwawancarai',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.black,
              fontSize: 16
            ),
          ),
        ),
        PageViewModel(
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(AppAssets.lottieImageJob3),
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
          decoration: const PageDecoration(bodyAlignment: Alignment.center)
        ),
        PageViewModel(
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(AppAssets.lottieImageJob1),
              const SizedBox(height: 30,),
              Text('Mulai Aplikasi', style: TextStyle(color: color.black, fontSize: 30, fontWeight: FontWeight.w700),),
              Text('Pilih opsi berikutnya', style: TextStyle(color: color.primary, fontSize: 30, fontWeight: FontWeight.w700),),
            ],
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
          bodyWidget: Text(
            'Ayo Mulai Aplikasimu!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.black,
              fontSize: 15
            ),
          ),
        ),
      ],
    );
  }
}

