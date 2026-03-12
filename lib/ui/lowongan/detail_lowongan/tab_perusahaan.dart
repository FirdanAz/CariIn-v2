import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/view_image/view_image.dart';
import 'package:flutter/material.dart';

import '../../../model/company/detail_job_model.dart';

class TabPerusahaan extends StatefulWidget {
  TabPerusahaan({super.key, required this.id});
  int id;

  @override
  State<TabPerusahaan> createState() => _TabPerusahaanState();
}

class _TabPerusahaanState extends State<TabPerusahaan> {
  JobDetailModel? jobDetailModel;
  bool _isLoad = false;
  TextStyle _textStyle(Color color, FontWeight fontWeight) => TextStyle(
        fontSize: Responsive.fontSize(14),
        fontWeight: fontWeight,
        color: color,
      );

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
    final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad ? Container(height: 1000,) : Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.byWidth(15),
        vertical: Responsive.byWidth(10),
      ),
      child: SizedBox(
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
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
                                  Icons.person,
                                  size: 30,
                                  color: color.primary,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Perusahaan',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImagePage(title: 'Gambar Perusahaan', urlImage: 'https://cariin.my.id/storage/${jobDetailModel!.data!.backdropImage!}',),)),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage('https://cariin.my.id/storage/${jobDetailModel!.data!.backdropImage!}'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  width: double.maxFinite,
                                  child: Text(
                                    jobDetailModel!.data!.companyName!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: color.primary
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: double.maxFinite,
                                  child: Text(
                                    '${jobDetailModel!.data!.location!.location} ,Indonesia',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: double.maxFinite,
                                  child: Text(
                                    jobDetailModel!.data!.company!.foundingDate!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
