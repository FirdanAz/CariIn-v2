// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/service/firebase_api_service.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../model/worker/cv.dart';
import '../../../../model/worker/worker_model.dart';
import '../../../../service/api_service.dart';
import '../lamar_process_page.dart';

class LamarPklPage extends StatefulWidget {
  LamarPklPage({Key? key, required this.educationInstitution, required this.description, required this.jobId, required this.companyId}) : super(key: key);
  String educationInstitution;
  String description;
  String jobId;
  String companyId;

  @override
  State<LamarPklPage> createState() => _LamarPklPageState();
}

class _LamarPklPageState extends State<LamarPklPage> {
  File? cvFile;
  MyCvModel? myCvModel;
  WorkerModel? workerDetailModel;
  bool _isLoad = false;

  File? potoFile;
  File? suratLamaranFile;
  File? suratBuktiFile;

  String? deviceToken;

  getData() async {
    _isLoad = true;
    await ApiService().RefreshToken('worker', await PublicFunction.getToken('worker'));
    WorkerModel model = await ApiService().getWorker();
    var token = await DataService().getCompanyDevice(widget.companyId);
    setState(() {
      workerDetailModel = model;
      deviceToken = token.toString();
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf']);
    if (result != null) {
      return File(result.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColor.theme(Theme.of(context).brightness);

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
      appBar: AppBar(
        title: Text('Lengkapi File', style: TextStyle(color: color.primary, fontSize: 18),),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new))
      ),
      body: _isLoad ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        showLoaderDialog(context);
                        MyCvModel model = await ApiService().getMyCv();
                        setState(() {
                          myCvModel = model;
                        });
                        Navigator.of(context).pop();
                        showDialog(context: context, builder: (context) {
                          final data = workerDetailModel!.data!;
                          return _isLoad ? const AlertDialog(actions: [Center(child: CircularProgressIndicator(),)],) : AlertDialog(
                            title: const Text('Pilih CV', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                            actions: [
                              myCvModel!.data!.cvFile!.isNotEmpty ? Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      File files = await PublicFunction.getPdf(data.id!, data.username!, data.interested!, data.age!.toString(), data.address!, data.phoneNumber! , data.email!, data.gender!);
                                      setState(() {
                                        cvFile = files;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Card(
                                      child: Container(
                                        width: double.maxFinite,
                                        color: color.primaryContainer,
                                        padding: const EdgeInsets.all(10),
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
                                Text(myCvModel!.data!.cvFile!, style: TextStyle(color: color.white),)
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
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(
                    'Tambahkan Portofolio(PDF)',
                    style: TextStyle(
                        color: color.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Portofolio berisikan galeri kumpulan hasil pekerjaan. Bagian ini bisa kamu buat per project agar lebih sistematis. Setiap ulasan project sebaiknya memuat informasi dasar project, foto dokumentasi, serta poin-poin pencapaian yang kamu banggakan dari project tersebut.',
                    style: TextStyle(
                      color: color.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      potoFile != null ?
                      InkWell(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CvPage(filePath: potoFile!.path),));
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 40,
                          color: color.primary,
                          child: Center(child: Text(potoFile!.path, overflow: TextOverflow.ellipsis, style: TextStyle(color: color.white),)),
                        ),
                      ) : Container(),
                      InkWell(
                        onTap: () async {
                          if (potoFile == null){
                            potoFile = await _pickFile();
                            setState(() {
                              potoFile;
                            });
                          } else if(potoFile != null) {
                            setState(() {
                              potoFile = null;
                            });
                          }
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                              color: color.primaryContainer,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                          ),
                          child: Center(
                            child: potoFile != null ? Icon(Icons.remove, color: color.primary,) : Icon(Icons.add, color: color.primary,),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(
                    'Surat Permohonan/Lamaran PKL(PDF)',
                    style: TextStyle(
                        color: color.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Pada surat permohonan magang pada umumnya terdapat lampiran sebagai dokumen pendukung atau pertimbangan bagi pihak perusahaan untuk dapat menerima kamu. Dokumen pendukung tersebut seperti, Kartu Hasil Studi (KHS), portofolio, dan lain sebagainya.',
                    style: TextStyle(
                      color: color.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      suratLamaranFile != null ?
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CvPage(filePath: suratLamaranFile!.path),));
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 40,
                          color: color.primary,
                          child: Center(child: Text(potoFile!.path, overflow: TextOverflow.ellipsis, style: TextStyle(color: color.white),)),
                        ),
                      ) : Container(),
                      InkWell(
                        onTap: () async {
                          if (suratLamaranFile == null){
                            suratLamaranFile = await _pickFile();
                            setState(() {
                              suratLamaranFile;
                            });
                          } else if(suratLamaranFile != null){
                            setState(() {
                              suratLamaranFile = null;
                            });
                          }
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                              color: color.primaryContainer,
                              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                          ),
                          child: Center(
                            child: suratLamaranFile != null ? Icon(Icons.remove, color: color.primary,) : Icon(Icons.add, color: color.primary,),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(
                    'Surat Bukti Siswa(PDF/Gambar)',
                    style: TextStyle(
                        color: color.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Surat Keterangan Aktif Siswa merupakan surat yang dikeluarkan oleh kepala sekolah dan diberikan kepada siswa yang memerlukannya untuk menerangkan bahwa siswa tersebut sesuai identitas di dalam surat merupakan siswa aktif di sekolah.',
                    style: TextStyle(
                      color: color.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      suratBuktiFile != null ?
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CvPage(filePath: suratBuktiFile!.path),));
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 40,
                          color: color.primary,
                          child: Center(child: Text(suratBuktiFile!.path, overflow: TextOverflow.ellipsis, style: TextStyle(color: color.white),)),
                        ),
                      ) : Container(),
                      InkWell(
                        onTap: () async {
                          if (suratBuktiFile == null){
                            suratBuktiFile = await _pickFile();
                            setState(() {
                              suratBuktiFile;
                            });
                          } else if(suratBuktiFile != null){
                            setState(() {
                              suratBuktiFile = null;
                            });
                          }
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                              color: color.primaryContainer,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                          ),
                          child: Center(
                            child: suratBuktiFile != null ? InkWell(onTap: () {
                              suratBuktiFile = null;
                            },child: Icon(Icons.remove, color: color.primary,)) : Icon(Icons.add, color: color.primary,),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40,),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(color.primary), shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)))),
                  onPressed: () async {
                    showLoaderDialog(context);
                    bool isSucces = await DataService().createPkl(widget.jobId, widget.educationInstitution, widget.description, cvFile!, potoFile!, suratLamaranFile!, suratBuktiFile!);
                    if(isSucces){
                      await FirebaseApiService().firebaseSendNotif(deviceToken!, 'Kamu mendapatkan lamaran baru', '${workerDetailModel!.data!.username} baru saja melamar (PKL) di salah satu Lowongan', 'https://cariin.my.id/storage/${workerDetailModel!.data!.profilImage}');
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CustomBottomNavigation(indexs: 1),), (route) => false);
                      showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Lamar Pkl Sukses'),);
                    } else {
                      showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Anda Sudah melamar disini!'),);
                    }
                  },
                  child: Center(child: Text('Kirim lamaran', style: TextStyle(color: color.white),),),
                ),
              ),
              const SizedBox(height: 60,),
            ],
          ),
        ),
      ),
    );
  }
}
