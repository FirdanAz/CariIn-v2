import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';

class LowonganPage extends StatefulWidget {
  const LowonganPage({Key? key}) : super(key: key);

  @override
  State<LowonganPage> createState() => _LowonganPageState();
}

class _LowonganPageState extends State<LowonganPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Lamaran', style: TextStyle(color: color.primary, fontSize: 18),),
      ),
      body: Container(
          margin: EdgeInsets.only(right: 10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 7,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 10),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(AppAssets.firdanImg),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Firdan Azhari',
                                  style: TextStyle(
                                      color: color.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 4,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: color.secondaryContainer
                                              .withOpacity(0.5),
                                          borderRadius:
                                          BorderRadius.circular(2)),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Jl.Kudus',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: color.secondaryContainer
                                                  .withOpacity(0.8)),
                                        ),
                                        Text(
                                          'Programmer',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: color.secondaryContainer
                                                  .withOpacity(0.8)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: color.white,
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 14, color: color.primary),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Lamaran',
                              style: TextStyle(
                                  color: color.white
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
      ),
    );

  }
}
