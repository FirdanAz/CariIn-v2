import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendidikanPage extends StatefulWidget {
  const PendidikanPage({super.key});

  @override
  State<PendidikanPage> createState() => _PendidikanPageState();
}

class _PendidikanPageState extends State<PendidikanPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
            children: [
              Container(
                height: 90,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color.surfaceContainer,
                ),
                child: Text('SMK Raden Umar Said Kudus',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),),
              ),

            ],
          );
  }
}