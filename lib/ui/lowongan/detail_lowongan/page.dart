// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/ui/lowongan/detail_lowongan/tab_perusahaan.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/lamar_process_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:cariin_v2/ui/lowongan/detail_lowongan/tab_deskripsi.dart';
import 'package:cariin_v2/ui/widget/chip_tab_bar.dart';
import 'package:get_time_ago/get_time_ago.dart';
import '../../../common/currency_format.dart';
import '../../../common/public_function.dart';
import '../../../model/company/detail_job_model.dart';
import '../../../service/api_service.dart';

// ignore: must_be_immutable
class JobDetailPage extends StatefulWidget {
  JobDetailPage({super.key, required this.id});
  int id;

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);
  JobDetailModel? jobDetailModel;
  bool _isLoad = false;
  DateTime? date;

  getdata() async {
    _isLoad = true;
    JobDetailModel detailJob = await ApiService().jobDetailWorker(widget.id);
    setState(() {
      jobDetailModel = detailJob;
      date = DateTime.parse(detailJob.data!.jobCreated.toString());
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
    final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Theme.of(context).brightness);

    // Ditaruh di build biar bisa menerima model
    final List<Widget> tabView = [
      TabDeskripsi(id: widget.id),
      const TabPerusahaan(),
      SizedBox(height: screenSize.height, child: const Text('Tab 3')),
      SizedBox(height: screenSize.height, child: const Text('Tab 4')),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: _isLoad ? const Scaffold(body: Center(child: CircularProgressIndicator(),),) : Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://cariin.my.id/storage/${jobDetailModel!.data!.backdropImage}',
                  height: Responsive.byHeight(260),
                  width: screenSize.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: Responsive.byHeight(260),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.25),
                        Colors.black.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Responsive.byHeight(163)),
                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: screenSize.width,
                        padding: const EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                          color: color.surfaceContainer,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            // Header
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.byWidth(15)),
                              child: Column(
                                children: [
                                  Text(
                                    '${jobDetailModel!.data!.title}',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(16),
                                      fontWeight: FontWeight.w600,
                                      color: color.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  _buildSubInfo(
                                    color: color,
                                    company: "${jobDetailModel!.data!.companyName}",
                                    city: '${jobDetailModel!.data!.companyLocation}',
                                    uploadDistance: GetTimeAgo.parse(date!, locale: 'id'),
                                  ),
                                  const SizedBox(height: 22),
                                  _buildOtherInfo(
                                    color: color,
                                    education: 'Smk/Sma',
                                    timeType: '${jobDetailModel!.data!.timeType}',
                                    salary: CurrencyFormat.convertToIdr(jobDetailModel!.data!.salary, 0),
                                  ),
                                  const SizedBox(height: 14),
                                ],
                              ),
                            ),

                            // TabBar
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ChipTabBar(
                                length: 4,
                                itemDistance: Responsive.byWidth(12),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.byWidth(15),
                                  vertical: Responsive.byWidth(10),
                                ),
                                tabLabels: const [
                                  "Deskripsi",
                                  "Perusahaan",
                                  "Lokasi",
                                  "Lainnya",
                                ],
                                onTap: (value) => _tabIndex.value = value,
                              ),
                            ),

                            // TabBar View
                            ValueListenableBuilder<int>(
                              valueListenable: _tabIndex,
                              builder: (context, value, child) {
                                return tabView[value];
                              },
                            ),
                          ],
                        ),
                      ),

                      // Photoprofil
                      _buildPoster(color,
                          'https://cariin.my.id/storage/${jobDetailModel!.data!.coverImage}')
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: _buildBottomAppBar(color),
      ),
    );
  }

  // Buat gambar lingkaran di tengah layar
  Widget _buildPoster(AppColorData color, String url) {
    return Positioned(
      top: -43,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
                color: color.surfaceContainer, shape: BoxShape.circle),
          ),
          CircleAvatar(radius: 37.5, foregroundImage: NetworkImage(url))
        ],
      ),
    );
  }

  // Sub info
  Widget _buildSubInfo({
    required AppColorData color,
    required String company,
    required String city,
    required String uploadDistance,
  }) {
    final TextStyle textStyle = TextStyle(
      fontSize: Responsive.fontSize(14),
      fontWeight: FontWeight.w500,
      color: color.onSurface,
    );

    final Widget dot = Container(
      height: 6,
      width: 6,
      margin: EdgeInsets.only(
          left: Responsive.byWidth(10), right: Responsive.byWidth(10), top: 2),
      decoration: BoxDecoration(color: color.onSurface, shape: BoxShape.circle),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(company, style: textStyle),
        dot,
        Text(city, style: textStyle),
        dot,
        Text(uploadDistance, style: textStyle),
      ],
    );
  }

  // Other info
  Widget _buildOtherInfo({
    required AppColorData color,
    required String education,
    required String timeType,
    required String salary,
  }) {
    Widget content(IconData icon, String title, String fill) {
      return Column(
        children: [
          Icon(icon, size: Responsive.byWidth(24), color: color.tertiary),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
                fontSize: Responsive.fontSize(12),
                color: color.onSurfaceVariant),
          ),
          const SizedBox(height: 3),
          Text(
            fill,
            style: TextStyle(
                fontSize: Responsive.fontSize(14),
                fontWeight: FontWeight.w500,
                color: color.onSurface),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1, color: color.outline),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          content(Icons.cast_for_education, 'Pendidikan', education),
          content(Icons.access_time, 'Tipe Pekerjaan', timeType),
          content(Icons.monetization_on_outlined, 'Gaji', salary),
        ],
      ),
    );
  }

  // Bottom button
  Widget _buildBottomAppBar(AppColorData color) {
    final TextStyle textStyle = TextStyle(
        fontSize: Responsive.fontSize(14), fontWeight: FontWeight.w500);

    showLoaderDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(backgroundColor: color.secondary),
            const SizedBox(width: 14),
            const Text("Loading..."),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }


    return BottomAppBar(
      height: Responsive.byWidth(70),
      color: color.surfaceContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: Responsive.byWidth(50),
            width: Responsive.byWidth(160),
            child: FilledButton(
              onPressed: () async {
                showLoaderDialog(context);
                await Future.delayed(const Duration(seconds: 2));
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LamarProcessPage(title: '${jobDetailModel!.data!.title}', jobId: jobDetailModel!.data!.id!.toInt()),));
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Lamar", style: textStyle),
            ),
          ),
          SizedBox(
            height: Responsive.byWidth(50),
            width: Responsive.byWidth(160),
            child: OutlinedButton(
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  return PublicFunction.showDialog(context, 'Belum Tersedia :)');
                },);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: color.primary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("PKL", style: textStyle),
            ),
          ),
        ],
      ),
    );
  }
}
