import 'package:cariin_v2/ui/karyawan/kandidat_page/pelamar/detail_pelamar.dart';
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../../common/app_assets.dart';
import '../../../../../common/app_color.dart';
import '../../../../../common/public_function.dart';
import '../../../../../model/worker/worker_application_model.dart';
import '../../../../../service/api_service.dart';

class DiterimaTabs extends StatefulWidget {
  const DiterimaTabs({Key? key}) : super(key: key);

  @override
  State<DiterimaTabs> createState() => _DiterimaTabsState();
}

class _DiterimaTabsState extends State<DiterimaTabs> {
  WorkerApplicationModel? jobApplicationModel;
  bool _isLoad = false;

  getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    WorkerApplicationModel allJob = await ApiService().getWorkerResult(false, 'diterima');
    setState(() {
      jobApplicationModel = allJob;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad ? ShimmerPelamar(itemCount: 7,) :
    Container(
      height: double.maxFinite,
      child: SizedBox(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getdata();
            });
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 1000),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: jobApplicationModel!.data!.length,
              itemBuilder: (context, index) {
                var data = jobApplicationModel!.data![index];
                DateTime? date = DateTime.parse(data.createdAt.toString());
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPelamarPage(id: data.id!.toInt()),));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: color.surfaceContainer,
                        borderRadius: BorderRadius.circular(10)),
                    width: double.maxFinite,
                    height: 75,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppAssets.firdanImg),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    '${data.worker!.username}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    GetTimeAgo.parse(date, locale: 'id'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        data.confirmedStatus == 'diterima' ? Container(padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                          color: color.primaryContainer,
                          child: Text(
                            'Diterima',
                            style: TextStyle(
                                fontSize: 13
                            ),
                          ),
                        ) : data.confirmedStatus == 'ditolak' ? Container(padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                          color: color.error,
                          child: Text(
                            'Ditolak',
                            style: TextStyle(
                                fontSize: 13,
                                color: color.white
                            ),
                          ),
                        ) : data.confirmedStatus == 'menunggu' ? Container(padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                          color: color.primary,
                          child: Text(
                            'Menunggu',
                            style: TextStyle(
                                fontSize: 13,
                                color: color.white
                            ),
                          ),
                        ) : Container(padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                          color: color.primary,
                          child: Text(
                            'Iya',
                            style: TextStyle(
                                fontSize: 13
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
