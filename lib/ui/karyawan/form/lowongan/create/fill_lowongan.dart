// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:math';

import 'package:cariin_v2/ui/karyawan/form/lowongan/create/finish_lowongan.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/public_function.dart';

class FillLowongan extends StatefulWidget {
  FillLowongan(
      {Key? key,
      required this.title,
      required this.location,
      required this.timeType,
      required this.gender,
      required this.education,
      required this.workerAvailable})
      : super(key: key);
  String title;
  String location;
  String timeType;
  String gender;
  String education;
  String workerAvailable;

  @override
  State<FillLowongan> createState() => _FillLowonganState();
}

class _FillLowonganState extends State<FillLowongan> {
  List<DropdownMenuItem<String>> salary = getSalaryDropdownItems;
  List<DropdownMenuItem<String>> ageMin = getAgeMinDropdownItems;
  List<DropdownMenuItem<String>> ageMax = getAgeMaxDropdownItems;
  List<DropdownMenuItem<String>> pkl = getPklDropdownItems;

  String selectedSalary = '0';
  String selectedAge = '17';
  String selectedMaxAge = '0';
  String selectedPKL = 'false';
  bool pklStatus = false;

  String dateString = 'Pilih Tanggal';
  String dateValue = '';
  DateTime dateTime = DateTime.now();
  String date =
      '${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().second}';

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.background,
        title: Row(
          children: [
            const Text(
              'Buat Lowo...',
              style: TextStyle(fontSize: 17),
            ),
            Expanded(
                child: Text(widget.title,
                    style: TextStyle(fontSize: 17, color: color.primary)))
          ],
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dropDown(
                'Gaji(*Perkiraan)',
                'Gaji perkiraan akan ditampikan setiap Pelamar sedang mencari lowongan',
                SizedBox(
                  height: 70,
                  width: double.maxFinite,
                  child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedSalary,
                      icon: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.arrow_drop_down)),
                      elevation: 18,
                      underline: Container(
                        height: 2,
                        width: 1,
                        color: color.black.withOpacity(0.1),
                      ),
                      style: TextStyle(color: color.black),
                      iconSize: 30,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          selectedSalary = value!;
                        });
                      },
                      items: salary),
                ),
              ),
              _dropDown(
                'Umur Minimal',
                'Umur Minimal(Wajib Diisi) digunakan untuk mencari karyawan yang sesuai',
                SizedBox(
                  height: 70,
                  width: double.maxFinite,
                  child: DropdownButton<String>(
                      itemHeight: 50,
                      isExpanded: true,
                      value: selectedAge,
                      onChanged: (newValue) {
                        setState(() {
                          selectedAge = newValue!;
                        });
                      },
                      icon: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.arrow_drop_down)),
                      style: TextStyle(color: color.black),
                      items: ageMin),
                ),
              ),
              _dropDown(
                'Umur Maximal (Opsional)',
                'Umur Maximal(Tidak Wajib Diisi) digunakan untuk mencari karyawan yang sesuai',
                SizedBox(
                  height: 70,
                  width: double.maxFinite,
                  child: DropdownButton<String>(
                      itemHeight: 50,
                      isExpanded: true,
                      value: selectedMaxAge,
                      onChanged: (newValue) {
                        setState(() {
                          selectedMaxAge = newValue!;
                        });
                      },
                      icon: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.arrow_drop_down)),
                      style: TextStyle(color: color.black),
                      items: ageMax),
                ),
              ),
              _dropDown(
                'Opsi Praktik Kerja Lowongan(PKL)',
                'Apakah Pekerjaan ini Menerima Lamaran PKL? Jika iya, Pilih opsi "Menerima" untuk Membuat Lowongan PKL',
                SizedBox(
                  height: 70,
                  width: double.maxFinite,
                  child: DropdownButton<String>(
                      itemHeight: 50,
                      isExpanded: true,
                      value: selectedPKL,
                      onChanged: (newValue) {
                        setState(() {
                          selectedPKL = newValue!;
                        });
                        if (selectedPKL == 'true') {
                          pklStatus = true;
                        } else if (selectedPKL == 'false') {
                          pklStatus = false;
                        }
                      },
                      icon: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.arrow_drop_down)),
                      style: TextStyle(color: color.black),
                      items: pkl),
                ),
              ),
              Text(
                'Tanggal Kaldaluarsa Lowongan',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color.primary),
              ),
              _subtitleText(
                  'Pilih Tanggal Kaldaluarsa (Lowongan otomatis NonAktif ketika sudah masuk tanggal Kaldaluarsa)',
                  14,
                  0.5),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: dateTime, //get today's date
                      firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    setState(() {
                      dateTime = pickedDate;
                      dateValue = pickedDate.toString();
                      dateString = GetTimeAgo.parse(pickedDate);
                    });
                  }
                },
                child: Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: color.primary, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      dateString,
                      style: TextStyle(
                          color: color.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              _nextButton(),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _subtitleText(String subtitle, double fontSize, double opacity) {
    return Text(
      subtitle,
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontSize: fontSize, color: Colors.black.withOpacity(opacity)),
    );
  }

  Widget _dropDown(String title, String subTitle, Widget widget) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color.primary),
        ),
        const SizedBox(
          height: 5,
        ),
        subTitle != '' ? _subtitleText(subTitle, 14, 0.5) : Container(),
        widget
      ],
    );
  }

  Widget _nextButton() {
    showLoaderDialog(BuildContext context) {
      var color = AppColor.theme(Theme.of(context).brightness);
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

    var color = AppColor.theme(Theme.of(context).brightness);
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (selectedPKL == 'false') {
            setState(() {
              pklStatus = false;
            });
          } else {
            setState(() {
              pklStatus = true;
            });
          }
          if (dateString != 'Pilih Tanggal') {
            showLoaderDialog(context);
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).pop();
            PublicFunction.navigatorPush(
                context,
                FillFinishLowongan(
                    title: widget.title,
                    location: widget.location,
                    timeType: widget.timeType,
                    gender: widget.gender,
                    education: widget.education,
                    workerAvailable: widget.workerAvailable,
                    salary: selectedSalary,
                    ageMin: selectedAge,
                    ageMax: selectedMaxAge,
                    pklStatus: pklStatus,
                    expDate: dateValue));
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Pilih Tanggal Kaldaluarsa',
                      style: TextStyle(fontSize: 15),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              setState(() {
                                dateValue = pickedDate.toString();
                                dateString =
                                    '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                              });
                            }
                          },
                          child: const Text('Pilih'))
                    ],
                  );
                });
          }
        },
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            backgroundColor: MaterialStatePropertyAll(color.primary)),
        child: Text(
          'Lanjutkan',
          style: TextStyle(color: color.white),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get getSalaryDropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: "0", child: Text("Tidak Menampilkan")),
    DropdownMenuItem(value: "1000000", child: Text("Rp.1.000.000")),
    DropdownMenuItem(value: "3000000", child: Text("Rp.3.000.000")),
    DropdownMenuItem(value: "5000000", child: Text("Rp.5.000.000")),
    DropdownMenuItem(value: "20000000", child: Text("Rp.20.000.000")),
    DropdownMenuItem(value: "50000000", child: Text("Rp.50.000.000")),
    DropdownMenuItem(value: "100000000", child: Text("Rp.100.000.000")),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get getPklDropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(
        value: 'false',
        child: Text("Tidak Menerima(PKL) Praktik Kerja Lapangan")),
    DropdownMenuItem(
        value: "true",
        child: Text(
          "Menerima(PKL) Praktik Kerja Lapangan",
          style: TextStyle(color: Colors.green),
        )),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get getAgeMinDropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: "17", child: Text("17 Tahun")),
    DropdownMenuItem(value: "18", child: Text("18 Tahun")),
    DropdownMenuItem(value: "19", child: Text("19 Tahun")),
    DropdownMenuItem(value: "20", child: Text("20 Tahun")),
    DropdownMenuItem(value: "21", child: Text("21 Tahun")),
    DropdownMenuItem(value: "22", child: Text("22 Tahun")),
    DropdownMenuItem(value: "23", child: Text("23 Tahun")),
    DropdownMenuItem(value: "24", child: Text("24 Tahun")),
    DropdownMenuItem(value: "25", child: Text("25 Tahun")),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get getAgeMaxDropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: "0", child: Text("Tidak Terbatas")),
    DropdownMenuItem(value: "25", child: Text("25 Tahun")),
    DropdownMenuItem(value: "26", child: Text("26 Tahun")),
    DropdownMenuItem(value: "27", child: Text("27 Tahun")),
    DropdownMenuItem(value: "28", child: Text("28 Tahun")),
    DropdownMenuItem(value: "29", child: Text("29 Tahun")),
    DropdownMenuItem(value: "30", child: Text("30 Tahun")),
    DropdownMenuItem(value: "31", child: Text("31 Tahun")),
    DropdownMenuItem(value: "32", child: Text("32 Tahun")),
    DropdownMenuItem(value: "33", child: Text("33 Tahun")),
    DropdownMenuItem(value: "34", child: Text("34 Tahun")),
    DropdownMenuItem(value: "35", child: Text("35 Tahun")),
    DropdownMenuItem(value: "36", child: Text("36 Tahun")),
    DropdownMenuItem(value: "37", child: Text("37 Tahun")),
    DropdownMenuItem(value: "38", child: Text("38 Tahun")),
    DropdownMenuItem(value: "39", child: Text("39 Tahun")),
    DropdownMenuItem(value: "40", child: Text("40 Tahun")),
  ];
  return menuItems;
}
