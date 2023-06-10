import 'package:flutter/material.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';
import '../../../lowongan/chat_page/chat_pekerja.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPekerja(message: 'message')));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: color.surfaceContainer,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.maxFinite,
                              height: 75,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                      AssetImage(AppAssets.firdanImg),
                                    ),
                                    Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 13),
                                                    padding: EdgeInsets.only(
                                                        top: 15),
                                                    child: Text(
                                                      'Milkita',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin:
                                                          EdgeInsets.only(
                                                              left: 7),
                                                          //padding: EdgeInsets.only(top: 3),
                                                          child: Text(
                                                            'Halo, saya ingin melamar pekerjaan',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                            CircleAvatar(
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                              radius: 10,
                                              backgroundColor: color.primary,
                                            )
                                          ],
                                        ))
                                  ])),
                        );
                      })
                ])),
      ));
  }
}
