import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailLowongan extends StatefulWidget {
  const DetailLowongan({Key? key}) : super(key: key);

  @override
  State<DetailLowongan> createState() => _DetailLowonganState();
}

class _DetailLowonganState extends State<DetailLowongan> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            backgroundColor: Colors.blue,
            leading: Icon(
              Icons.arrow_back_ios_new,
              color: color.white,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://blog.cakap.com/wp-content/uploads/2022/10/company-profile-adalah.jpg',
                errorBuilder: (context, error, stackTrace) => SvgPicture.asset(AppAssets.warningIcon),
                fit: BoxFit.cover,
              ),
              title: Text(
                'Detail',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
          ),
          SliverFillRemaining()
        ],
      ),
    );
  }
}
