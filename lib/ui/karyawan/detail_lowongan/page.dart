import 'package:cariin_v2/common/currency_format.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:cariin_v2/ui/karyawan/detail_lowongan/tab_perusahaan.dart';
import 'package:cariin_v2/ui/view_image/view_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:cariin_v2/ui/karyawan/detail_lowongan/tab_deskripsi.dart';
import 'package:cariin_v2/ui/widget/chip_tab_bar.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../model/company/detail_company_model.dart';

class CompanyJobDetailPage extends StatefulWidget {
  const CompanyJobDetailPage({super.key, required this.id});
  final int id;

  @override
  State<CompanyJobDetailPage> createState() => _CompanyJobDetailPageState();
}

class _CompanyJobDetailPageState extends State<CompanyJobDetailPage> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);
  DetailJobCompanyModel? detailCompanyModel;
  bool _isLoad = false;
  DateTime? date;
  String? desc;

  getdata() async {
    _isLoad = true;
    print('id :  ${widget.id}');
    DetailJobCompanyModel details = await ApiService().jobDetailCompany(widget.id);
    setState(() {
      detailCompanyModel = details;
      date = DateTime.parse(details.data!.jobCreated.toString());
      desc = details.data!.description!.description.toString();
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
      TabDeskripsi(id: widget.id,),
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
                  'https://cariin.my.id/storage/${detailCompanyModel!.data!.backdropImage}',
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
                                    '${detailCompanyModel!.data!.title}',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(16),
                                      fontWeight: FontWeight.w600,
                                      color: color.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  _buildSubInfo(
                                    color: color,
                                    company: "${detailCompanyModel!.data!.companyName}",
                                    city: '${detailCompanyModel!.data!.companyLocation}',
                                    uploadDistance: GetTimeAgo.parse(date!, locale: 'id'),
                                  ),
                                  const SizedBox(height: 22),
                                  _buildOtherInfo(
                                    color: color,
                                    education: 'Smk/Sma',
                                    timeType: '${detailCompanyModel!.data!.timeType}',
                                    salary: CurrencyFormat.convertToIdr(detailCompanyModel!.data!.salary, 0),
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
                          'https://cariin.my.id/storage/${detailCompanyModel!.data!.coverImage}')
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
          InkWell(
            onTap: () => PublicFunction.navigatorPush(context, ViewImagePage(title: 'Foto Cover', urlImage: url)),
            child: CircleAvatar(radius: 37.5, foregroundImage: NetworkImage(url))
          )
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
        Container(constraints: const BoxConstraints(maxWidth: 100),child: Text(city, style: textStyle, overflow: TextOverflow.ellipsis)),
        dot,
        Container(constraints: const BoxConstraints(maxWidth: 100),child: Text(uploadDistance, style: textStyle, overflow: TextOverflow.ellipsis)),
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
          content(Icons.location_on_outlined, 'Pendidikan', education),
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
              onPressed: () {},
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 15,),
                  Text("  Edit Lowongan", style: textStyle),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Responsive.byWidth(50),
            width: Responsive.byWidth(160),
            child: OutlinedButton(
              onPressed: () async {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: const Text('Hapus Lowongan', style: TextStyle(fontSize: 15),),
                    actions: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('Yakin untuk menghapush Lowongan ini?', style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Batal'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    ApiService().deleteJob(context: context, id: widget.id.toString());
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(indexs: 2),), (route) => false);
                                    setState(() {
                                      Navigator.of(context).initState();
                                    });
                                  },
                                  child: Text('Hapus'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: color.error),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, size: 15, color: color.error,),
                  Text("  Delete", style: TextStyle(color: color.error, fontSize: Responsive.fontSize(14), fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
