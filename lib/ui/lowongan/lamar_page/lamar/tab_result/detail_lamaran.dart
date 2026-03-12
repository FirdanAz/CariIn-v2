import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/model/company/detail_pelamar_model.dart';
import 'package:cariin_v2/model/worker/detail_lamaran_model.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/lowongan/detail_lowongan/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/app_assets.dart';
import '../../../../../common/app_color.dart';
import '../../../../../service/api_service.dart';

class DetailLamaran extends StatefulWidget {
  DetailLamaran({super.key, required this.id});
  int id;

  @override
  State<DetailLamaran> createState() => _DetailLamaranState();
}

class _DetailLamaranState extends State<DetailLamaran> {
  DetailLamaranModel? detailPelamarModel;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    DetailLamaranModel detail = await DataService().detailLamaran(widget.id, 'worker');
    setState(() {
      detailPelamarModel = detail;
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
      backgroundColor: color.surfaceContainer,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          margin: EdgeInsets.only(left: 15),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(true),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Detail Lamaran',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.maxFinite,
            color: color.secondary,
          ),
        ),
      ),
      body: _isLoad ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.maxFinite,
              child: Column(
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
                            backgroundImage: NetworkImage('https://cariin.my.id/storage/${detailPelamarModel!.data!.worker!.profilImage}'),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                width: double.maxFinite,
                                child: Text(
                                  detailPelamarModel!.data!.worker!.username!,
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
                                  '${detailPelamarModel!.data!.worker!.age!} Tahun',
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
                                  '${detailPelamarModel!.data!.worker!.address}, Indonesia',
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
                                  detailPelamarModel!.data!.worker!.gender!,
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
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
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
                              if(detailPelamarModel!.data!.job != null){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailPage(id: detailPelamarModel!.data!.job!.id!),));
                              }
                              else {
                                showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Sepertinya Pekerjaan yang anda lamar Telah dihapus oleh perusahaan'),);
                              }
                            },
                            child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 55,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: color.primaryContainer,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: detailPelamarModel!.data!.job != null ? Image.network('https://cariin.my.id/storage/${detailPelamarModel!.data!.job!.coverImage}', fit: BoxFit.cover,) : SvgPicture.asset(AppAssets.appsLogo)
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(padding: EdgeInsets.only(left: 15)),
                                      Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          detailPelamarModel!.data!.job != null ? detailPelamarModel!.data!.job!.title! : 'Pekerjaan Tidak Tersedia',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.all(1)),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          detailPelamarModel!.data!.job != null ? '${detailPelamarModel!.data!.job!.company!.name} | Feb 2019 - 2020' : '----',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.all(1)),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          detailPelamarModel!.data!.job != null ? detailPelamarModel!.data!.job!.company!.location! : '',
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
    );
  }
}