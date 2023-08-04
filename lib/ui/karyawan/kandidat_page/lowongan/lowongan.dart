import 'package:cariin_v2/model/all_job_company_model.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/karyawan/detail_lowongan/page.dart';
import 'package:cariin_v2/ui/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';
import '../../../lowongan/detail_lowongan/page.dart';
import '../../form/lowongan/create_lowongan.dart';
import '../../form/rincian_usaha/rincian_usaha.dart';

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

    return _isLoad
        ? Center(
            child: CircularProgressIndicator(),
          )
        : allJobCompany!.data!.length != 0 ? Container(
            child: ListView.builder(
              itemCount: allJobCompany!.data!.length,
              itemBuilder: (context, index) {
                var job = allJobCompany!.data![index];
                DateTime? date = DateTime.parse(job.createdAt.toString());
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyJobDetailPage(id: int.parse(allJobCompany!.data![index].id.toString()),),
                      )),
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
                              offset:
                                  Offset(2, 2), // changes position of shadow
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
                                    backgroundColor:
                                        color.white.withOpacity(0.5),
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
                                          color: color.secondaryContainer
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.company!.name.toString(),
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
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset:
                                  Offset(2, 2), // changes position of shadow
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
          ):
    Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: color.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppAssets.wIcon, width: 40,),
              ),
            ),
            SizedBox(height: 25,),
            Text(
              'Belum ada pelamar',
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 50,),
            Container(
              width: 200,
              child: Text(
                'Buat lowongan untuk mendapatkan Pelamar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 40
              ),
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateLowonganPage(),)),
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(color: color.primary,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(
                      'Buat Lowongan',
                      style: TextStyle(
                          fontSize: 15,
                          color: color.white
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
