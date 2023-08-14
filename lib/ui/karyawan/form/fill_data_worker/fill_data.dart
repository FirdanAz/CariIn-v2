// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/model/worker/skill_list_model.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/widget/auth_text_field.dart';
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../common/app_color.dart';
import '../../../../service/api_service.dart';

class FillDataWorker extends StatefulWidget {
  const FillDataWorker({Key? key}) : super(key: key);

  @override
  State<FillDataWorker> createState() => _FillDataWorkerState();
}

class _FillDataWorkerState extends State<FillDataWorker> {
  File? profileImage;
  SkillListModel? skillListModel;
  bool _isLoad = false;
  final _nameController = TextEditingController();

  getdata() async {
    _isLoad = true;
    SkillListModel model = await ApiService().ListSkillsWorker();
    setState(() {
      skillListModel = model;
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
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return IntroductionScreen(
      showBackButton: true,
      showNextButton: profileImage == null ? false : true,
      showSkipButton: false,
      showDoneButton: true,
      back: const Text("Kembali"),
      done: const Text("Selesai"),
      next: const Text('Lanjut'),
      dotsFlex: 1,
      nextFlex: 1,
      dotsDecorator: const DotsDecorator(
          size: Size(8, 8),
          color: Colors.grey,
          activeSize: Size(30, 8),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
      onDone: () async {
        if(profileImage != null){
          bool isSucces = await ApiService().changeWorkerProfile(profileImage!);
          if(isSucces == true){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CustomBottomNavigation(),), (route) => false);
            showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Sukses Melengkapi Profile!'),);
          } else{
            showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Gagal Melengkapi Profile!'),);
          }
        } else {
          showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Isi Gambar!'),);
        }
      },
      pages: [
        PageViewModel(
            decoration: PageDecoration(
                bodyAlignment: Alignment.center, pageColor: color.background),
            titleWidget: Center(
              child: Column(
                children: [
                  profileImage == null
                      ? InkWell(
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
                                            profileImage =
                                                await _pickImageFromGalerys();
                                            setState(() {
                                              profileImage;
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
                                            profileImage =
                                                await _pickImageFromCamera();
                                            setState(() {
                                              profileImage;
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
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: color.primary,
                            child: const CircleAvatar(
                              radius: 95,
                              backgroundImage: NetworkImage(
                                  'https://air.eng.ui.ac.id/images/5/55/Background_Merah_3x4.jpg'),
                            ),
                          ),
                        )
                      : InkWell(
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
                                            profileImage =
                                                await _pickImageFromGalerys();
                                            setState(() {
                                              profileImage;
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
                                            profileImage =
                                                await _pickImageFromCamera();
                                            setState(() {
                                              profileImage;
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
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: color.primary,
                            child: CircleAvatar(
                              radius: 95,
                              backgroundImage: FileImage(profileImage!),
                            ),
                          ),
                        ),
                  profileImage == null
                      ? const SizedBox(
                          height: 10,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  profileImage == null ? const Text('(Contoh)') : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Pilih Gambar',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Pilih Gambar dengan background berwarna(merah/biru) dan memperlihatkan wajah dengan jelas',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: color.black),
                    ),
                  )
                ],
              ),
            ),
            bodyWidget: Container()),
        PageViewModel(
            titleWidget: _isLoad
                ? ShimmerPelamar(itemCount: 3,)
                : skillListModel!.data!.isEmpty ? const Center(child: Text('Data Kosong'),) : ListView.builder(
                    shrinkWrap: true,
                    itemCount: skillListModel!.data!.length,
                    itemBuilder: (context, index) {
                      var data = skillListModel!.data![index];
                      return Container(
                          decoration: BoxDecoration(
                              color: color.primaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.maxFinite,
                          height: 75,
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          data.name!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: const Text(
                                          'Sertifikasi',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text('Yakin untuk menghapush ${data.name}?', style: TextStyle(color: color.black, fontSize: 15),),
                                          actions: [
                                            ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
                                            ElevatedButton(
                                              onPressed: () async {
                                                bool isDeleted = await ApiService().deleteSkills(data.id!.toString());
                                                if(isDeleted == true){
                                                  Navigator.of(context).pop();
                                                  showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Skill dihapus'),);
                                                  setState(() {
                                                    getdata();
                                                  });
                                                }
                                              },
                                              child: Text('Hapus', style: TextStyle(color: color.error),),
                                            )
                                          ],
                                        );
                                      },);
                                    },
                                    child: Icon(Icons.delete, color: color.primary,),
                                  ),
                                )
                              ]
                          )
                      );
                    },
                  ),
            bodyWidget: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Nama Skill',
                              style: TextStyle(color: color.primary),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldComp(
                                emailController: _nameController,
                                hintText: 'Nama Skills',
                                textInputType: TextInputType.text),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if(_nameController.text.isNotEmpty){
                              bool isSucces = await ApiService().addSkillsWorker(_nameController.text);
                              if(isSucces == true){
                                Navigator.of(context).pop();
                                showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Skill Ditambahkan'),);
                                setState(() {
                                  _nameController.text = '';
                                  getdata();
                                });
                              }
                            }
                          },
                          child: Text('Tambah')
                        )
                      ],
                    );
                  },
                );
              },
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Container(
                width: double.maxFinite,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  'Tambah Skil',
                  style: TextStyle(color: color.white),
                )),
              ),
            ))
      ],
    );
  }
}
