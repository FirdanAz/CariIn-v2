// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/karyawan/form/fill_data_worker/fill_data.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/change_profile.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/change_password.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/contact_info.dart';
import 'package:cariin_v2/ui/lowongan/profile_page/profile_settings.dart';
import 'package:cariin_v2/ui/options/options.dart';
import 'package:cariin_v2/ui/widget/danger_zone_content_button.dart';
import 'package:cariin_v2/ui/widget/setting_content_button.dart';
import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
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
          'Atur Akun & Profil',
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
                  Icons.sentiment_satisfied_alt,
                  color: color.primary,
                ),
                SizedBox(width: 10),
                Text(
                  'Data Diri',
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
              title: 'Edit Profil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeProfile(),
                  ),
                );
              },
            ),
            SettingContentButton(
              context: context,
              title: 'Ubah Kata Sandi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                );
              },
            ),
            SettingContentButton(
              context: context,
              title: 'Info Kontak',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactInfo(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: color.error,
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 1.5,
            ),
            SizedBox(height: 0),
            DangerZoneButton(
              context: context,
              title: 'Log Out',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
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
                            bool isdeleteToken =
                                await ApiService().deleteDeviceToken('worker');
                            if (isdeleteToken) {
                              bool islogout =
                                  await ApiService().logoutAuth('worker');
                              if (islogout) {
                                await PublicFunction.removeToken('token');
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OptionsPage(),
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
                          child: Text(
                            'Ya',
                            style: TextStyle(
                              color: color.error,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            DangerZoneButton(
                context: context, title: 'Hapus Akun', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
