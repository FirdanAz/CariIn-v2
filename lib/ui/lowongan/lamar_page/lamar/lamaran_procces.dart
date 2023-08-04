import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../common/app_color.dart';
import '../../../../model/all_job_worker_model.dart';
import '../../../../service/api_service.dart';
import '../../detail_lowongan/page.dart';


class LamaranProcces extends StatefulWidget {
  const LamaranProcces({Key? key}) : super(key: key);

  @override
  State<LamaranProcces> createState() => _LamaranProccesState();
}

class _LamaranProccesState extends State<LamaranProcces> {
  AllJobWorkerModel? allJobWorkerModel;
  bool _isLoad = false;

  getdata() async {
    _isLoad = true;
    AllJobWorkerModel allJob = await ApiService().AllJobsWorker();
    setState(() {
      allJobWorkerModel = allJob;
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

    return _isLoad ? const Center(child: CircularProgressIndicator(),) : Container(
      child: ListView.builder(
        itemCount: allJobWorkerModel!.data!.length,
        itemBuilder: (context, index) {
          var data = allJobWorkerModel!.data![index];
          DateTime? date = DateTime.parse(data.createdAt.toString());
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailPage(id: allJobWorkerModel!.data![index].id!.toInt()), )),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: color.white,
                    boxShadow: [
                      BoxShadow(
                        color: color.primaryContainer.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title.toString(),
                          style: TextStyle(
                              color: color.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Pengalaman',
                              style: TextStyle(
                                  color: color.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: color.black.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '1 - 3 Tahun',
                              style: TextStyle(
                                  color: color.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: allJobWorkerModel!.data![index].tags!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, indexs) {
                              return Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: color.primaryContainer,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    '${data.tags![indexs].name}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, left: 2, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 4,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: color.tertiary.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(2)),
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.company!.name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: color.tertiary
                                            .withOpacity(0.8)),
                                  ),
                                  Text(
                                    data.company!.location.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: color.tertiary
                                            .withOpacity(0.8)),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: color.primaryContainer.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(GetTimeAgo.parse(date, locale: 'id'),
                          style: TextStyle(
                              color: color.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                      SizedBox(
                        width: 13,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
