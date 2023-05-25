import 'package:cariin_v2/common/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 95,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: color.secondaryContainer),
            pinned: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(AppAssets.companyIcon,
                    width: 28, color: color.tertiary),
              ),
            ],
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:EdgeInsets.only(top: 20, bottom: 10),
                  child: CircleAvatar(
                    radius: 25,
                    foregroundImage: AssetImage(AppAssets.firdanImg),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
