// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/model/worker/worker_model.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/widget/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../service/edit_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  WorkerModel? workerModel;

  List<DropdownMenuItem<String>> items = getItems;

  bool _isLoad = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String? selectedOption;

  File? selectedImage;
  File? profileImageCompressed;

  bool? _companyVisible;
  bool _isSaved = false;

  getData() async {
    _isLoad = true;
    WorkerModel workerModels = await ApiService().getWorker();
    setState(() {
      workerModel = workerModels;
      _nameController.text = workerModels.data!.username!;
      selectedOption = workerModels.data!.status!;
      _emailController.text = workerModels.data!.email!;
      _companyVisible = workerModels.data!.companyVisible;
    });
    _isLoad = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profil', style: TextStyle(fontSize: 20),),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new, color: color.primary,),
          ),
        ),
        body: _isLoad ? const Center(child: CircularProgressIndicator(),) :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _changeProfile(),
                _textField(_nameController, 'Nama Pengguna', TextInputType.text, 'Nama Pengguna'),
                _statusKerja(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Tampilkan Profil untuk Perusahaan'),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey), // Warna border
                        borderRadius: BorderRadius.circular(30), // Sudut border
                      ),
                      child: ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('Tampilkan Profile'),
                        trailing: Switch(
                          value: _companyVisible!, // Ganti dengan status notifikasi saat ini
                          onChanged: (bool value) {
                            if(_companyVisible == true){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Konfirmasi Perubahan'),
                                    content: Text('Apakah Anda yakin mengubah perubahan? Setelah Tampilkan profil aktif perusahaan tidak bisa melihat profil anda di List karyawan perusahaan'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Tutup AlertDialog
                                        },
                                        child: Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            _companyVisible = value;
                                          });
                                        },
                                        child: Text('Ya, Konfirmasi'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            else {
                              if(workerModel!.data!.experiences!.isNotEmpty || workerModel!.data!.skills!.isNotEmpty){
                                setState(() {
                                  _companyVisible = true;
                                });
                              } else {
                                try {
                                  showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Diharapkan melengkapi Profile Terlebih dahulu!! Seperti Pengalalman, Keahlian dll'),);
                                } catch (e, s) {
                                  print(s);
                                }
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () async {
                if (selectedImage != null){
                  profileImageCompressed = await PublicFunction.compressImage(selectedImage!, 50, 'profile');
                  await ApiService().changeWorkerProfile(profileImageCompressed!);
                }
                bool success = false;
                success = await DataService().editUserName(_nameController.text);
                success = await DataService().editCompanyVisible(_companyVisible!);
                success = await DataService().editWorkerStatus(selectedOption!);
                if(success == true){
                  setState(() {
                    _isSaved = true;
                  });
                  Navigator.of(context).pop();
                  showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Profil Diubah'),);
                } else {
                  setState(() {
                    _isSaved = false;
                  });
                  showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Kesalahan Sistem'),);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(color.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text('Simpan Perubahan', style: TextStyle(color: color.white),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(TextEditingController controller, String hintText, TextInputType inputType, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ],
    );
  }

  Widget _statusKerja() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Status Kerja'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Warna border
            borderRadius: BorderRadius.circular(30), // Sudut border
          ),
          child: DropdownButtonFormField<String>(
            value: selectedOption,
            onChanged: (newValue) {
              setState(() {
                selectedOption = newValue!;
              });
            },
            items: items,
            decoration: InputDecoration(
              border: InputBorder.none, // Hapus border internal DropdownButtonFormField
            ),
          ),
        ),
      ],
    );
  }

  Widget _changeProfile() {
    var color = AppColor.theme(Theme.of(context).brightness);
    return CircleAvatar(
      backgroundColor: color.primary,
      radius: 60,
      child: selectedImage == null ?
      CircleAvatar(
        radius: 55,
        backgroundImage: NetworkImage('https://cariin.my.id/storage/${workerModel!.data!.profilImage}'),
        child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: color.primary,
              child: IconButton(
                onPressed: () {
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
                                  selectedImage =
                                  await _pickImageFromGalerys();
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
                                  selectedImage =
                                  await _pickImageFromCamera();
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
                icon: Icon(Icons.change_circle, color: color.white,),
              ),
            )
        ),
      ) :
      CircleAvatar(
        radius: 55,
        backgroundImage: FileImage(selectedImage!),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if(_isSaved == true){
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      return true;
    } else {
      return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Buang Perubahan'),
          content: const Text('Yakin untuk keluar? Perubahan Belum Disimpan'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Keluar'),
            ),
          ],
        ),
      )) ?? false;
    }
  }

}


List<DropdownMenuItem<String>> get getItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(
        value: 'tidak_bekerja',
        child: Text("Sedang Tidak Bekerja", style: TextStyle(fontWeight: FontWeight.w400),)),
    DropdownMenuItem(
        value: "bekerja",
        child: Text(
          "Sedang Bekerja",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
    ),
  ];
  return menuItems;
}