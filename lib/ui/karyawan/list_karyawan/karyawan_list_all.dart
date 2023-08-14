// ignore_for_file: non_constant_identifier_names

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/model/company/list_worker_model.dart';
import 'package:cariin_v2/ui/karyawan/detail_profile/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_color.dart';
import '../../../service/api_service.dart';

class ListKaryawan extends StatefulWidget {
  const ListKaryawan({Key? key}) : super(key: key);

  @override
  State<ListKaryawan> createState() => _ListKaryawanState();
}

class _ListKaryawanState extends State<ListKaryawan> {
  WorkerListModel? workerListModel;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    WorkerListModel model = await ApiService().ListWorkerCompany();
    setState(() {
      workerListModel = model;
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
      body: _isLoad ? const Center(child: Text('Loading..')) : CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.primaryContainer),
            title: Text(
              'Pekerja Siap Direkurt',
              style: TextStyle(
                  color: color.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final data = workerListModel!.data![index];
              return KaryawanListCard(context, 'https://cariin.my.id/storage/${data.profilImage!}', data.username!, data.address!, data.age!.toString(), data.id!);
            },
              childCount: workerListModel!.data!.length
            ),
          )
        ],
      ),
    );
  }
}

Widget KaryawanListCard(BuildContext context, String urlImage, String workerName, String address, String age, int id) {
  var color = AppColor.theme(Theme.of(context).brightness);

  return InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProfil(id: id),)),
    child: Container(
      width: double.maxFinite,
      height: 150,
      margin: const EdgeInsets.symmetric(
          horizontal: 10
      ),
      decoration: BoxDecoration(
        color: color.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset:
            const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 20
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(urlImage),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 5
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workerName,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: color.black,
                      fontSize: 17
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  '$age Tahun',
                  style: TextStyle(
                      color: color.black,
                      fontSize: 14
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '$address, ',
                      style: TextStyle(
                          color: color.black,
                          fontSize: 14
                      ),
                    ),
                    Text(
                      'Indonesia',
                      style: TextStyle(
                          color: color.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Text(
                  'UI/UX Designer',
                  style: TextStyle(
                      color: color.primary,
                      fontSize: 14
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
