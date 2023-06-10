import 'package:cariin_v2/ui/lowongan/detail_lowongan/tab_perusahaan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:cariin_v2/ui/lowongan/detail_lowongan/tab_deskripsi.dart';
import 'package:cariin_v2/ui/widget/chip_tab_bar.dart';

class JobDetailPage extends StatelessWidget {
  JobDetailPage({super.key});
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Theme.of(context).brightness);

    // Ditaruh di build biar bisa menerima model
    final List<Widget> _tabView = [
      TabDeskripsi(),
      TabPerusahaan(),
      SizedBox(height: screenSize.height, child: const Text('Tab 3')),
      SizedBox(height: screenSize.height, child: const Text('Tab 4')),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://static01.nyt.com/images/2021/05/02/business/00google-office1/00google-office1-videoSixteenByNineJumbo1600.jpg',
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
                )
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
                                    "Sr. UX Designer",
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(16),
                                      fontWeight: FontWeight.w600,
                                      color: color.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  _buildSubInfo(
                                    color: color,
                                    company: "Google Cloud",
                                    city: "New York",
                                    uploadDistance: "2 hari",
                                  ),
                                  const SizedBox(height: 22),
                                  _buildOtherInfo(
                                    color: color,
                                    city: 'New York',
                                    timeType: 'Full TIme',
                                    salary: '2 jt/bulan',
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
                                return _tabView[value];
                              },
                            ),
                          ],
                        ),
                      ),

                      // Photoprofil
                      _buildPoster(color,
                          'https://cloud.google.com/_static/cloud/images/social-icon-google-cloud-1200-630.png?hl=id')
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
    required String city,
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
          content(Icons.location_on_outlined, 'Lokasi', city),
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
              child: Text("Lamar", style: textStyle),
            ),
          ),
          SizedBox(
            height: Responsive.byWidth(50),
            width: Responsive.byWidth(160),
            child: OutlinedButton(
              onPressed: () {},
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
