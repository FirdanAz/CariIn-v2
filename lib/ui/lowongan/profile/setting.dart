// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/ui/lowongan/profile/data_profile/edit_profile.dart';
import 'package:cariin_v2/ui/lowongan/profile/experience/list_page.dart';
import 'package:cariin_v2/ui/lowongan/profile/skill/list_page.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';
import '../../../service/api_service.dart';
import '../../options/options.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String selectedLanguage = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan', style: TextStyle(fontSize: 20),),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(selectedLanguage),
          icon: Icon(Icons.arrow_back_ios_new, color: color.primary,),
        ),
      ),
      body: ListView(
        children: [
          _item(Icons.account_circle, 'Edit Profile & Status', Icons.edit, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage(),));
          }),
          _item(Icons.work_outline_rounded, 'Pengalaman', Icons.arrow_forward_ios, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ExperienceListPage(),));
          }),
          _item(Icons.school, 'Pendidikan', Icons.arrow_forward_ios, () {

          }),
          _item(Icons.workspace_premium_sharp, 'Keahlian', Icons.arrow_forward_ios, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ListSkillPage(),));
          }),
          ListTile(
            leading: Icon(Icons.logout_outlined, color: Colors.red,),
            title: Text('Keluar Dari Akun'),
            onTap: () {
              _logOut();
            },
          )
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title, IconData traillingIcon, void Function() function) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return ListTile(
      leading: Icon(icon, color: color.primary,),
      title: Text(title),
      trailing: Icon(traillingIcon),
      onTap: () {
        function();
      },
    );
  }

  _logOut() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Yakin untuk Keluar Akun ini?',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                bool isdeleteToken = await ApiService().deleteDeviceToken('worker');
                if (isdeleteToken) {
                  bool islogout = await ApiService().logoutAuth('worker');
                  if(islogout) {
                    await PublicFunction.removeToken('token');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OptionsPage(),
                        ),
                            (route) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PublicFunction.showDialog(
                            context, 'Berhasil Logout');
                      },
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PublicFunction.showDialog(
                          context, 'Gagal Logout');
                    },
                  );
                }
              },
              child: const Text(
                'Ya',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
