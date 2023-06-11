import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';

class AturCvPage extends StatefulWidget {
  AturCvPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AturCvPage> createState() => _AturCvPageState();
}

class _AturCvPageState extends State<AturCvPage> {
  DateTime _dateTime = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null)
        setState(() {
          _dateTime = value;
        });
    });
  }

  String dropdownJenisKelamin = 'Jenis Kelamin';
  String dropdownStatus = 'Status';
  String dropdownAgama = 'Agama';
  String dropdownMinatDiIndustri = 'Minat di Industri';

  @override
  Widget build(BuildContext context) {
    final color = AppColor.theme(MediaQuery.of(context).platformBrightness);

    showLoaderDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(backgroundColor: color.secondary),
            SizedBox(width: 14),
            const Text("Loading..."),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  radius: 75,
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
              radius: 75,
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
                    padding: EdgeInsets.symmetric(horizontal: 30),
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
                  width: 20,
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
                    padding: EdgeInsets.symmetric(horizontal: 30),
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
            Row(
              children: [
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
                    padding: EdgeInsets.symmetric(horizontal: 41),
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
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26),
                          child: Text(
                            'Tanggal Lahir',
                            style: TextStyle(color: color.black),
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: color.surfaceContainer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ))
                  ],
                )
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
                value: dropdownMinatDiIndustri,
                icon: Icon(Icons.arrow_drop_down_rounded),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownAgama = newValue!;
                  });
                },
                underline: SizedBox(),
                padding: EdgeInsets.symmetric(horizontal: 100),
                items: [
                  DropdownMenuItem<String>(
                    value: 'Minat di Industri',
                    child: Text('Minat di Industri'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Desain',
                    child: Text('Desain'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Informasi Teknologi',
                    child: Text('Informasi Teknologi'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Front-End Dev (Web)',
                    child: Text('Front-End Dev (Web)'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Front-End Dev (Mobile)',
                    child: Text('Front-End Dev (Mobile)'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Back-End Dev (Web)',
                    child: Text('Back-End Dev (Web)'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Back-End Dev (Mobile)',
                    child: Text('Back-End Dev (Mobile)'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: const TextField(
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Apa yang memotivasi kamu mencari pekerjaan?",
                    ),
                  )),
            ),
            Container(
              width: double.maxFinite,
              height: 70,
              decoration: BoxDecoration(
                color: color.primary,
                borderRadius: BorderRadius.circular(10)
              ),
              child: InkWell(
                onTap: () async {
                  showLoaderDialog(context);
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context).pop(true);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CustomBottomNavigation(),), (route) => false);
                },
                child: Center(
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: color.white
                    ),
                  ),
                ),
              ),
              )
          ]),
        ),
      )
    );
  }
}
