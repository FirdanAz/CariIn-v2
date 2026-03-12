// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/view_image/view_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/public_function.dart';
import '../../../../../model/worker/experience/experience_list.dart';
import '../../../../../service/api_service.dart';

class CreateExperiencePage extends StatefulWidget {
  const CreateExperiencePage({Key? key}) : super(key: key);

  @override
  State<CreateExperiencePage> createState() => _CreateExperiencePageState();
}

class _CreateExperiencePageState extends State<CreateExperiencePage> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descController = TextEditingController();

  File? selectedImage;
  File? compressSelectedImage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String dateString = 'Pilih Tanggal';
  String dateLastString = 'Pilih Tanggal';

  String? statusWorker;
  bool _isLoad = false;

  getDataApi() async {
    _isLoad = true;
    await ApiService().RefreshToken('worker', await PublicFunction.getToken('worker'));
    var status = await DataService().getWorkerStatus();
    setState(() {
      statusWorker = status;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataApi();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad ? Scaffold(body: Container(),) : Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengalaman' , style: TextStyle(color: color.primary, fontSize: 18, fontWeight: FontWeight.w500),),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _form(),
              _nextButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _textField(_titleController, 'Judul', TextInputType.text, 'Judul Pengalaman', 'Isi judul pengalaman dengan sesuai'),
          _pickDate('Tanggal Masuk Kerja', 'Tanggal Pengalaman ketika masuk Kerja', true),
          statusWorker == 'bekerja' ? Container() : _pickDate('Tanggal Keluar Kerja', 'Tanggal Pengalaman ketika keluar/berhenti dari pekerjaan', false),
          const SizedBox(height: 10,),
          _textField(_locationController, 'Jakarta Utara, Blok c', TextInputType.text, 'Lokasi Pengalaman', ''),
          const SizedBox(height: 10,),
          _descTextField(),
          _pickImage()
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: SizedBox(
        width: double.maxFinite,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            if(_formKey.currentState!.validate()){
              if(selectedImage != null) {
                showLoaderDialog(context);
                compressSelectedImage = await PublicFunction.compressImage(selectedImage!, 50, 'gambar pengalaman');
                bool success = await DataService().createExperience(_titleController.text, dateString, dateLastString != 'Pilih Tanggal' ? dateLastString : '', _locationController.text, _descController.text, compressSelectedImage!);
                if(success == true){
                  ListExperienceModel experienceModel =
                  await DataService().getListExperience();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(experienceModel);
                  showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Pengalaman Ditambahkan!!'),);
                } else {
                  showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Ada Kesalahan Sistem!!'),);
                }
              }
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
      ),
    );
  }

  Widget _pickDate(String title, String subtitle, bool isFirst) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color.primary),
        ),
        const SizedBox(
          height: 5,
        ),
        subtitle != '' ? _subtitleText(subtitle, 14, 0.5) : Container(),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), //get today's date
                firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime.now());

            if (pickedDate != null) {
              if(isFirst == true){
                setState(() {
                  dateString = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                });
              } else if(isFirst == false){
                setState(() {
                  dateLastString = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                });
              }
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
                isFirst ? dateString : dateLastString,
                style: TextStyle(
                    color: color.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ),
        ),
      ],
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

  Widget _textField(TextEditingController controller, String hintText,
      TextInputType inputType, String title, String subtitle) {
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
        subtitle != '' ? _subtitleText(subtitle, 14, 0.5) : Container(),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          autocorrect: true,
          validator: (value) => PublicFunction.validateInput(value.toString()),
          controller: controller,
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.black),
          keyboardType: inputType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: const TextStyle(color: Colors.black45),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: color.secondary.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(10)),
            hintText: hintText,
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget _descTextField() {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color.primary),
        ),
        const SizedBox(
          height: 5,
        ),
        _subtitleText('deskripsi Pengalaman atau alasan yang pernah menjadikan pekerjaan ini sebagai pengalaman', 14, 0.5),
        const SizedBox(
          height: 5,
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
            controller: _descController,
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

  Widget _pickImage() {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Text(
          'Gambar Pengalaman',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color.primary),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.maxFinite,
          height: 150,
          decoration: BoxDecoration(
            color: color.black.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20)
            )
          ),
          child: selectedImage != null ?
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewLocalImagePage(title: 'Gambar Pengalaman', imageFile: selectedImage!),));
            },
            child: Image.file(selectedImage!, fit: BoxFit.cover,)
          ) :
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(AppAssets.appsLogo, color: color.black.withOpacity(0.6),),
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
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
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(color.primary),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))))
            ),
            child: Text('Pilih Gambar', style: TextStyle(color: color.white),),
          ),
        )
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

}
