import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/model/company/detail_job_model.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../view_image/view_image.dart';

class TabLocationWorker extends StatefulWidget {
  TabLocationWorker({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<TabLocationWorker> createState() => _TabLocationWorkeState();
}

class _TabLocationWorkeState extends State<TabLocationWorker> {
  JobDetailModel? jobDetailModel;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    await ApiService().RefreshToken('worker', await PublicFunction.getToken('worker'));
    JobDetailModel detailModel = await ApiService().jobDetailWorker(widget.id);
    setState(() {
      jobDetailModel = detailModel;
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
    return _isLoad ? Container(height: 500,) :
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: double.maxFinite,
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      color: color.background,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.maps_home_work_sharp,
                                  size: 30,
                                  color: color.primary,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Lokasi Perusahaan',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            ListTile(
                              leading: InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImagePage(title: 'Gambar Perusahaan', urlImage: 'https://cariin.my.id/storage/${jobDetailModel!.data!.backdropImage!}',),)),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage('https://cariin.my.id/storage/${jobDetailModel!.data!.backdropImage!}'),
                                ),
                              ),
                              title: Text(jobDetailModel!.data!.companyLocation!),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: double.maxFinite,
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      color: color.background,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.maps_home_work_sharp,
                                  size: 30,
                                  color: color.primary,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Lokasi Pekerjaan',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            ListTile(
                              leading: InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImagePage(title: 'Gambar Perusahaan', urlImage: 'https://cariin.my.id/storage/${jobDetailModel!.data!.backdropImage!}',),)),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage('https://cariin.my.id/storage/${jobDetailModel!.data!.coverImage!}'),
                                ),
                              ),
                              title: Text(jobDetailModel!.data!.location!.location!),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
