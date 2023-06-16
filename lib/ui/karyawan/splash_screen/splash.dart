import 'dart:async';

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../common/app_color.dart';
import '../../options/options.dart';
import '../auth/login.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({Key? key}) : super(key: key);

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  double _logoOpacity = 0;

  Future _initialize() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _logoOpacity = 1;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (await PublicFunction.getToken('company') == '') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OptionsPage(),), (route) => false);
    }else if(await PublicFunction.getToken('company') != ''){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(),), (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.secondaryContainer),
      ),
      backgroundColor: color.background,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.appsLogo,
          ),
        ),
      ),
    );
  }
}
