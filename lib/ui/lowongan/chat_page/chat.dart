import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final color = AppColor.theme(MediaQuery.of(context).platformBrightness);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Container(
            child: InkWell(
              onTap: () => Navigator.of(context).pop(true),
              child: Icon(Icons.arrow_back_ios),
            ),
            margin: EdgeInsets.only(left: 15),
          ),
          centerTitle: true,
          title: Text(
            'Pesan Masuk',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          toolbarHeight: 80,
          backgroundColor: color.surface,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              width: double.maxFinite,
              color: color.secondary,
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                            color: color.surfaceContainer,
                            borderRadius: BorderRadius.circular(10)),
                        width: double.maxFinite,
                        height: 75,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(AppAssets.firdanImg),
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Container(
                                  margin: EdgeInsets.only(left: 13),
                                  padding: EdgeInsets.only(top: 15),
                                  width: double.maxFinite,
                                  child: Text(
                                    'Milkita',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 13),
                                  padding: EdgeInsets.only(top: 5),
                                  width: double.maxFinite,
                                  child: Text(
                                    'Halo, saya ingin melamar pekerjaan',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ]))
                        ]));
                  })
            ]
            )
            ));
  }
}
