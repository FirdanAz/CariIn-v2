import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicFunction{
  static Future<bool> setTokenCompany(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('tokenCompany', value);
  }
  static Future<String> getTokenCompany() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tokenCompany') ?? '';
  }
  static Future<bool> setTokenWorker(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('tokenWorker', value);
  }
  static Future<String> getTokenWorker() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tokenWorker') ?? '';
  }
  static Future<bool> removeToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(token);
  }

  static void navigatorPushAndRemoved(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }
}