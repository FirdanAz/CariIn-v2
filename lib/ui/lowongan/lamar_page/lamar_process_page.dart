// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/model/worker/worker_model.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/service/firebase_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';
import '../../../model/worker/cv.dart';
import '../../bottom_navigation/bottom_navigation.dart';

// ignore: must_be_immutable
class LamarProcessPage extends StatefulWidget {
  LamarProcessPage({Key? key, required this.title, required this.jobId, required this.companyId})
      : super(key: key);
  String title;
  int jobId;
  int companyId;

  @override
  State<LamarProcessPage> createState() => _LamarProccesPageState();
}

class _LamarProccesPageState extends State<LamarProcessPage> {
  final _descriptionController = TextEditingController();
  File? cvFile;
  MyCvModel? myCvModel;
  WorkerModel? workerDetailModel;
  bool _isLoad = false;
  String? deviceToken;

  getData() async {
    _isLoad = true;
    WorkerModel model = await ApiService().getWorker();
    String token = await EditService().getCompanyDevice(widget.companyId.toString());
    setState(() {
      workerDetailModel = model;
      deviceToken = token;
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
      backgroundColor: color.background,
      appBar: AppBar(
        backgroundColor: color.background,
        title: Row(
          children: [
            const Text(
              'Lamar ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: color.primary,
                  fontSize: 18),
            )
          ],
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _isLoad ? const Center(child: CircularProgressIndicator(),) : Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: _isLoad ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            mainAxisAlignment: _isLoad ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Text(
                'Persiapkan CV mu sebelum melamar!',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: color.onSurface),
              ),
              Text(
                'CV yang lengkap dapat membantu kamu menjadi kandidat ungguilan. Silahkan review CV mu dan lengkapi sekarang!',
                style: TextStyle(fontSize: 15, color: color.onSurface),
              ),
              cvFile != null ? Container() : Container(
                margin: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 100),
                      decoration: BoxDecoration(
                        color: color.white,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: color.primaryContainer.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset:
                                const Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: SvgPicture.asset(
                              AppAssets.filterIcon,
                              // ignore: deprecated_member_use
                              color: color.primary,
                              height: 30,
                            ),
                          ),
                          Container(
                            width: 250,
                            margin: const EdgeInsets.only(top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Isi Formulir dengan baik!',
                                    style: TextStyle(
                                        color: color.onPrimaryContainer,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15)),
                                Text(
                                    'Pilih CV mu untuk melanjutkan lamaran perkerjaan.',
                                    style: TextStyle(
                                        color: color.onPrimaryContainer,
                                        fontSize: 13)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Pilih Cv Sekarang',
                                    style: TextStyle(
                                        color: color.primary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                'Tambah CV mu',
                style: TextStyle(
                    color: color.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Buat Cvmu secara otomatis atau buatan sendiri',
                style: TextStyle(
                  color: color.black.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: () async {
                  File files = await PublicFunction.getPdf(workerDetailModel!.data!.id!, workerDetailModel!.data!.username!, workerDetailModel!.data!.interested!, workerDetailModel!.data!.age!.toString(), workerDetailModel!.data!.address!, '08677281920', workerDetailModel!.data!.email!, workerDetailModel!.data!.gender!);
                  print(files);
                  await ApiService().addCV(files);
                  if(cvFile == null){
                    setState(() {
                      _isLoad = true;
                      cvFile = files;
                    });
                    MyCvModel model = await ApiService().getMyCv();
                    setState(() {
                      myCvModel = model;
                    });
                    print(model.data!.cvFile);
                    setState(() {
                      _isLoad = false;
                    });
                    showDialog(context: context, builder: (context) {
                      final data = workerDetailModel!.data!;
                      return _isLoad ? const AlertDialog(actions: [Center(child: CircularProgressIndicator(),)],) : AlertDialog(
                        title: const Text('Pilih CV', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        actions: [
                          myCvModel!.data!.cvFile!.isNotEmpty ? Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  File files = await PublicFunction.getPdf(data.id!, data.username!, data.interested!, data.age!.toString(), data.address!, '08677281920', data.email!, data.gender!);
                                  setState(() {
                                    cvFile = files;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Card(
                                  child: Container(
                                    width: double.maxFinite,
                                    color: color.primaryContainer,
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.picture_as_pdf, color: color.primary,),
                                        const SizedBox(width: 5,),
                                        SizedBox(width: 150,child: Text(myCvModel!.data!.cvFile.toString(), overflow: TextOverflow.clip,)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Tambah dari perangkat'),
                              )
                            ],
                          ) : const SizedBox(
                            width: double.maxFinite,
                            height: 30,
                            child: Text('Tambah Cv'),
                          )
                        ],
                      );
                    },);
                  } else {
                    cvFile = null;
                  }
                },
                child: cvFile != null ? Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CvPage(filePath: cvFile!.path),));
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 50,
                        decoration: BoxDecoration(
                          color: color.primary,
                          borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.picture_as_pdf_outlined, color: color.white,),
                            const SizedBox(width: 10,),
                            Expanded(child: Text(myCvModel!.data!.cvFile!, style: TextStyle(color: color.white), overflow: TextOverflow.ellipsis,))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          cvFile = null;
                        });
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 50,
                        decoration: BoxDecoration(
                            color: color.primaryContainer,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: Center(
                          child: Icon(Icons.remove, color: color.primary,),
                        ),
                      ),
                    ),
                  ],
                ): Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.primaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: color.primary,),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                'Deskripsi',
                style: TextStyle(
                    color: color.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Deskipsi tentang lamaran',
                style: TextStyle(
                  color: color.black.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.maxFinite,
                constraints: BoxConstraints(minHeight: 130),
                padding: const EdgeInsets.only(left: 15, right: 10),
                decoration: BoxDecoration(
                    color: color.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  cursorColor: color.primary,
                  controller: _descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: color.black),
                  decoration: const InputDecoration(
                    hintText: "Beritahu Perusahaan mengenai lamaranmu",
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
      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainer,
        child: InkWell(
          onTap: () async {
            if(cvFile != null && _descriptionController.text.isNotEmpty){
              bool isSuccess = await ApiService().postWorkerJob(context, widget.jobId.toString(), _descriptionController.text, cvFile!);
              if(isSuccess == true){
                await FirebaseApiService().firebaseSendNotif(deviceToken!, 'Kamu mendapat lamaran baru', '${workerDetailModel!.data!.username} baru saja melamar di salah satu pekerjaanmu!!', 'https://cariin.my.id/storage/${workerDetailModel!.data!.profilImage}');
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    content: const Text(
                      'Menunggu Konfirmasi dari perusahaan',
                      style: TextStyle(fontSize: 15),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CustomBottomNavigation(),), (route) => false),
                          child: const Text("Iya")),
                    ],
                  );
                },);
              }else{
                showDialog(context: context, builder: (context) {
                  return PublicFunction.showDialog(context, 'Anda telah melamar dilowongan ini');
                },);
              }
            } else {
              showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Isi Formulir dengan lengkap!'),);
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: color.primary, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                'Lamar Pekerjaan',
                style:
                    TextStyle(color: color.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CvPage extends StatelessWidget {
  CvPage({Key? key, required this.filePath}) : super(key: key);
  String filePath;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          title: Text(
            'CV Firdan',
            style: TextStyle(color: color.black, fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.print, size: 30,),
            )
          ],
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          )),
      body: PDFView(
        autoSpacing: false,
        enableSwipe: false,
        swipeHorizontal: true,
        pageFling: false,

        filePath: filePath,
      ),
    );
  }
}
