// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cariin_v2/model/worker/edit_data_model/pkl_detail_model.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/karyawan/detail_lowongan/page.dart';
import 'package:flutter/material.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/public_function.dart';
import '../../../../../service/api_service.dart';
import '../../../../lowongan/lamar_page/lamar_process_page.dart';

class PklDetailPage extends StatefulWidget {
  PklDetailPage({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<PklDetailPage> createState() => _PklDetailPageState();
}

class _PklDetailPageState extends State<PklDetailPage> {
  PklDetailModel? pklDetailModel;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    PklDetailModel detailModel =
        await DataService().getDetailPkl(int.parse(widget.id), 'company');
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

    return _isLoad
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Detail ${pklDetailModel!.data!.job!.title} (PKL)',
                  style: TextStyle(color: color.primary, fontSize: 16)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                color: color.primary,
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
                                  backgroundImage: NetworkImage(
                                      'https://cariin.my.id/storage/${pklDetailModel!.data!.worker!.profilImage}'),
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
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 7,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(pklDetailModel!.data!.confirmedStatus!)
                          ],
                        ),
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
                                  _file(pklDetailModel!.data!.cvFile!,
                                      'Curriculum vitae'),
                                  _file(pklDetailModel!.data!.portfolioFile!,
                                      'Portofolio'),
                                  _file(
                                      pklDetailModel!
                                          .data!.applicationLetterFile!,
                                      'Surat Lamaran'),
                                  _file(
                                      pklDetailModel!
                                          .data!.studentEvidenceFile!,
                                      'Surat Bukti Siswa'),
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CompanyJobDetailPage(
                                                    id: pklDetailModel!
                                                        .data!.job!.id!),
                                          ));
                                    },
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 55,
                                              height: 55,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: color.primaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Image.network(
                                                'https://cariin.my.id/storage/${pklDetailModel!.data!.job!.coverImage}',
                                                fit: BoxFit.cover,
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15)),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8),
                                                child: Text(
                                                  pklDetailModel!
                                                      .data!.job!.title!,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(1)),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  '${pklDetailModel!.data!.job!.company!.name} | Feb 2019 - 2020',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(1)),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  pklDetailModel!.data!.job!
                                                      .company!.location!,
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
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                MaterialStatePropertyAll(pklDetailModel!.data!.confirmedStatus == 'ditolak' ? color.primary.withOpacity(0.5) : color.primary)),
                        onPressed: () async {
                          if (pklDetailModel!.data!.confirmedStatus ==
                              'direview') {
                            bool isSuccess = await DataService()
                                .pklDefineConfirmation('wawancara',
                                    pklDetailModel!.data!.id!.toString());
                            if (isSuccess) {
                              showDialog(
                                context: context,
                                builder: (context) => PublicFunction.showDialog(
                                    context, 'Pelamar Dikonfirmasi'),
                              );
                              setState(() {
                                getData();
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => PublicFunction.showDialog(
                                    context, 'Gagal!'),
                              );
                            }
                          }
                          if (pklDetailModel!.data!.confirmedStatus ==
                              'wawancara') {
                            bool isSuccess = await DataService()
                                .pklDefineConfirmation('diterima',
                                    pklDetailModel!.data!.id!.toString());
                            if (isSuccess) {
                              showDialog(
                                context: context,
                                builder: (context) => PublicFunction.showDialog(
                                    context, 'Pelamar Diterima'),
                              );
                              setState(() {
                                getData();
                              });
                            }
                          }
                          if (pklDetailModel!.data!.confirmedStatus ==
                              'diterima') {
                          }if (pklDetailModel!.data!.confirmedStatus ==
                              'ditolak') {

                          } else {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  PublicFunction.showDialog(context, 'Gagal!'),
                            );
                          }
                        },
                        child:
                            pklDetailModel!.data!.confirmedStatus == 'direview'
                                ? Text(
                                    'Proses Wawancara',
                                    style: TextStyle(color: color.white),
                                  )
                                : pklDetailModel!.data!.confirmedStatus ==
                                        'diterima'
                                    ? Text(
                                        'Kontak Pelamar',
                                        style: TextStyle(color: color.white),
                                      )
                                    : Text(
                                        'Terima Pelamar',
                                        style: TextStyle(color: pklDetailModel!.data!.confirmedStatus == 'ditolak' ? color.white.withOpacity(0.5) : color.white),
                                      ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  pklDetailModel!.data!.confirmedStatus == 'diterima'
                      ? Container()
                      : pklDetailModel!.data!.confirmedStatus == 'ditolak'
                          ? Container()
                          : Expanded(
                              child: Container(
                                height: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor: MaterialStatePropertyAll(
                                          color.primaryContainer)),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Tolak lamaran ${pklDetailModel!.data!.worker!.username}?',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Batal')),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  bool isSuccess =
                                                      await DataService()
                                                          .pklDefineConfirmation(
                                                              'ditolak',
                                                              pklDetailModel!
                                                                  .data!.id!
                                                                  .toString());
                                                  Navigator.of(context).pop();
                                                  if (isSuccess) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          PublicFunction.showDialog(
                                                              context,
                                                              'Pelamar Ditolak'),
                                                    );
                                                    setState(() {
                                                      getData();
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  'Tolak',
                                                  style: TextStyle(
                                                      color: color.error),
                                                ))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Tolak Lamaran',
                                    style: TextStyle(color: color.error),
                                  ),
                                ),
                              ),
                            )
                ],
              ),
            ),
          );
  }

  Widget _file(String files, String title) {
    final color = AppColor.theme(Theme.of(context).brightness);
    return InkWell(
      onTap: () async {
        File file =
            await ApiService().loadPdf('https://cariin.my.id/storage/$files');
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
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: color.primary),
            ))
          ],
        ),
      ),
    );
  }
}
