// ignore_for_file: must_be_immutable

import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/public_function.dart';
import '../../../../../model/worker/worker_application_model.dart';
import '../../../../../service/api_service.dart';
import '../detail_pelamar.dart';

class SemuaTabs extends StatefulWidget {
  SemuaTabs({Key? key, required this.all, required this.value, required this.titlePage}) : super(key: key);
  bool all;
  String value;
  String titlePage;

  @override
  State<SemuaTabs> createState() => _SemuaTabsState();
}

class _SemuaTabsState extends State<SemuaTabs> {
  WorkerApplicationModel? jobApplicationModel;
  bool _isLoad = false;

  getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    WorkerApplicationModel allJob = await ApiService().getWorkerResult(widget.all, widget.value);
    setState(() {
      jobApplicationModel = allJob;
      jobApplicationModel!.data!.sort((a, b) {
        DateTime dateA = DateTime.parse(a.createdAt.toString());
        DateTime dateB = DateTime.parse(b.createdAt.toString());
        return dateB.compareTo(dateA);
      },);
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

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.titlePage, style: TextStyle(color: color.primary, fontSize: 19),),
            _isLoad ? Container() : Text(' (${jobApplicationModel!.data!.length})', style: TextStyle(color: color.primary, fontSize: 16),)
          ],
        ),
      ),
      body: _isLoad ? ShimmerPelamar(itemCount: 7,) : RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getdata();
          });
        },
        child: jobApplicationModel!.data!.length != 0 ? ListView.builder(
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
                    Expanded(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://static01.nyt.com/images/2021/05/02/business/00google-office1/00google-office1-videoSixteenByNineJumbo1600.jpg'),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    '${data.worker!.username}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    GetTimeAgo.parse(date, locale: 'id'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    data.confirmedStatus == 'diterima' ? Container(padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                      color: color.primaryContainer,
                      child: const Text(
                        'Diterima',
                        style: TextStyle(
                            fontSize: 13
                        ),
                      ),
                    ) : data.confirmedStatus == 'ditolak' ? Container(padding: const EdgeInsets.symmetric(
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
                    ) : data.confirmedStatus == 'wawancara' ? Container(padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                      color: color.primary,
                      child: Text(
                        'Proses Wawancara',
                        style: TextStyle(
                            fontSize: 13,
                            color: color.white
                        ),
                      ),
                    ): data.confirmedStatus == 'direview' ? Container(padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                      color: color.primary,
                      child: Text(
                        'Direview',
                        style: TextStyle(
                            fontSize: 13,
                            color: color.white
                        ),
                      ),
                    ) : Container(padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                      color: color.primary,
                      child: const Text(
                        'Menunggu Direview',
                        style: TextStyle(
                            fontSize: 13,
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ) : Center(child: Text('Tidak ada pelamar disini'),)
      )
    );
  }
}
