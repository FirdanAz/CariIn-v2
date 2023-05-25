import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:cariin_v2/ui/karyawan/home_page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_color.dart';

class FormRincianUsaha extends StatefulWidget {
  const FormRincianUsaha({Key? key}) : super(key: key);

  @override
  State<FormRincianUsaha> createState() => _FormRincianUsahaState();
}

class _FormRincianUsahaState extends State<FormRincianUsaha> {
  String selectedValue = "SMA/SMK";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Perguruan Tinggi"), value: "Perguruan Tinggi"),
      DropdownMenuItem(child: Text("SMA/SMK"), value: "SMA/SMK"),
      DropdownMenuItem(child: Text("SMP"), value: "SMP"),
      DropdownMenuItem(child: Text("SD"), value: "SD"),
      DropdownMenuItem(child: Text("Tidak Sekolah"), value: "Tidak Sekolah"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Rincian Usaha',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tambahkan logo perusahaan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.symmetric(
                        vertical: 20
                      ),
                      color: color.secondary,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10
                          ),
                          child: SvgPicture.asset(AppAssets.companyIcon, color: color.secondary,),
                          decoration: BoxDecoration(
                            color: color.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        )
                      ),
                    ),
                  ),
                  const Text(
                    'Tambahkan gambar perusahaan tampak luar',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.symmetric(
                          vertical: 20
                      ),
                      color: color.secondary,
                      child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 10
                            ),
                            child: Icon(Icons.add),
                            decoration: BoxDecoration(
                                color: color.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          )
                      ),
                    ),
                  ),
                  const Text(
                    'Dibidang apa bisnis anda?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 70,
                    width: double.maxFinite,
                    child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedValue,
                        icon: Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.arrow_drop_down)),
                        elevation: 18,
                        underline: Container(
                          height: 2,
                          color: color.black.withOpacity(0.1),
                        ),
                        style:
                        TextStyle(color: color.black),
                        iconSize: 30,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        items: dropdownItems
                    ),
                  ),
                  SizedBox(height: 10,),
                  const Text(
                    'Kapan didirikan?',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 100,
                        margin: EdgeInsets.all(8),
                        color: color.black,
                      ),
                      Column(
                        children: [
                          Text(
                            'Provinsi',
                            style: TextStyle(),
                          ),
                          Container(
                            height: 20,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate:
                          DateTime.now(), //get today's date
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101))
                          .then((value) {}
                      );
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: color.secondary, width: 2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(
                          'Pilih Tanggal',
                          style: TextStyle(
                            color: color.secondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(  ),), (route) => false);},
              child: Container(
                width: double.maxFinite,
                height: 60,
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20
                ),
                decoration: BoxDecoration(
                  color: color.secondary,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Lanjut', style: TextStyle(
                  color: color.white
                ),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
