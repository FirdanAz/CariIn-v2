import 'package:cariin_v2/model/job_application_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../../common/app_assets.dart';
import '../../../../../common/app_color.dart';
import '../../../../../service/api_service.dart';

class MenungguTabs extends StatefulWidget {
  const MenungguTabs({Key? key}) : super(key: key);

  @override
  State<MenungguTabs> createState() => _MenungguTabsState();
}

class _MenungguTabsState extends State<MenungguTabs> {
  JobApplicationModel? jobApplicationModel;
  bool _isLoad = false;

  getdata() async {
    _isLoad = true;
    JobApplicationModel allJob = await ApiService().getLamaranResult(false, 'menunggu');
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

    return _isLoad ? const Center(child: CircularProgressIndicator(),) :
    Container(
      child: SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: jobApplicationModel!.data!.length,
          itemBuilder: (context, index) {
            var data = jobApplicationModel!.data![index];
            DateTime? date = DateTime.parse(data.createdAt.toString());
            return Container(
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
            );
          },
        ),
      ),
    );
  }
}
