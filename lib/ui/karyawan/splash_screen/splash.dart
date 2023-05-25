import 'dart:async';

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../common/app_color.dart';

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
    Timer(Duration(seconds: 2), () {
      // Navigator.pushReplacement(context,
      //     PageTransition(child: FutureBuilder(
      //       future: _initializedFirebase(),
      //       builder: (context, snapshot) {
      //         if(snapshot.connectionState == ConnectionState.done){
      //           return FirebaseAuth.instance.currentUser == null ?  const LoginPage() : BottomNavbar();
      //         }
      //         return const Center(child: CircularProgressIndicator());
      //       },), type: PageTransitionType.fade));
      Navigator.pushReplacement(
          context,
          PageTransition(
              child:CustomBottomNavigation(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 900),
              curve: Curves.ease));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.primary),
      ),
      backgroundColor: color.primary,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.appsLogo,
          ),
        ),
      ),
    );
  }
}
