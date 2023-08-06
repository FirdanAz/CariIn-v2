import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeterampilanPage extends StatefulWidget {
  const KeterampilanPage({super.key});

  @override
  State<KeterampilanPage> createState() => _KeterampilanPageState();
}

class _KeterampilanPageState extends State<KeterampilanPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: color.primaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              width: double.maxFinite,
              height: 75,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Java Script',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Text('Certifikasi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                              ),
                            ],
                          )
                        ]
                    )
                  ]
              )
          ),
          Container(
              decoration: BoxDecoration(
                  color: color.primaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              width: double.maxFinite,
              height: 75,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'C#',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Text('Certifikasi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]
                    )
                  ]
              )
          )
        ]
    );
  }
}