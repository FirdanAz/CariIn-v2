import 'package:cariin_v2/model/recruit/recruit_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../service/api_service.dart';
import '../../detail_profile/detail.dart';

class RekrutKaryawanPage extends StatefulWidget {
  const RekrutKaryawanPage({Key? key}) : super(key: key);

  @override
  State<RekrutKaryawanPage> createState() => _RekrutKaryawanPageState();
}

class _RekrutKaryawanPageState extends State<RekrutKaryawanPage> {
  RecruitListModel? recruitListModel;
  bool _isLoad = false;

  Getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    RecruitListModel allJob = await ApiService().getListRecruit();
    setState(() {
      recruitListModel = allJob;
    });
    if (kDebugMode) {
      print(allJob);
    }
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getdata();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: _isLoad ? Center(child: SizedBox(width: 200, child: LinearProgressIndicator(color: color.primary,),),) : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: recruitListModel!.data!.length == 0 ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            recruitListModel!.data!.isEmpty ? const Center(child: Text('Data Kosong'),) : ListView.builder(
              shrinkWrap: true,
              itemCount: recruitListModel!.data!.length,
              itemBuilder: (context, index) {
                var data = recruitListModel!.data![index];
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProfil(id: data.worker!.id!),
                      )),
                  child: Container(
                    width: double.maxFinite,
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: color.background,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(AppAssets.firdanImg),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.worker!.username!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: color.black,
                                    fontSize: 17),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '99 Tahun',
                                style: TextStyle(color: color.black, fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Kudus, Jawa Tengah, ',
                                    style:
                                    TextStyle(color: color.black, fontSize: 14),
                                  ),
                                  Text(
                                    'Indonesia',
                                    style: TextStyle(
                                        color: color.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.work, size: 20, color: color.primary,),
                                  Text(
                                    ' ${data.job!.title!}',
                                    style:
                                    TextStyle(color: color.primary, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
