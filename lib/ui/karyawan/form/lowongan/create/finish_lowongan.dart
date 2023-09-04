// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:cariin_v2/ui/karyawan/form/syarat_ketentuan/page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/public_function.dart';
import '../../../../../model/company/profil_company_model.dart';

class FillFinishLowongan extends StatefulWidget {
  FillFinishLowongan(
      {Key? key,
      required this.title,
      required this.location,
      required this.timeType,
      required this.gender,
      required this.education,
      required this.workerAvailable,
      required this.salary,
      required this.ageMin,
      required this.ageMax,
      required this.pklStatus,
      required this.expDate})
      : super(key: key);
  String title;
  String location;
  String timeType;
  String gender;
  String education;
  String workerAvailable;
  String salary;
  String ageMin;
  String ageMax;
  bool pklStatus;
  String expDate;

  @override
  State<FillFinishLowongan> createState() => _FillFinishLowonganState();
}

class _FillFinishLowonganState extends State<FillFinishLowongan> {
  final _descriptionController = TextEditingController();

  ProfilCompanyModel? profilCompanyModel;
  bool _isLoad = false;

  File? selectedImage;
  File? compressSelectedImage;
  File? backdropImage;
  File? compressBackdropImage;

  getData() async {
    _isLoad = true;
    ProfilCompanyModel companyModel = await ApiService().ProfilCompany();
    setState(() {
      profilCompanyModel = companyModel;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.background,
        title: Row(
          children: [
            Text(widget.title,
                style: TextStyle(fontSize: 17, color: color.primary)),
            Expanded(
                child: Text('- Penyelesaian',
                    style: TextStyle(
                        fontSize: 17,
                        color: color.primary,
                        fontWeight: FontWeight.w600)))
          ],
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: _isLoad ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _pickImageForm(),
              _descTextField(),
              const SizedBox(
                height: 40,
              ),
              _nextButton(),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pickImageForm() {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cover Foto',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color.primary),
        ),
        const SizedBox(
          height: 5,
        ),
        _subtitleText(
            'Tambahkan Foto untuk Lowongan anda, Foto bisa(Foto Lowongan atau Foto Pekerjaan)',
            14,
            0.5),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Pilih Gambar dari'),
                  actions: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            selectedImage = await _pickImageFromGalery();
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
                                Icon(
                                  Icons.window,
                                  color: color.primary,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
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
                                Icon(
                                  Icons.camera,
                                  color: color.primary,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text('Kamera'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          },
          child: selectedImage != null
              ? SizedBox(
                  height: 100,
                  width: 100,
                  child: InkWell(
                      child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  )),
                )
              : Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: color.primary,
                  child: Center(
                      child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                        color: color.white,
                        borderRadius: BorderRadius.circular(10)),
                    // ignore: deprecated_member_use
                    child: Icon(
                      Icons.add,
                      color: color.primary,
                    ),
                  )),
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Foto Latar Belakang/Background',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color.primary),
        ),
        const SizedBox(
          height: 5,
        ),
        _subtitleText(
            'Foto latar belakang hanya digunakan untuk background saja (Opsional)',
            14,
            0.5),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Pilih Gambar dari'),
                  actions: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            backdropImage = await _pickImageFromGalery();
                            setState(() {
                              backdropImage;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.window,
                                  color: color.primary,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text('Galeri'),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            backdropImage = await _pickImageFromCamera();
                            setState(() {
                              backdropImage;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera,
                                  color: color.primary,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text('Kamera'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          },
          child: backdropImage != null
              ? SizedBox(
                  height: 100,
                  width: 100,
                  child: InkWell(
                      child: Image.file(
                    backdropImage!,
                    fit: BoxFit.cover,
                  )),
                )
              : Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: color.primary,
                  child: Center(
                      child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                        color: color.white,
                        borderRadius: BorderRadius.circular(10)),
                    // ignore: deprecated_member_use
                    child: Icon(
                      Icons.add,
                      color: color.primary,
                    ),
                  )),
                ),
        )
      ],
    );
  }

  Widget _descTextField() {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Deskripsi Lowongan',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color.primary),
        ),
        const SizedBox(
          height: 5,
        ),
        _subtitleText(
            'Deskripsi Lowongan meliputi Keterangan Pekerjaan Syarat dan ketentuan Perusahaan dll.',
            14,
            0.5),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(minHeight: 130),
          padding: const EdgeInsets.only(left: 15, right: 10),
          decoration: BoxDecoration(
              color: color.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            cursorColor: color.primary,
            controller: _descriptionController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: color.black),
            decoration: InputDecoration(
              hintText: "Seputar bisnis anda",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _pickImageFromGalery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    return File(returnImage!.path);
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    return File(returnImage!.path);
  }

  Widget _subtitleText(String subtitle, double fontSize, double opacity) {
    return Text(
      subtitle,
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontSize: fontSize, color: Colors.black.withOpacity(opacity)),
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
          if (selectedImage != null &&
              backdropImage != null &&
              _descriptionController.text.isNotEmpty) {
            showLoaderDialog(context);
            compressSelectedImage =
                await PublicFunction.compressImage(selectedImage!, 50, 'cover');
            compressBackdropImage = await PublicFunction.compressImage(
                backdropImage!, 50, 'backdrop');
            bool success = await ApiService().postcreateLowongan(
                context,
                widget.title,
                compressSelectedImage!,
                compressBackdropImage!,
                widget.location,
                widget.timeType,
                widget.salary,
                profilCompanyModel!.data!.id.toString(),
                widget.gender,
                widget.education,
                widget.ageMin,
                widget.ageMax,
                _descriptionController.text,
                [1, 4, 7],
                widget.pklStatus.toString(),
                widget.expDate,
                widget.workerAvailable
            );
            Navigator.of(context).pop();
            if (success == true) {
              setState(() {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(indexs: 2),), (route) => false);
                showDialog(
                  context: context,
                  builder: (context) {
                    return PublicFunction.showDialog(context,
                        'Menunggu 1x24 Jam untuk dikonfirmasi oleh admin');
                  },
                );
              });
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return PublicFunction.showDialog(
                      context, 'Lowongan Gagal dibuat');
                },
              );
            }
          } else {
            showDialog(
              context: context,
              builder: (context) =>
                  PublicFunction.showDialog(context, 'Semua kolom harus diisi'),
            );
          }
        },
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            backgroundColor: MaterialStatePropertyAll(color.primary)),
        child: Text(
          'Buat Lowongan',
          style: TextStyle(color: color.white),
        ),
      ),
    );
  }
}
