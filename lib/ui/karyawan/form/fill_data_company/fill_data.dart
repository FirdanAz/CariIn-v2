// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/karyawan/location/location_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/app_color.dart';

class FillDataCompany extends StatefulWidget {
  const FillDataCompany({Key? key}) : super(key: key);

  @override
  State<FillDataCompany> createState() => _FillDataCompanyState();
}

class _FillDataCompanyState extends State<FillDataCompany> {
  File? selectedImage;
  File? selectedImageInSide;
  File? compressedSelectedImageInSide;
  File? selectedImageOutSide;
  File? compressedSelectedImageOutSide;
  double indicatorValue = 0.1;
  int percentValue = 10;
  String dateString = 'Pilih Tanggal';
  int selectedRole = 0;
  final _descriptionController = TextEditingController();
  String compressedImagePath = '/storage/emulated/0/Download/';
  String date = '${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().second}';

  final _numberToRoleMap = {0: 'pemilik', 1: 'pengelola', 2: 'HRD'};

  Future _pickImageFromGalery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final file = await FlutterImageCompress.compressAndGetFile(
        returnImage!.path,
        '$compressedImagePath/Cariin_$date.jpg',
        quality: 50
    );

    setState(() {
      selectedImage = File(file!.path);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Container(
                width: double.maxFinite,
                constraints: const BoxConstraints(minHeight: 500),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImageFromGalery();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 40),
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _pickImageFromGalery();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ganti'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  indicatorValue = 0.2;
                                  percentValue = 20;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('Pilih'),
                            ),
                          ],
                        )
                      ],
                    )),
              )
            ],
          );
        },
      );
    });
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
      backgroundColor: color.background,
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Lengkapi Data',
                style: TextStyle(
                    color: color.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                'Lengkapi data perusahaanmu',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tambahkan Logo Perusahaan (Max 5mb)',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.black),
              ),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: selectedImage != null
                      ? color.white
                      : color.primaryContainer,
                  child: Center(
                      child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    Container(
                                      width: double.maxFinite,
                                      constraints:
                                          const BoxConstraints(minHeight: 500),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      alignment: Alignment.center,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _pickImageFromGalery();
                                          },
                                          child: selectedImage == null
                                              ? Container(
                                                  color: color.primaryContainer,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: const Text(
                                                      'Pilih Gambar'),
                                                )
                                              : Column(
                                                  children: [
                                                    Container(
                                                      width: double.maxFinite,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 40),
                                                      child: Image.file(
                                                          selectedImage!,
                                                          fit: BoxFit.cover),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            selectedImage =
                                                                null;
                                                            setState(() {
                                                              selectedImage =
                                                                  selectedImage;
                                                              percentValue = 10;
                                                              indicatorValue =
                                                                  0.1;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Hapus',
                                                            style: TextStyle(
                                                                color: color
                                                                    .error),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            _pickImageFromGalery();
                                                          },
                                                          child: const Text(
                                                              'Ganti'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: selectedImage == null
                              ? Icon(
                                  Icons.add,
                                  color: color.primary,
                                )
                              : SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ))),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Foto tampak Dalam/Luar',
                          style: TextStyle(
                              color: color.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Foto akan ditampilkan setiap lowongan pekerja',
                          style: TextStyle(
                            color: color.black.withOpacity(0.6),
                            fontSize: 14,
                          ),
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
                                                        selectedImageInSide = await _pickImageFromGalerys();
                                                        setState(() {
                                                          selectedImageInSide;
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
                                                        selectedImageInSide = await _pickImageFromCamera();
                                                        setState(() {
                                                          selectedImageInSide;
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
                                        child: selectedImageInSide == null ? Container(
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
                                          child: Image.file(selectedImageInSide!, fit: BoxFit.cover,),
                                        )
                                      ),
                                      const Text('Tampak Dalam')
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
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
                                                          selectedImageOutSide = await _pickImageFromGalerys();
                                                          setState(() {
                                                            selectedImageOutSide;
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
                                                          selectedImageOutSide = await _pickImageFromCamera();
                                                          setState(() {
                                                            selectedImageOutSide;
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
                                          child: selectedImageOutSide == null ? Container(
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
                                            child: Image.file(selectedImageOutSide!, fit: BoxFit.cover,),
                                          )
                                      ),
                                      const Text('Tampak Luar')
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Pembuatan',
                    style: TextStyle(
                        color: color.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Tanggal pembuatan perusahaan',
                    style: TextStyle(
                      color: color.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sebagai',
                style: TextStyle(
                    color: color.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
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
                  selectedTextStyle: TextStyle(color: color.primary),
                  unselectedTextStyle: TextStyle(color: color.white),
                  buttons: const ["Pemilik", "Pengelola", "HRD"],
                  selectedButtons: const [0],
                  onSelected: (int index, bool isSelected) {
                    if (kDebugMode) {
                      print('${_numberToRoleMap[index]} is selected');
                    }
                    setState(() {
                      selectedRole = index;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Deskripsi perusahaan',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: color.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    constraints: const BoxConstraints(minHeight: 130),
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    decoration: BoxDecoration(
                        color: color.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: color.black.withOpacity(0.2))),
                    child: TextField(
                      controller: _descriptionController,
                      cursorColor: color.primary,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: color.black),
                      decoration: InputDecoration(
                        hintText: "Seputar bisnis anda",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: color.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: double.maxFinite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                    onTap: () async {
                      if(selectedImage != null || selectedImageInSide != null || selectedImageOutSide != null || _descriptionController.text.isNotEmpty){
                        compressedSelectedImageInSide = await PublicFunction.compressImage(selectedImageInSide!, 50, 'inside');
                        compressedSelectedImageOutSide = await PublicFunction.compressImage(selectedImageOutSide!, 50, 'outside');
                        showLoaderDialog(context);
                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage(selectedImage: selectedImage!, dateString: dateString, roleSelected: _numberToRoleMap[selectedRole].toString(), descCompany: _descriptionController.text, selectedImageInSide: compressedSelectedImageInSide!, selectedImageOutSide: compressedSelectedImageOutSide!),));
                      } else {
                        showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Data tidak boleh kosong'),);
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
            ])),
      ),
    );
  }
}
