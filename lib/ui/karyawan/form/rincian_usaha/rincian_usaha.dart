import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';

import '../../../../common/app_color.dart';

class FormRincianUsaha extends StatefulWidget {
  const FormRincianUsaha({Key? key}) : super(key: key);

  @override
  State<FormRincianUsaha> createState() => _FormRincianUsahaState();
}

class _FormRincianUsahaState extends State<FormRincianUsaha> {
  String selectedValue = "SMA/SMK";
  List<int> selectedButton = [];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const[
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
          const SliverAppBar(
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
              margin: const EdgeInsets.symmetric(
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
                      margin: const EdgeInsets.symmetric(
                        vertical: 20
                      ),
                      color: color.primary,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10
                          ),
                          decoration: BoxDecoration(
                            color: color.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: SvgPicture.asset(AppAssets.companyIcon, color: color.primary,),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 20
                      ),
                      color: color.primary,
                      child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 10
                            ),
                            child: const Icon(Icons.add),
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
                  const SizedBox(height: 10,),
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
                  const SizedBox(height: 10,),
                  const Text(
                    'Kapan didirikan?',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () async {
                      // DateTime? pickedDate = await showDatePicker(
                      //     context: context,
                      //     initialDate:
                      //     DateTime.now(), //get today's date
                      //     firstDate: DateTime(
                      //         2000), //DateTime.now() - not to allow to choose before today.
                      //     lastDate: DateTime(2101))
                      //     .then((value) {}
                      // );
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: color.primary, width: 2),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(
                          'Pilih Tanggal',
                          style: TextStyle(
                              color: color.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Dimana bisnis didirikan?',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 215,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color.onBackground.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Provinsi',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.maxFinite,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
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
                              const Text(
                                'Kota',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.maxFinite,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
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
                              const Text(
                                'Kecamatan',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.maxFinite,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
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
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  const Text(
                    'Selaku',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.maxFinite,
                    child: GroupButton(
                      isRadio: false,
                      borderRadius: BorderRadius.circular(10),
                      spacing: 10,
                      buttonHeight: 60,
                      mainGroupAlignment: MainGroupAlignment.spaceEvenly,
                      selectedBorderColor: color.primary,
                      unselectedColor: color.primary,
                      selectedColor: color.white,
                      selectedTextStyle: TextStyle(
                        color: color.primary
                      ),
                      unselectedTextStyle: TextStyle(color: color.white),
                      buttons: const [
                        "Pemilik",
                        "Pengelola",
                        "HRD"
                      ],
                      selectedButtons: selectedButton,
                      onSelected: (int index, bool isSelected) {
                        setState(() {
                          selectedButton.add(index);
                        });
                        print(selectedButton);
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Info singkat bisnis',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: double.maxFinite,
                    constraints: BoxConstraints(minHeight: 130),
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10
                    ),
                    decoration: BoxDecoration(
                      color: color.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      cursorColor: color.primary,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: color.black
                      ),
                      decoration: const InputDecoration(
                        hintText: "Seputar bisnis anda",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
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
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20
                ),
                decoration: BoxDecoration(
                  color: color.primary,
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
