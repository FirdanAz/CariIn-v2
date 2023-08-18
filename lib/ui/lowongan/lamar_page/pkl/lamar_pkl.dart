// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../model/worker/cv.dart';
import '../../../../model/worker/worker_model.dart';
import '../../../../service/api_service.dart';
import '../lamar_process_page.dart';

class LamarPklPage extends StatefulWidget {
  const LamarPklPage({Key? key}) : super(key: key);

  @override
  State<LamarPklPage> createState() => _LamarPklPageState();
}

class _LamarPklPageState extends State<LamarPklPage> {
  File? cvFile;
  MyCvModel? myCvModel;
  WorkerModel? workerDetailModel;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    WorkerModel model = await ApiService().getWorker();
    setState(() {
      workerDetailModel = model;
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
    final color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lamar Pkl', style: TextStyle(color: color.primary, fontSize: 18),),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new))
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                  if(cvFile == null){
                    setState(() {
                      _isLoad = true;
                    });
                    MyCvModel model = await ApiService().getMyCv();
                    setState(() {
                      myCvModel = model;
                    });
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CvPage(file: cvFile!),));
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
        ),
      ),
    );
  }
}
