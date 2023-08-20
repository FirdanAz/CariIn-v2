// ignore_for_file: unrelated_type_equality_checks, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:cariin_v2/service/api_service.dart';
import 'package:flutter/foundation.dart';

import '../common/public_function.dart';
import 'package:http/http.dart' as http;

class EditService {
  final _baseUrl = "https://cariin.my.id";

  Future getMyDeviceToken(String role) async {
    final endPoint = '/api/$role/me/device-token';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken(role);
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        await ApiService().RefreshToken(role, token);
        if (kDebugMode) {
          print('status code : ${response.statusCode}');
        }
        var result = json.decode(response.body);
        return result['data']['device_token'];
      }
      if (response.statusCode == 401 &&
          PublicFunction.getToken(role) != '') {
        await ApiService().RefreshToken(role, token);
        if (kDebugMode) {
          print('status code : ${response.statusCode}');
        }
        var result = json.decode(response.body);
        return result['data']['device_token'];
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  Future getCompanyDevice(String companyId) async {
    final endPoint = '/api/worker/companies/$companyId/device-token';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('worker');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        await ApiService().RefreshToken('worker', token);
        if (kDebugMode) {
          print('status code : ${response.statusCode}');
        }
        var result = json.decode(response.body);
        return result['data']['device_token'];
      }
      if (response.statusCode == 401 &&
          PublicFunction.getToken('worker') != '') {
        await ApiService().RefreshToken('worker', token);
        if (kDebugMode) {
          print('status code : ${response.statusCode}');
        }
        var result = json.decode(response.body);
        return result['data']['device_token'];
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getWorkerDevice(String workerId) async {
    final endPoint = '/api/company/workers/$workerId/device-token';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        await ApiService().RefreshToken('company', token);
        if (kDebugMode) {
          print('status code : ${response.statusCode}');
        }
        var result = json.decode(response.body);
        return result['data']['device_token'];
      }
      if (response.statusCode == 401 &&
          PublicFunction.getToken('company') != '') {
        await ApiService().RefreshToken('company', token);
        if (kDebugMode) {
          print('status code : ${response.statusCode}');
        }
        var result = json.decode(response.body);
        return result['data']['device_token'];
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future editMyDeviceToken(String deviceToken, String role) async {
    final endPoint = '/api/$role/me/device-token/edit';
    final url = '$_baseUrl$endPoint';
    final body = {
      'device_token': deviceToken,
    };
    String token = await PublicFunction.getToken(role);
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response =
      await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('add deviceToken success');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('status codeeee : ${response.statusCode}');
        }
        return false;
      }
    } on SocketException {
      if (kDebugMode) {
        print('Tidak koneksi Internet');
      }
      return false;
    } on HttpException {
      if (kDebugMode) {
        print('HttpException');
      }
      return false;
    }
  }

}