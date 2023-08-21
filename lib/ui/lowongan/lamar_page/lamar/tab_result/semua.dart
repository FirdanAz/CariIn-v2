import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/lowongan/detail_lowongan/page.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar/tab_result/detail_lamaran.dart';
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../../common/app_color.dart';
import '../../../../../model/worker/job_application_model.dart';
import '../../../../../service/api_service.dart';

class SemuaTabs extends StatefulWidget {
  SemuaTabs({Key? key,  required this.all, required this.value, required this.titlePage}) : super(key: key);
  bool all;
  String value;
  String titlePage;

  @override
  State<SemuaTabs> createState() => _SemuaTabsState();
}

class _SemuaTabsState extends State<SemuaTabs> {
  JobApplicationModel? jobApplicationModel;
  bool _isLoad = false;

  getdata() async {
    _isLoad = true;
    JobApplicationModel allJob = await ApiService().getLamaranResult(widget.all, widget.value);
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

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.titlePage, style: TextStyle(color: color.primary, fontSize: 19),),
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
                    //PublicFunction.navigatorPush(context, JobDetailPage(id: data.job!.id!));
                    PublicFunction.navigatorPush(context, DetailLamaran(id: data.id!,));
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
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://static01.nyt.com/images/2021/05/02/business/00google-office1/00google-office1-videoSixteenByNineJumbo1600.jpg'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    '${data.job!.title}',
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
                          ],
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
            ) : Center(child: Text('Tidak ada lamaran disini'),)
        )
    );
  }
}
