import 'dart:convert';
import 'dart:io';
import 'package:cariin_v2/model/accepted_job_model.dart';
import 'package:cariin_v2/model/all_job_company_model.dart';
import 'package:cariin_v2/model/detail_company_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../common/public_function.dart';

class ApiService {
  final _baseUrl = "http://192.168.8.52:8000";

  Future postLogin(BuildContext context, String email, String password, String role) async {
    var endPoint = '/api/$role/login';
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

  Future AcceptedJob() async {
    const endPoint = '/api/company/job/accepted';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getTokenCompany();
    final headers = {
      'Authorization' : 'Bearer $token',
      'Accept' : 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print('status code : ${response.statusCode}');
        AcceptedJobCompany model = AcceptedJobCompany.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if(response.statusCode == 401){
        print('status code : ${response.statusCode}');
        if(PublicFunction.getTokenCompany() != ''){
          print('tidak kosong');



        } else {
          print('data kosong!');
        }
      }
      else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDetail(int id) async {
    var endPoint = '/api/company/job/$id';
    final url = '$_baseUrl$endPoint';

    try {
      final response = await http.get(Uri.parse(url));
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        DetailCompanyModel model = DetailCompanyModel.fromJson(json.decode(response.body));
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