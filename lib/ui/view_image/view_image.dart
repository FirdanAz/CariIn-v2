// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ViewImagePage extends StatelessWidget {
  ViewImagePage({Key? key, required this.title, required this.urlImage}) : super(key: key);
  String title;
  String urlImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: Image.network(urlImage),
      ),
    );
  }
}
