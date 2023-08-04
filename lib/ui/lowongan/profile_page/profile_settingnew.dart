import 'package:flutter/material.dart';
import '../../../common/app_color.dart';

class ProfileSettingPageNew extends StatefulWidget {
  const ProfileSettingPageNew({super.key});

  @override
  State<ProfileSettingPageNew> createState() => _ProfileSettingPageNewState();
}

class _ProfileSettingPageNewState extends State<ProfileSettingPageNew> {
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
          'Pengaturan',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.maxFinite,
            color: color.secondary,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: color.primary,
                ),
                SizedBox(width: 10),
                Text(
                  "Akun",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: color.onSurface,
                  ),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1.5,
            )
          ],
        ),
      ),
    );
  }
}
