import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/material.dart';

import '../../../common/app_assets.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      backgroundColor: color.surfaceContainer,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(true),
            child: Icon(Icons.arrow_back_ios),
          ),
          margin: EdgeInsets.only(left: 15),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profil',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 17, right: 15),
        child: ListView(
          children: [
            Text(
              'Ubah Foto Profil',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 130,
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.asset(
                    AppAssets.firdanImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            Text(
              'Ubah Nama',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color.outline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Ubah',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: color.outline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
