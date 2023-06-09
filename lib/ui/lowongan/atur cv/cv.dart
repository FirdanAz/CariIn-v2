import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/app_assets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AturCvPage extends StatefulWidget {
  AturCvPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AturCvPage> createState() => _AturCvPageState();
}

class _AturCvPageState extends State<AturCvPage> {
  String dropdownJenisKelamin = 'Jenis Kelamin';
  String dropdownStatus = 'Status';
  String dropdownAgama = 'Agama';

  @override
  Widget build(BuildContext context) {
    final color = AppColor.theme(MediaQuery.of(context).platformBrightness);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Atur CV',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            Text(
              'Lamar mudah tanpa perlu ke lokasi',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: color.primary,
                  child: Icon(Icons.add, color: color.white),
                ),
                SizedBox(
                  width: 60,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(AppAssets.firdanImg),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Contoh foto')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Note: gunakan pas foto untuk meningkatkan kesempatan Rekomendasi ',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 80,
              backgroundColor: color.primary,
              child: Icon(Icons.add, color: color.white),
            ),
            SizedBox(
              height: 40,
              width: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: color.surfaceContainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton<String>(
                    value: dropdownJenisKelamin,
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownJenisKelamin = newValue!;
                      });
                    },
                    underline: SizedBox(),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Jenis Kelamin',
                        child: Text('Jenis Kelamin'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Pria',
                        child: Text('Pria'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Wanita',
                        child: Text('Wanita'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: color.surfaceContainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton<String>(
                    value: dropdownStatus,
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownStatus = newValue!;
                      });
                    },
                    underline: SizedBox(),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Status',
                        child: Text('Status'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Belum Menikah',
                        child: Text('Belum Menikah'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Menikah',
                        child: Text('Menikah'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  color: color.surfaceContainer,
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton<String>(
                value: dropdownAgama,
                icon: Icon(Icons.arrow_drop_down_rounded),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownAgama = newValue!;
                  });
                },
                underline: SizedBox(),
                items: [
                  DropdownMenuItem<String>(
                    value: 'Agama',
                    child: Text('Agama'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Islam',
                    child: Text('Islam'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Protestan',
                    child: Text('Protestan'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Katolik',
                    child: Text('Katolik'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Hindu',
                    child: Text('Hindu'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Budha',
                    child: Text('Budha'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Konghucu',
                    child: Text('Konghucu'),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
