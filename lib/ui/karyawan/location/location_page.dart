// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/service/location_api.dart';
import 'package:flutter/material.dart';

import '../../../common/public_function.dart';
import '../../../model/location_api/kabupaten_model.dart';
import '../../../model/location_api/kecamatan_model.dart';
import '../../../model/location_api/kelurahan_model.dart';
import '../../../model/location_api/province_model.dart';
import '../../../service/api_service.dart';
import '../../bottom_navigation/bottom_navigation_karyawan.dart';

class LocationPage extends StatefulWidget {
  LocationPage({
    Key? key,
    required this.selectedImage,
    required this.dateString,
    required this.roleSelected,
    required this.descCompany,
    required this.selectedImageInSide,
    required this.selectedImageOutSide
  }) : super(key: key);
  File selectedImage;
  String dateString;
  String roleSelected;
  String descCompany;
  File selectedImageInSide;
  File selectedImageOutSide;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _isLoad = false;
  ProvinceModel? provinceModel;
  KabupatenModel? kabupatenModel;
  KecamatanModel? kecamatanModel;
  KelurahanModel? kelurahanModel;
  String? _selectedValueProvince;
  String? _selectedValueKabupaten;
  String? _selectedValueKecamatan;
  String? _selectedValueKelurahan;
  bool _dropdown1IsOn = false;
  bool _dropdown2IsOn = false;
  bool _dropdown3IsOn = false;
  String? id_kabupaten;
  String? id_kecamatan;
  String? id_kelurahan;
  String? addressResult;

  Future _getData() async {
    _isLoad = true;
    ProvinceModel province = await LocationApi().getProvince();
    setState(() {
      provinceModel = province;
    });
    print(province);
    _isLoad = false;
  }

