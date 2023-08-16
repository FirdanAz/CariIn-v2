// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../model/company/job_tag_list_model.dart';
import '../../../../model/company/profil_company_model.dart';
import '../../../../service/api_service.dart';

class CreateLowonganPage extends StatefulWidget {
  const CreateLowonganPage({Key? key}) : super(key: key);

  @override
  State<CreateLowonganPage> createState() => _CreateLowonganPageState();
}

class _CreateLowonganPageState extends State<CreateLowonganPage> {
  JobTagListModel? jobTagListModel;
  ProfilCompanyModel? profilCompanyModel;
  String selectedValue = "bebas";
  String selectedValueTime = "full time";
  String selectedValueTags = "1";
  bool _isLoad = false;
  File? selectedImage;
  File? compressSelectedImage;
  File? backdropImage;
  File? compressBackdropImage;
  final _formState = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _addressController = TextEditingController();
  final _salaryController = TextEditingController();
  final _minAgeController = TextEditingController();
  final _maxAgeController = TextEditingController();
  final _descriptionController = TextEditingController();


  List<DropdownMenuItem<String>> get genderDropdownItems {
    List<DropdownMenuItem<String>> menuItems = const[
      DropdownMenuItem(value: "bebas", child: Text("Bebas")),
      DropdownMenuItem(value: "pria", child: Text("Pria")),
      DropdownMenuItem(value: "wanita", child: Text("Wanita"))
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get timeTypeDropdownItems {
    List<DropdownMenuItem<String>> menuItems = const[
      DropdownMenuItem(value: "full time", child: Text("Full time")),
      DropdownMenuItem(value: "part time", child: Text("Part time")),
    ];
    return menuItems;
  }

  getData() async {
    _isLoad = true;
    JobTagListModel tagList = await ApiService().getTagList();
    ProfilCompanyModel companyModel = await ApiService().ProfilCompany();
    setState(() {
      jobTagListModel = tagList;
      profilCompanyModel = companyModel;
    });
    _isLoad = false;
  }

  Future _pickImageFromGalery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    return File(returnImage!.path);
  }

  Future _pickImageFromCamera() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);

    return File(returnImage!.path);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  List<DropdownMenuItem<String>> get dropdownItemsTags {
    List<DropdownMenuItem<String>> provinceItems = [
      for (int i = 0; i < jobTagListModel!.data.length; i++)
        DropdownMenuItem(
          value: jobTagListModel!.data[i].name.toString(),
          child: Text(jobTagListModel!.data[i].name.toString()),
        )
    ];
    return provinceItems;
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad ? const Scaffold(body: Center(child: CircularProgressIndicator(),), ) : Scaffold(
      appBar: AppBar(
        backgroundColor: color.background,
        title: const Text('Buat Lowongan'),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Form(
            key: _formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tambahkan Cover Foto',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Center(
                  child: InkWell(
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
                        },
                      );
                    },
                    child: selectedImage != null ? SizedBox(
                      height: 100,
                      width: 100,
                      child: InkWell(
                        child: Image.file(selectedImage!, fit: BoxFit.cover,)
                      ),
                    ):
                    Container(
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
                            // ignore: deprecated_member_use
                            child: Icon(Icons.add, color: color.primary,),
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Tambahkan Foto untuk latar belakang',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Center(
                  child: InkWell(
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
                                          Icon(Icons.window, color: color.primary,),
                                          const SizedBox(width: 15,),
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
                        },
                      );
                    },
                    child: backdropImage != null ? SizedBox(
                      height: 100,
                      width: 100,
                      child: InkWell(
                          child: Image.file(backdropImage!, fit: BoxFit.cover,)
                      ),
                    ):
                    Container(
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
                            // ignore: deprecated_member_use
                            child: Icon(Icons.add, color: color.primary,),
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                textFieldEx(title: 'Nama Lowongan', hint: 'Nama Lowongan', editingController: _namaController),
                textFieldEx(title: 'Alamat Lowongan', hint: 'Jl.Raya Jurang Jakarta', editingController: _addressController),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Text(
                      'Tipe waktu',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      height: 70,
                      width: double.maxFinite,
                      child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedValueTime,
                          icon: Container(
                              alignment: Alignment.centerRight,
                              child: const Icon(Icons.arrow_drop_down)),
                          elevation: 18,
                          underline: Container(
                            height: 2,
                            width: 1,
                            color: color.black.withOpacity(0.1),
                          ),
                          style:
                          TextStyle(color: color.black),
                          iconSize: 30,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              selectedValueTime = value!;
                            });
                          },
                          items: timeTypeDropdownItems
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gaji Perkiraan',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _salaryController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Data harus diisi";
                        }
                        return null;
                      },
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintStyle: const TextStyle(color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: color.secondary.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Gaji',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 5,),
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
                            width: 1,
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
                        items: genderDropdownItems,

                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Umur minimal',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _minAgeController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Data harus diisi";
                        }
                        return null;
                      },
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintStyle: const TextStyle(color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: color.secondary.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Umur',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Umur Maximal',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _maxAgeController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Data harus diisi";
                        }
                        return null;
                      },
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintStyle: const TextStyle(color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: color.secondary.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Umur',
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      width: double.maxFinite,
                      constraints: const BoxConstraints(minHeight: 130),
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
                        controller: _descriptionController,
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
                const SizedBox(height: 40,)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        child: InkWell(
          onTap: () async {

            compressSelectedImage = await PublicFunction.compressImage(selectedImage!, 50);
            compressBackdropImage = await PublicFunction.compressImage(backdropImage!, 50);

            bool isSuccess = await ApiService().postcreateLowongan(
              context,
              _namaController.text,
              compressSelectedImage!,
              compressBackdropImage!,
              _addressController.text,
              selectedValueTime,
              _salaryController.text,
              profilCompanyModel!.data!.id!.toString(),
              selectedValue,
              'bebas',
              _minAgeController.text,
              _maxAgeController.text,
              _descriptionController.text,
              [1,4,7],
              'true',
            );
            if(isSuccess == true){
              setState(() {
                Navigator.of(context).pop();
                showDialog(context: context, builder: (context) {
                  return PublicFunction.showDialog(context, 'Menunggu 1x24 Jam untuk dikonfirmasi oleh admin');
                },);
              });
            }
            else {
              showDialog(context: context, builder: (context) {
                return PublicFunction.showDialog(context, 'Lowongan Gagal dibuat');
              },);
            }
          },
          child: Container(
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: color.primary,
              borderRadius: BorderRadius.circular(10)
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 10
            ),
            child: Center(
              child: Text(
                'Buat Lowongan',
                style: TextStyle(
                  color: color.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class textFieldEx extends StatelessWidget {
  textFieldEx({Key? key, required this.title, required this.hint, required this.editingController}) : super(key: key);
  String title;
  String hint;
  TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18
          ),
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: editingController,
          validator: (value) {
            if(value!.isEmpty){
              return "Data harus diisi";
            }
            return null;
          },
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: const TextStyle(color: Colors.black45),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: color.secondary.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(10)),
            hintText: hint,
          ),
        ),
      ],
    );
  }
}

