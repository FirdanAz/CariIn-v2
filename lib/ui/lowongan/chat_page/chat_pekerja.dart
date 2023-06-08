import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ChatPekerja extends StatelessWidget {
  ChatPekerja({Key? key, required this.message}) : super(key: key);

  String message;

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
          'Milkita',
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        margin: EdgeInsets.only(top: 30, left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color.primary,
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
