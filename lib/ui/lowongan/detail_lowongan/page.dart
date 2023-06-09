import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JobDetailPage extends StatelessWidget {
  const JobDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final color = AppColor.theme(Brightness.light);
    final textTheme = Theme.of(context).textTheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Stack(
          children: [
            Image.network(
              'https://static01.nyt.com/images/2021/05/02/business/00google-office1/00google-office1-videoSixteenByNineJumbo1600.jpg',
              height: 260,
              width: screenSize.width,
              fit: BoxFit.cover,
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
                        height: screenSize.height,
                        width: screenSize.width,
                        padding:
                            const EdgeInsets.only(top: 50, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: color.surfaceContainer,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Sr. UX Designer",
                              style: textTheme.headlineMedium!
                                  .copyWith(color: color.onSurface),
                            ),
                            const SizedBox(height: 5),
                            _buildSubInfo(
                              color: color,
                              textTheme: textTheme,
                              company: "Google Cloud",
                              city: "New York",
                              uploadDistance: "2 hari",
                            ),
                            const SizedBox(height: 22),
                            _buildOtherInfo(
                              color: color,
                              textTheme: textTheme,
                              city: 'New York',
                              timeType: 'Full TIme',
                              salary: '2 jt/bulan',
                            ),
                            const SizedBox(height: 24),
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
    required TextTheme textTheme,
    required String company,
    required String city,
    required String uploadDistance,
  }) {
    final Widget dot = Container(
      height: 6,
      width: 6,
      margin: EdgeInsets.only(
        left: Responsive.byWidth(10),
        right: Responsive.byWidth(10),
        top: 2,
      ),
      decoration: BoxDecoration(color: color.onSurface, shape: BoxShape.circle),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(company, style: textTheme.titleLarge),
        dot,
        Text(city, style: textTheme.titleLarge),
        dot,
        Text(uploadDistance, style: textTheme.titleLarge),
      ],
    );
  }

  // Other info
  Widget _buildOtherInfo({
    required AppColorData color,
    required TextTheme textTheme,
    required String city,
    required String timeType,
    required String salary,
  }) {
    TextStyle titleStyle = TextStyle(
      fontSize: Responsive.fontSize(12),
      color: color.onSurfaceVariant,
    );

    Widget content(IconData icon, String title, String fill) {
      return Column(
        children: [
          Icon(icon, size: Responsive.byWidth(24), color: color.tertiary),
          const SizedBox(height: 5),
          Text(title, style: titleStyle),
          const SizedBox(height: 3),
          Text(fill, style: textTheme.titleLarge),
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
}
