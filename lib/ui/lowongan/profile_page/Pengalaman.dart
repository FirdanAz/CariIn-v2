
import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PengalamanPage extends StatefulWidget {
  const PengalamanPage({super.key});

  @override
  State<PengalamanPage> createState() => _PengalamanPageState();
}

class _PengalamanPageState extends State<PengalamanPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            padding: EdgeInsets.zero,
            color: color.primary,
            height: 90,
            child: Text("Item $index",
              style: const TextStyle(fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}