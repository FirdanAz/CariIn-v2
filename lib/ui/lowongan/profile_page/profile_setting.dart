import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/about_page.dart';
import 'package:cariin_v2/ui/options/options.dart';
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
            buildSetting(context, "Akun", () {}),
            buildSetting(context, "Atur Foto", () {}),
            buildSetting(context, "Atur Background", () {}),
            buildSetting(context, "Atur CV", () {}),
            buildSetting(context, "Apa ini?", () {}),
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
            buildSetting(context, "Kebijakan Privasi", () {}),
            buildSetting(context, "Syarat dan Ketentuan", () {}),
            buildSetting(context, "Pertanyaan sering Diajukan", () {}),
            buildSetting(context, "Bantuan", () {}),
            buildSetting(context, "Umpan Balik", () {}),
            buildSetting(context, "Tentang Kami", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()),
              );
            }),
            SizedBox(height: 25),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: color.error,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: color.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
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

GestureDetector buildSetting(
    BuildContext context, String title, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    ),
  );
}
