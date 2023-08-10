import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_color.dart';

// ignore: must_be_immutable
class KaryawanIntroPage extends StatefulWidget {
  KaryawanIntroPage({Key? key, required this.loginPage, required this.registerPage}) : super(key: key);
  Widget loginPage;
  Widget registerPage;

  @override
  State<KaryawanIntroPage> createState() => _KaryawanIntroPageState();
}

class _KaryawanIntroPageState extends State<KaryawanIntroPage> {


  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 120,),
              Center(child: SvgPicture.asset(AppAssets.introIcon)),
              const SizedBox(height: 30,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Jalan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    ),
                    Text(
                      ' Mudah',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: color.primary
                      ),
                    ),
                    const Text(
                      ' Untuk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    ),
                  ],
                ),
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mencari',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),
                    Text(
                      ' Pekerjaan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                'Cari lowongan pekerjaan dengan mudah dan tingkatkan pengalamanmu.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color.secondary,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 50,
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20
                ),
                decoration: BoxDecoration(
                  color: color.primary,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: InkWell(onTap: () {
                  PublicFunction.navigatorPushAndRemoveUntil(context, widget.loginPage);
                }, child: Center(child: Text('Masuk', style: TextStyle(color: color.white, fontWeight: FontWeight.w500, fontSize: 16),),)),
              ),
              Container(
                height: 50,
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(
                    horizontal: 10
                ),
                decoration: BoxDecoration(
                  color: color.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: color.primary)
                ),
                child: Center(child: InkWell(onTap: () {
                  PublicFunction.navigatorPushAndRemoveUntil(context, widget.registerPage);
                }, child: Center(child: Text('Daftar', style: TextStyle(color: color.primary, fontWeight: FontWeight.w500, fontSize: 16),))),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
