// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/model/worker/edit_data_model/pkl_detail_model.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../service/api_service.dart';
import '../../detail_lowongan/page.dart';
import '../lamar_process_page.dart';

class DetailPklPage extends StatefulWidget {
  DetailPklPage({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<DetailPklPage> createState() => _DetailPklPageState();
}

class _DetailPklPageState extends State<DetailPklPage> {
  PklDetailModel? pklDetailModel;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    await ApiService().RefreshToken('worker', await PublicFunction.getToken('worker'));
    PklDetailModel detailModel = await EditService().getDetailPkl(int.parse(widget.id), 'worker');
    setState(() {
      pklDetailModel = detailModel;
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

    return _isLoad ? const Scaffold(body: Center(child: CircularProgressIndicator(),),) : Scaffold(
      appBar: AppBar(
        title: Text('Detail ${pklDetailModel!.data!.job!.title} (PKL)', style: TextStyle(color: color.primary, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), color: color.primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    color: color.background,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 30,
                                color: color.primary,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Pelamar Pekerjaan',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 10),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('https://cariin.my.id/storage/${pklDetailModel!.data!.worker!.profilImage}'),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                width: double.maxFinite,
                                child: Text(
                                  pklDetailModel!.data!.worker!.username!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                width: double.maxFinite,
                                child: Text(
                                  '${pklDetailModel!.data!.worker!.age!} Tahun',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                width: double.maxFinite,
                                child: Text(
                                  '${pklDetailModel!.data!.worker!.address}, Indonesia',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                width: double.maxFinite,
                                child: Text(
                                  pklDetailModel!.data!.worker!.gender!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      color: color.background,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.file_copy_outlined,
                                  size: 30,
                                  color: color.primary,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'File Pelamar',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            _file(pklDetailModel!.data!.cvFile!, 'Curriculum vitae'),
                            _file(pklDetailModel!.data!.portfolioFile!, 'Portofolio'),
                            _file(pklDetailModel!.data!.applicationLetterFile!, 'Surat Lamaran'),
                            _file(pklDetailModel!.data!.studentEvidenceFile!, 'Surat Bukti Siswa'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      color: color.background,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  size: 30,
                                  color: color.primary,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Pekerjaan Dilamar',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailPage(id: pklDetailModel!.data!.job!.id!),));
                              },
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 55,
                                        height: 55,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: color.primaryContainer,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Image.network('https://cariin.my.id/storage/${pklDetailModel!.data!.job!.coverImage}', fit: BoxFit.cover,)
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(padding: EdgeInsets.only(left: 15)),
                                        Container(
                                          margin: const EdgeInsets.only(left: 8),
                                          child: Text(
                                            pklDetailModel!.data!.job!.title!,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const Padding(padding: EdgeInsets.all(1)),
                                        Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            '${pklDetailModel!.data!.job!.company!.name} | Feb 2019 - 2020',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const Padding(padding: EdgeInsets.all(1)),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            pklDetailModel!.data!.job!.company!.location!,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _file(String files, String title) {
    final color = AppColor.theme(Theme.of(context).brightness);
    return InkWell(
      onTap: () async {
        File file = await ApiService().loadPdf(
            'https://cariin.my.id/storage/$files');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CvPage(filePath: file.path),
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Icon(
              Icons.picture_as_pdf_outlined,
              color: color.primary,
            ),
            const SizedBox(width: 5,),
            Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: color.primary),))
          ],
        ),
      ),
    );
  }
}
