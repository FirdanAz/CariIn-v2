// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/app_color.dart';
import '../../widget/auth_text_field.dart';

class FillDataWorker extends StatefulWidget {
  const FillDataWorker({Key? key}) : super(key: key);

  @override
  State<FillDataWorker> createState() => _FillDataWorkerState();
}

class _FillDataWorkerState extends State<FillDataWorker> {
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _interestedController = TextEditingController();
  String selectedValue = "pria";
  String dateString = 'Pilih Tanggal';
  File? selectedImage;
  File? compressedSelectedImage;
  bool obsText = true;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "pria", child: Text("  Pria")),
      DropdownMenuItem(value: "wanita", child: Text("  Wanita")),
    ];
    return menuItems;
  }

  Future _pickImageFromGalerys() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    return File(returnImage!.path);
  }

  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);

    return File(returnImage!.path);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lengkapi Data',
                  style: TextStyle(
                      color: color.primary,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                _subtitleText('Untuk melamar pekerjaan lengkapi profilmu dulu yuk..', 16, 1),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Foto Profile',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: color.primary),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Pilih Gambar dari'),
                                        actions: [
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  selectedImage = await _pickImageFromGalerys();
                                                  setState(() {
                                                    selectedImage;
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets.all(15),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.window, color: color.primary,),
                                                      const SizedBox(width: 15,),
                                                      const Text('Galeri'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  selectedImage = await _pickImageFromCamera();
                                                  setState(() {
                                                    selectedImage;
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets.all(15),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.camera, color: color.primary,),
                                                      const SizedBox(width: 15,),
                                                      const Text('Kamera'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },);
                                  },
                                  child: selectedImage == null ? Container(
                                      height: 100,
                                      width: 100,
                                      color: color.primaryContainer,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        child: Icon(
                                          Icons.add,
                                          color: color.primary,
                                        ),
                                      )) : SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.file(selectedImage!, fit: BoxFit.cover,),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  'Alamat',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: color.primary),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComp(
                    emailController: _addressController, hintText: 'Cth : Kudus, Jawa Tengah, Indonesia', textInputType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Jenis Kelamin',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: color.primary),
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
                    style: TextStyle(color: color.black),
                    iconSize: 30,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                    items: dropdownItems,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Minat Bidang',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: color.primary),
                ),
                const SizedBox(
                  height: 2,
                ),
                _subtitleText('Bidang yang diisi akan ditampilkan diprofil anda', 14, 0.5),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComp(emailController: _interestedController, hintText: 'Cth : Programmer', textInputType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nomor Telepon',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: color.primary),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComp(
                  emailController: _phoneNumberController,
                  hintText: 'Cth : 0868646444',
                  textInputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Tanggal Lahir',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: color.primary),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      setState(() {
                        dateString =
                        '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
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
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin:
                  const EdgeInsets.symmetric(vertical: 50),
                  decoration: BoxDecoration(
                      color: color.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                      onTap: () async {
                        if(selectedImage != null && _addressController.text.isNotEmpty && _interestedController.text.isNotEmpty && _phoneNumberController.text.isNotEmpty && dateString.isNotEmpty) {
                          showLoaderDialog(context);
                          compressedSelectedImage = await PublicFunction.compressImage(selectedImage!, 50, 'Profile Pengguna');
                          bool success = await ApiService().postFillDataWorker(context, compressedSelectedImage!, selectedValue, _phoneNumberController.text, dateString, _addressController.text, _interestedController.text);
                          if(success == true){
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CustomBottomNavigation(indexs: 0),), (route) => false);
                          } else {
                            showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Formulir yang anda isikan Sudah ada di Aplikasi!'),);
                          }
                        } else {
                          showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Isi Formulis dengan Lengkap'),);
                        }
                      },
                      child: Center(
                        child: Text(
                          'Lanjutkan',
                          style: TextStyle(
                              color: color.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _subtitleText(String subtitle, double fontSize, double opacity) {
    return Text(
      subtitle,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: fontSize, color: Colors.black.withOpacity(opacity)),
    );
  }
}
