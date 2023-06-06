import 'package:cariin_v2/model/all_job_company_model.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/widget/home_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';
import '../../../lowongan/detail_lowongan/detail.dart';

class LowonganPage extends StatefulWidget {
  LowonganPage({Key? key}) : super(key: key);

  @override
  State<LowonganPage> createState() => _LowonganPageState();
}

class _LowonganPageState extends State<LowonganPage> {
  bool _isLoad = false;
  AllJobCompany? allJobCompany;

  getdata() async {
    _isLoad = true;
    AllJobCompany allJob = await ApiService().AllJobsCompany();
    setState(() {
      allJobCompany = allJob;
    });
    print(allJob);
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
    var color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad ? Center(child: CircularProgressIndicator(),) :
    Container(
      child: ListView.builder(
        itemCount: allJobCompany!.data!.length,
        itemBuilder: (context, index) {
          var job = allJobCompany!.data![index];
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailLowongan(),)),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: color.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
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
                          job.title.toString(),
                          style: TextStyle(
                              color: color.white,
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
                                  color: color.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: color.white.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '1 - 3 Tahun',
                              style: TextStyle(
                                  color: color.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: color.secondaryContainer,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Front End',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: color.primaryContainer,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Ui/Ux Designer',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: color.primaryContainer,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Hacker',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, left: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 4,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: color.secondaryContainer.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(2)),
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.city.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: color.secondaryContainer
                                            .withOpacity(0.8)),
                                  ),
                                  Text(
                                    job.company!.location.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: color.secondaryContainer
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
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('2 Jam yang lalu',
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
