import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/Account_settings.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/about_page.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/change_password.dart';
import 'package:cariin_v2/ui/options/options.dart';
import 'package:cariin_v2/ui/widget/setting_content_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../service/api_service.dart';
import '../../../common/public_function.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
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
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Profil & CV",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: color.onSurface,
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 1.5,
            ),
            SizedBox(height: 0),
            SettingContentButton(
                context: context,
                title: 'Atur Profil',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountSettings(),
                    ),
                  );
                }),
            SettingContentButton(
                context: context, title: "Atur CV", onTap: () {}),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: color.primary,
                ),
                SizedBox(width: 10),
                Text(
                  "Pusat Bantuan & Informasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1.5,
            ),
            SizedBox(height: 0),
            SettingContentButton(
                context: context, title: "Kebijakan Privasi", onTap: () {}),
            SettingContentButton(
                context: context, title: "Syarat dan Ketentuan", onTap: () {}),
            SettingContentButton(
                context: context,
                title: "Pertanyaan sering Diajukan",
                onTap: () {}),
            SettingContentButton(
                context: context, title: "Bantuan", onTap: () {}),
            SettingContentButton(
                context: context, title: "Umpan Balik", onTap: () {}),
            SettingContentButton(
                context: context,
                title: "Tentang Kami",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

void _LogOut() {
  var context;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text(
          "Ingin keluar dari akun ini ?",
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No")),
          TextButton(
            onPressed: () async =>
                await PublicFunction.removeToken('token').then(
              (value) => PublicFunction.navigatorPushAndRemoved(
                context,
                const OptionsPage(),
              ),
            ),
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
