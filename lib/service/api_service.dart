import 'dart:convert';
import 'dart:io';

import 'package:cariin_v2/model/all_job_company_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../common/public_function.dart';

class ApiService {
  final _baseUrl = "http://192.168.75.143:8000";

  Future postLoginCompany(BuildContext context, String email, String password) async {
    const endPoint = '/api/company/login';
    final url = '$_baseUrl$endPoint';
    final body = {
      'email': email,
      'password': password,
    };
    final headers = {
      'Accept' : 'application/json'
    };

    try {
      final response = await http.post(Uri.parse(url), headers: headers ,body: body);
      if (response.statusCode == 200) {
        String token = json.decode(response.body)['data']['token'];
        print(token);
        await PublicFunction.setTokenCompany(token);
        return true;
      } else {
        print('Email atau Password salah');
        return false;
      }
    } on SocketException {
      print('Tidak koneksi Internet');
      return false;
    } on HttpException {
      print('HttpException');
      return false;
    }
  }

  Future AllJobsCompany() async {
    const endPoint = '/api/company/job/';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getTokenCompany();
    final headers = {
      'Authorization' : 'Bearer $token',
      'Accept' : 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        AllJobCompany model = AllJobCompany.fromJson(json.decode(response.body));
        print(model);
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

}