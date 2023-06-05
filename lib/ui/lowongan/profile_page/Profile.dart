import 'dart:ui';
import 'package:cariin_v2/common/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: 210,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: Color.fromRGBO(25, 164, 206, 1),
                ),
                width: double.infinity, // mengatur lebar maksimal
                height: 375, // mengatur tinggi// mengatur warna background
                child: Padding( 
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(AppAssets.activityIcon)
        ])
                  )
                )
              )
      )],
      ));
  }
}
