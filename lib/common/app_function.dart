import 'package:cariin_v2/ui/lowongan/detail_lowongan/lamar_proposal.dart';
import 'package:flutter/material.dart';

class AppFunction {}

class Navigate {
  Navigate(LamarDetail lamarDetail);

  static void push(BuildContext context, Widget page, LamarDetail lamarDetail) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushAndRemove(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static void pop(BuildContext context) => Navigator.pop(context);
}
