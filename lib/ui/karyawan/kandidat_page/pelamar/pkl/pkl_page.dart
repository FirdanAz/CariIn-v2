import 'package:cariin_v2/model/worker/edit_data_model/pkl_list_model.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/karyawan/kandidat_page/pelamar/pkl/detail_pkl.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/detail_pkl.dart';
import 'package:flutter/material.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/public_function.dart';
import '../../../../../service/api_service.dart';


class ListWorkerPkl extends StatefulWidget {
  const ListWorkerPkl({Key? key}) : super(key: key);

  @override
  State<ListWorkerPkl> createState() => _ListWorkerPklState();
}

class _ListWorkerPklState extends State<ListWorkerPkl> {
  PklListModel? pklListModel;
  PklListModel? direview;
  PklListModel? wawancara;
  PklListModel? diterima;
  PklListModel? ditolak;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    PklListModel listModel = await EditService().getPklList(false, 'mengirim', 'company');
    PklListModel listModel1 = await EditService().getPklList(false, 'direview', 'company');
    PklListModel listModel2 = await EditService().getPklList(false, 'wawancara', 'company');
    PklListModel listModel3 = await EditService().getPklList(false, 'diterima', 'company');
    PklListModel listModel4 = await EditService().getPklList(false, 'ditolak', 'company');
    setState(() {
      pklListModel = listModel;
      direview = listModel1;
      wawancara = listModel2;
      diterima = listModel3;
      ditolak = listModel4;
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
        title: Text('Pelamar PKL(Praktik Kerja Lapangan)', style: TextStyle(color: color.primary, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), color: color.primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isLoad ? const Center(child: CircularProgressIndicator(),) :
      RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getData();
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Diterima (${diterima!.data!.length})'),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: diterima!.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = diterima!.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PklDetailPage(id: data.id.toString()),));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: color.primaryContainer,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: color.primary,
                                backgroundImage: NetworkImage('https://cariin.my.id/storage/${data.worker!.profilImage}'),
                              ),
                              title: Text(data.worker!.username!),
                              trailing: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: color.primary,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text(data.confirmedStatus!, style: TextStyle(color: color.white),),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.work, color: color.primary, size: 18,),
                                  const SizedBox(width: 5,),
                                  Text(data.job!.title!)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Menunggu (${pklListModel!.data!.length})'),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: pklListModel!.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = pklListModel!.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PklDetailPage(id: data.id.toString()),));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: color.primaryContainer,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: color.primary,
                                backgroundImage: NetworkImage('https://cariin.my.id/storage/${data.worker!.profilImage}'),
                              ),
                              title: Text(data.worker!.username!),
                              trailing: Container(
                                child: Text(data.confirmedStatus!, style: TextStyle(color: color.white),),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: color.primary,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.work, color: color.primary, size: 18,),
                                  const SizedBox(width: 5,),
                                  Text(data.job!.title!)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Direview (${direview!.data!.length})'),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: direview!.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = direview!.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PklDetailPage(id: data.id.toString()),));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: color.primaryContainer,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: color.primary,
                                backgroundImage: NetworkImage('https://cariin.my.id/storage/${data.worker!.profilImage}'),
                              ),
                              title: Text(data.worker!.username!),
                              trailing: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: color.primary,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text(data.confirmedStatus!, style: TextStyle(color: color.white),),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.work, color: color.primary, size: 18,),
                                  const SizedBox(width: 5,),
                                  Text(data.job!.title!)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wawancara (${wawancara!.data!.length})'),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: wawancara!.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = wawancara!.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PklDetailPage(id: data.id.toString()),));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: color.primaryContainer,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: color.primary,
                                backgroundImage: NetworkImage('https://cariin.my.id/storage/${data.worker!.profilImage}'),
                              ),
                              title: Text(data.worker!.username!),
                              trailing: Container(
                                child: Text(data.confirmedStatus!, style: TextStyle(color: color.white),),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: color.primary,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.work, color: color.primary, size: 18,),
                                  const SizedBox(width: 5,),
                                  Text(data.job!.title!)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ditolak (${ditolak!.data!.length})'),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: ditolak!.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = ditolak!.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPklPage(id: data.id.toString()),));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: color.primaryContainer,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: color.primary,
                                backgroundImage: NetworkImage('https://cariin.my.id/storage/${data.worker!.profilImage}'),
                              ),
                              title: Text(data.worker!.username!),
                              trailing: Container(
                                child: Text(data.confirmedStatus!, style: TextStyle(color: color.white),),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: color.primary,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.work, color: color.primary, size: 18,),
                                  const SizedBox(width: 5,),
                                  Text(data.job!.title!)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
