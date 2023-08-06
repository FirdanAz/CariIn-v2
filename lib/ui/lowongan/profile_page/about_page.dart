import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      backgroundColor: color.surface,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(''),
              Column(
                children: [
                  Text(
                    'Tentang Kami',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: color.primary,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Aplikasi CariIn membantu pekerja mendapatkan segala kemudahan dalam kebutuhan mencari sebuah pekerjaan. Kami mengajak untuk lebih peduli terhadap personal dan kemampuan individu, untuk menjadi istimewa dalam kemampuan maupun kepribadian. Kini. kamu tidak lagi berjuang demi sebuah ketidakpastian, poles dirimu, dan jadilah istimewa diantara yang lain!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: color.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Di CariIn, Mudah jadi Nyata!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: color.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Version 19.0.05',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: color.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