  List<DropdownMenuItem<String>> get dropdownItemsProvince {
    List<DropdownMenuItem<String>> provinceItems = [
      for (int i = 0; i < provinceModel!.value!.length; i++)
        DropdownMenuItem(
          value: provinceModel!.value![i].name.toString(),
          child: Text(provinceModel!.value![i].name.toString()),
          onTap: () {
            setState(() {
              id_kabupaten = provinceModel!.value![i].id;
            });
          },
        )
    ];
    return provinceItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsKabupaten {
    List<DropdownMenuItem<String>> kabupatenItems = [
      for (int i = 0; i < kabupatenModel!.value!.length; i++)
        DropdownMenuItem(
          value: kabupatenModel!.value![i].name.toString(),
          child: Text(kabupatenModel!.value![i].name.toString()),
          onTap: () {
            setState(() {
              id_kecamatan = kabupatenModel!.value![i].id;
            });
          },
        )
    ];
    return kabupatenItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsKecamatan {
    List<DropdownMenuItem<String>> kecamatanItems = [
      for (int i = 0; i < kecamatanModel!.value!.length; i++)
        DropdownMenuItem(
          value: kecamatanModel!.value![i].name.toString(),
          child: Text(kecamatanModel!.value![i].name.toString()),
          onTap: () {
            setState(() {
              id_kelurahan = kecamatanModel!.value![i].id;
            });
          },
        )
    ];
    return kecamatanItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsKelurahan {
    List<DropdownMenuItem<String>> kelurahanItems = [
      for (int i = 0; i < kelurahanModel!.value!.length; i++)
        DropdownMenuItem(
            value: kelurahanModel!.value![i].name.toString(),
            child: Text(kelurahanModel!.value![i].name.toString()))
    ];
    return kelurahanItems;
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    showLoaderDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(backgroundColor: color.secondary),
            const SizedBox(width: 14),
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
        backgroundColor: color.background,
        appBar: AppBar(
          title: const Text('Lokasi Perusahaan'),
        ),
        body: _isLoad
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pilih Lokasi Perusahaan'),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 4,
                            height: 200,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: color.onBackground.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: double.maxFinite,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: DropdownButton<String>(
                                    value: _selectedValueProvince,
                                    hint: const Text('Provinsi'),
                                    isExpanded: true,
                                    icon: Container(
                                        alignment: Alignment.centerRight,
                                        child:
                                            const Icon(Icons.arrow_drop_down)),
                                    elevation: 18,
                                    style: TextStyle(color: color.black),
                                    underline: Container(
                                      height: 2,
                                      color: color.black.withOpacity(0.1),
                                    ),
                                    items: dropdownItemsProvince,
                                    onChanged: (String? value) {
                                      setState(() async {
                                        _selectedValueProvince = value!;
                                        if (_selectedValueProvince != null) {
                                          _selectedValueKabupaten = null;
                                          _dropdown1IsOn = false;
                                          _dropdown2IsOn = false;
                                          _dropdown3IsOn = false;
                                          KabupatenModel kabupaten =
                                              await LocationApi()
                                                  .getKabupaten(id_kabupaten!);
                                          setState(() {
                                            kabupatenModel = kabupaten;
                                          });
                                          print(kabupaten);
                                          _dropdown1IsOn = true;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                _dropdown1IsOn
                                    ? Container(
                                        height: 50,
                                        width: double.maxFinite,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: DropdownButton<String>(
                                          value: _selectedValueKabupaten,
                                          hint: const Text('Kabupaten/Kota'),
                                          isExpanded: true,
                                          icon: Container(
                                              alignment: Alignment.centerRight,
                                              child: const Icon(
                                                  Icons.arrow_drop_down)),
                                          elevation: 18,
                                          style: TextStyle(color: color.black),
                                          underline: Container(
                                            height: 2,
                                            color: color.black.withOpacity(0.1),
                                          ),
                                          items: dropdownItemsKabupaten,
                                          onChanged: (String? value) {
                                            setState(() async {
                                              _selectedValueKabupaten = value!;
                                              if (_selectedValueKabupaten !=
                                                  null) {
                                                _selectedValueKecamatan = null;
                                                _dropdown2IsOn = false;
                                                _dropdown3IsOn = false;
                                                KecamatanModel kecamatan =
                                                    await LocationApi()
                                                        .getKecamatan(
                                                            id_kecamatan!);
                                                setState(() {
                                                  kecamatanModel = kecamatan;
                                                });
                                                print(kecamatan);
                                                _dropdown2IsOn = true;
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    : LocationCard(
                                        title: 'Kabupaten/Kota',
                                      ),
                                _dropdown2IsOn
                                    ? Container(
                                        height: 50,
                                        width: double.maxFinite,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: DropdownButton<String>(
                                          value: _selectedValueKecamatan,
                                          hint: const Text('Kecamatan'),
                                          isExpanded: true,
                                          icon: Container(
                                              alignment: Alignment.centerRight,
                                              child: const Icon(
                                                  Icons.arrow_drop_down)),
                                          elevation: 18,
                                          style: TextStyle(color: color.black),
                                          underline: Container(
                                            height: 2,
                                            color: color.black.withOpacity(0.1),
                                          ),
                                          items: dropdownItemsKecamatan,
                                          onChanged: (String? value) {
                                            setState(() async {
                                              _selectedValueKecamatan = value!;
                                              if (_selectedValueKecamatan !=
                                                  null) {
                                                _selectedValueKelurahan = null;
                                                _dropdown3IsOn = false;
                                                KelurahanModel kelurahan =
                                                    await LocationApi()
                                                        .getKelurahan(
                                                            id_kelurahan!);
                                                setState(() {
                                                  kelurahanModel = kelurahan;
                                                });
                                                print(kelurahan);
                                                _dropdown3IsOn = true;
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    : LocationCard(title: 'Kecamatan'),
                                _dropdown3IsOn
                                    ? Container(
                                        height: 50,
                                        width: double.maxFinite,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: DropdownButton<String>(
                                          value: _selectedValueKelurahan,
                                          hint: const Text('Kelurahan/Desa'),
                                          isExpanded: true,
                                          icon: Container(
                                              alignment: Alignment.centerRight,
                                              child: const Icon(
                                                  Icons.arrow_drop_down)),
                                          elevation: 18,
                                          style: TextStyle(color: color.black),
                                          underline: Container(
                                            height: 2,
                                            color: color.black.withOpacity(0.1),
                                          ),
                                          items: dropdownItemsKelurahan,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedValueKelurahan = value!;
                                              addressResult = '$_selectedValueProvince, $_selectedValueKabupaten, $_selectedValueKecamatan, $_selectedValueKelurahan';
                                            });
                                          },
                                        ),
                                      )
                                    : LocationCard(title: 'Kelurahan/Desa'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      bottomNavigationBar: BottomAppBar(
        color: color.background,
        child: InkWell(
          onTap: () async {
            showLoaderDialog(context);
            bool isSuccess = await ApiService().postFillDataCompany(context, widget.selectedImage, widget.dateString, widget.roleSelected, addressResult!, widget.descCompany, widget.selectedImageInSide, widget.selectedImageOutSide);
            if(isSuccess == true){
              PublicFunction.navigatorPushAndRemoveUntil(context, KaryawanBottomNavigation(indexs: 0));
              showDialog(context: context, builder: (context) {
                return PublicFunction.showDialog(context, 'Melengkapi data sukses!');
              },);
            } else {
              showDialog(context: context, builder: (context) {
                Navigator.of(context).pop();
                return PublicFunction.showDialog(context, 'Gagal Melengkapi data');
              },);
            }
          },
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: color.primary,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text('Lanjutkan', style: TextStyle(color: color.white),),),
          ),
        ),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  LocationCard({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Container(
      height: 50,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: DropdownButton<String>(
        isExpanded: true,
        value: title,
        hint: Text(title),
        icon: Container(
            alignment: Alignment.centerRight,
            child: const Icon(Icons.arrow_drop_down)),
        elevation: 18,
        underline: Container(
          height: 2,
          color: color.black.withOpacity(0.1),
        ),
        style: TextStyle(color: color.black),
        iconSize: 30,
        onChanged: (value) {},
        items: const [],
      ),
    );
  }
}
