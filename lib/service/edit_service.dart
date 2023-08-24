// ignore_for_file: unrelated_type_equality_checks, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:cariin_v2/model/worker/detail_lamaran_model.dart';
import 'package:cariin_v2/model/worker/edit_data_model/pkl_detail_model.dart';
import 'package:cariin_v2/model/worker/edit_data_model/pkl_list_model.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:flutter/foundation.dart';

import '../common/public_function.dart';
import 'package:http/http.dart' as http;

import '../model/worker/edit_data_model/search_model.dart';
import '../model/worker/experience/experience_list.dart';

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

  Future createPkl(String jobId, String educationInstitution, String desc, File cvFile, File portoFile, File lamranFile , File studentEvidenceFile) async{
    var endPoint = '/api/worker/field-practices/create';
    final url = Uri.parse('$_baseUrl$endPoint');
    String token = await PublicFunction.getToken('worker');
    var body = {
      'job_id': jobId,
      'educational_institution': educationInstitution,
      'description': desc,
    };

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath('cv_file', cvFile.path))
      ..files.add(await http.MultipartFile.fromPath('portfolio_file', portoFile.path))
      ..files.add(await http.MultipartFile.fromPath('application_letter_file', lamranFile.path))
      ..files.add(await http.MultipartFile.fromPath('student_evidence_file', studentEvidenceFile.path));

    final response = await request.send().timeout(const Duration(seconds: 15));

    final res = await http.Response.fromStream(response);
    print(res.body);

    if (res.statusCode == 201) {
      return true;
    } else {
      print('HttpException');
      return false;
    }
  }

  Future detailLamaran(int id, String role) async {
    var endPoint = '/api/$role/job-applications/$id';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken(role);
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200 && token != '') {
        await ApiService().RefreshToken(role, token);
        DetailLamaranModel model =
        DetailLamaranModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 && token != '') {
        await ApiService().RefreshToken(role, token);
        DetailLamaranModel model =
        DetailLamaranModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPklList(bool isAll, String value, String role) async {
    final endPoint = '/api/$role/field-practices';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken(role);
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    if(isAll == true){
      try {
        final response = await http.get(Uri.parse(url), headers: headers);
        print('status code : ${response.statusCode}');
        if (response.statusCode == 200) {
          await ApiService().RefreshToken(role, token);
          PklListModel model =
          PklListModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 &&
            PublicFunction.getToken(role) != '') {
          await ApiService().RefreshToken(role, token);
          PklListModel model =
          PklListModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      } catch (e) {
        print(e.toString());
      }
    } else if(isAll == false) {
      try {
        final response = await http.get(Uri.parse('$url?confirmed_status=$value'), headers: headers);
        print('status code : ${response.statusCode}');
        if (response.statusCode == 200) {
          await ApiService().RefreshToken(role, token);
          PklListModel model =
          PklListModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 &&
            PublicFunction.getToken(role) != '') {
          await ApiService().RefreshToken(role, token);
          PklListModel model =
          PklListModel.fromJson(json.decode(response.body));
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

  Future getDetailPkl(int id, String role) async {
    var endPoint = '/api/$role/field-practices/$id';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken(role);
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200 && token != '') {
        await ApiService().RefreshToken(role, token);
        PklDetailModel model =
        PklDetailModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 && PublicFunction.getToken(role) != '') {
        await ApiService().RefreshToken(role, token);
        PklDetailModel model =
        PklDetailModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future pklDefineConfirmation(String confirmValue, String id) async {
    var endPoint = '/api/company/field-practices/$id/define-confirmation';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final body = {'confirmed_status': confirmValue};
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response =
      await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Define Confirmation Success');
        return true;
      } else {
        print(response.statusCode);
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

  Future getListSearch(String query) async {
    const endPoint = '/api/worker/search';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('worker');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      if(query == ''){
        final response = await http.get(Uri.parse('$url?query=api'), headers: headers);
        print('status code : ${response.statusCode}');
        if (response.statusCode == 200 && token != '') {
          await ApiService().RefreshToken('worker', token);
          WorkerSearchModel model =
          WorkerSearchModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 && PublicFunction.getToken('worker') != '') {
          await ApiService().RefreshToken('worker', token);
          WorkerSearchModel model =
          WorkerSearchModel.fromJson(json.decode(response.body));
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      } else {
        final response = await http.get(Uri.parse('$url?query=$query'), headers: headers);
        print('status code : ${response.statusCode}');
        if (response.statusCode == 200 && token != '') {
          await ApiService().RefreshToken('worker', token);
          WorkerSearchModel model =
          WorkerSearchModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 && PublicFunction.getToken('worker') != '') {
          await ApiService().RefreshToken('worker', token);
          WorkerSearchModel model =
          WorkerSearchModel.fromJson(json.decode(response.body));
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getListExperience() async {
    const endPoint = '/api/worker/experiences';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('worker');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200 && token != '') {
        await ApiService().RefreshToken('worker', token);
        ListExperienceModel model =
        ListExperienceModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 && PublicFunction.getToken('worker') != '') {
        await ApiService().RefreshToken('worker', token);
        ListExperienceModel model =
        ListExperienceModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}