import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicFunction{
  static Future<bool> setTokenCompany(String value, String role, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> token  = {
      "role" : role,
      "email" : email,
      "token" : value
    };
    String encodedMap = json.encode(token);

    return prefs.setString("token", encodedMap);

  }
  static Future<String> getToken(String role) async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    if(prefs.getString("token") != null){
      final dataToken = json.decode(prefs.getString('token').toString()) as Map<String, dynamic>;

      print(dataToken);

      if(dataToken['role'] == role){
        var token = dataToken['token'];
        return token;
      }
      else{
        return '';
      }
    }
    else {
      return '';
    }
  }

  static Future<bool> removeToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(token);
  }

  static void navigatorPushAndRemoved(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }

  static AlertDialog showDialog(BuildContext context, String massage){
    return AlertDialog(
      content: Text(
        massage,
        style: const TextStyle(fontSize: 15),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Iya")),
      ],
    );
  }
}