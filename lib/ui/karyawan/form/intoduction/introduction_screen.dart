import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/karyawan/auth/login.dart';
import 'package:cariin_v2/ui/karyawan/auth/register.dart';
import 'package:cariin_v2/ui/lowongan/auth_page/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import 'intro_page.dart';

class CompanyIntroductionPage extends StatefulWidget {
  const CompanyIntroductionPage({Key? key}) : super(key: key);

  @override
  State<CompanyIntroductionPage> createState() => _CompanyIntroductionPageState();
}

class _CompanyIntroductionPageState extends State<CompanyIntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showBackButton: false,
      showNextButton: true,
      showSkipButton: true,
      showDoneButton: true,
      back: const Icon(Icons.arrow_back),
      done: const Text("Done"),
      skip: const Text('Skip'),
      next: const Text('Next'),
      dotsFlex: 1,
      nextFlex: 1,
      dotsDecorator: DotsDecorator(
        size: Size(10, 10),
        color: Colors.grey,
        activeSize: Size(22, 10),
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
          title: "Title of custom body page",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on "),
              Text(" to edit a post"),
            ],
          ),
        ),
        PageViewModel(
          title: "Title of custom body page",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on "),
              Icon(Icons.edit),
              Text(" to edit a post"),
            ],
          ),
          image: const Center(child: Icon(Icons.android)),
        ),
        PageViewModel(
          title: "Title of custom body page",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on "),
              Text(" to edit a post"),
            ],
          ),
          image: SvgPicture.asset(AppAssets.introIcon),
        ),
        PageViewModel(
          title: "Title of custom body page",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on "),
              Text(" to edit a post"),
            ],
          ),
          image: SvgPicture.asset(AppAssets.introIcon),
        ),
      ],
    );
  }
}
