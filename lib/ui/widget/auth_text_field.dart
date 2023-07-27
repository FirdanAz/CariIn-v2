import 'package:flutter/material.dart';

import '../../common/app_color.dart';

// ignore: must_be_immutable
class TextFieldComp extends StatefulWidget {
  TextFieldComp({Key? key, required this.emailController, required this.hintText}) : super(key: key);
  TextEditingController emailController;
  String hintText;

  @override
  State<TextFieldComp> createState() => _TextFieldCompState();
}

class _TextFieldCompState extends State<TextFieldComp> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return TextField(
      controller: widget.emailController,
      textAlign: TextAlign.left,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintStyle: const TextStyle(color: Colors.black45),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: color.secondary.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(10)),
        hintText: widget.hintText,
      ),
    );
  }
}
