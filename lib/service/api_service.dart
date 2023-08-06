// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:cariin_v2/model/job_company_model.dart';
import 'package:cariin_v2/model/all_job_worker_model.dart';
import 'package:cariin_v2/model/detail_company_model.dart';
import 'package:cariin_v2/model/detail_job_model.dart';
import 'package:cariin_v2/model/detail_pelamar_model.dart';
import 'package:cariin_v2/model/job_application_model.dart';
import 'package:cariin_v2/model/job_tag_list_model.dart';
import 'package:cariin_v2/model/list_worker_model.dart';
import 'package:cariin_v2/model/profil_company_model.dart';
import 'package:cariin_v2/model/worker_application_model.dart';
import 'package:cariin_v2/model/worker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../common/public_function.dart';

class ApiService {
  final _baseUrl = "https://cariin.my.id";

  Future postLogin(
      BuildContext context, String email, String password, String role) async {
    var endPoint = '/api/$role/login';
    final url = '$_baseUrl$endPoint';
    final body = {
      'email': email,
      'password': password,
    };
    final headers = {'Accept': 'application/json'};

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        String token = json.decode(response.body)['data']['token'];
        if (kDebugMode) {
          print(token);
        }
        await PublicFunction.setTokenCompany(token, role);
        return true;
      } else {
        if (kDebugMode) {
          print('Email atau Password salah');
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

  Future postRegisterCompany(BuildContext context, String email,
      String password, String name, String field) async {
    var endPoint = '/api/company/register';
    final url = '$_baseUrl$endPoint';
    final body = {
      'name': name,
      'email': email,
      'password': password,
      'field': field
    };
    final headers = {'Accept': 'application/json'};

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('register sukses');
        }
        await postLogin(context, email, password, 'company');
        return true;
      } else {
        if (kDebugMode) {
          print(response.statusCode);
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

  Future AllJobsWorker() async {
    const endPoint = '/api/worker/jobs';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('worker');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (kDebugMode) {
        print('status code : ${response.statusCode}');
      }
      if (response.statusCode == 200) {
        await RefreshToken('worker', token);
        AllJobWorkerModel model =
            AllJobWorkerModel.fromJson(json.decode(response.body));
        if (kDebugMode) {
          print(model);
        }
        return model;
      }
      if (response.statusCode == 401 &&
          PublicFunction.getToken('worker') != '') {
        await RefreshToken('worker', token);
        AllJobWorkerModel model =
            AllJobWorkerModel.fromJson(json.decode(response.body));
        if (kDebugMode) {
          print(model);
        }
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future RefreshToken(String role, String oldToken) async {
    if (kDebugMode) {
      print('refresh token');
    }
    final urlRToken = '$_baseUrl/api/refresh-token';
    final headers = {
      'Authorization': 'Bearer $oldToken',
      'Accept': 'application/json'
    };

    try {
      final response = await http.post(Uri.parse(urlRToken), headers: headers);
      if (response.statusCode == 200) {
        String token = json.decode(response.body)['data']['token'];
        await PublicFunction.setTokenCompany(token, role);
      } else if (role == 'comapany') {
        if (kDebugMode) {
          print('error auth');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future jobsCompany(bool isAll, String confirmedStatus) async {
    const endPoint = '/api/company/jobs';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    if (isAll == true) {
      try {
        final response = await http.get(Uri.parse(url), headers: headers);
        if (response.statusCode == 200) {
          print('status code : ${response.statusCode}');
          await RefreshToken('company', token);
          JobCompanyModel model =
              JobCompanyModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 &&
            PublicFunction.getToken('company') != '') {
          await RefreshToken('company', token);
          JobCompanyModel model =
              JobCompanyModel.fromJson(json.decode(response.body));
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      var queryParams = 'confirmed_status=$confirmedStatus';
      try {
        print('$url?$queryParams');
        final response =
            await http.get(Uri.parse('$url?$queryParams'), headers: headers);
        if (response.statusCode == 200) {
          print('status code : ${response.statusCode}');
          await RefreshToken('company', token);
          JobCompanyModel model =
              JobCompanyModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 &&
            PublicFunction.getToken('company') != '') {
          await RefreshToken('company', token);
          JobCompanyModel model =
              JobCompanyModel.fromJson(json.decode(response.body));
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future ProfilCompany() async {
    const endPoint = '/api/company/me';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        await RefreshToken('company', token);
        print('status code : ${response.statusCode}');
        ProfilCompanyModel model =
            ProfilCompanyModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 &&
          PublicFunction.getToken('company') != '') {
        await RefreshToken('company', token);
        ProfilCompanyModel model =
            ProfilCompanyModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future jobDetailCompany(int id) async {
    var endPoint = '/api/company/jobs/$id';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200 && token != '') {
        await RefreshToken('company', token);
        DetailJobCompanyModel model =
            DetailJobCompanyModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 && token != '') {
        await RefreshToken('company', token);
        DetailJobCompanyModel model =
            DetailJobCompanyModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future jobDetailWorker(int id) async {
    var endPoint = '/api/worker/jobs/$id';
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
        await RefreshToken('worker', token);
        JobDetailModel model =
            JobDetailModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 && token != '') {
        await RefreshToken('worker', token);
        JobDetailModel model =
            JobDetailModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteJob({required BuildContext context, required String id}) async {
    var endPoint = '/api/company/jobs/delete/$id';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {'Authorization': 'Bearer $token'};
    try {
      var response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print('delete sukses');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getWorker() async {
    const endPoint = '/api/worker/me';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('worker');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        await RefreshToken('worker', token);
        WorkerModel model = WorkerModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 &&
          PublicFunction.getToken('worker') != '') {
        await RefreshToken('worker', token);
        WorkerModel model = WorkerModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future ListWorkerCompany() async {
    const endPoint = '/api/company/workers';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        await RefreshToken('company', token);
        WorkerListModel model =
            WorkerListModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 &&
          PublicFunction.getToken('company') != '') {
        await RefreshToken('company', token);
        WorkerListModel model =
            WorkerListModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postRegisterWorker(
      BuildContext context,
      String email,
      String password,
      String name,
      String gender,
      String phone_number,
      String born_date,
      String address) async {
    var endPoint = '/api/worker/register';
    final url = '$_baseUrl$endPoint';
    final body = {
      'username': name,
      'email': email,
      'password': password,
      'gender': gender,
      'phone_number': phone_number,
      'born_date': born_date,
      'address': address
    };
    final headers = {'Accept': 'application/json'};

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('register sukses');
        await postLogin(context, email, password, 'worker');
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

  Future postWorkerJob(
      BuildContext context, String jobId, String description) async {
    var endPoint = '/api/worker/job-applications/create';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('worker');
    final body = {
      'job_id': jobId,
      'description': description,
    };
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('Lamaran sukses');
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

  Future getLamaranResult(bool all, String value) async {
    const endPoint = '/api/worker/job-applications';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('worker');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    var queryParams = 'confirmed_status=$value';

    try {
      print('$url?$queryParams');
      if (all == false) {
        final response =
            await http.get(Uri.parse('$url?$queryParams'), headers: headers);
        if (response.statusCode == 200) {
          print('status code : ${response.statusCode}');
          await RefreshToken('worker', token);
          JobApplicationModel model =
              JobApplicationModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 &&
            PublicFunction.getToken('worker') != '') {
          await RefreshToken('worker', token);
          JobApplicationModel model =
              JobApplicationModel.fromJson(json.decode(response.body));
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      } else {
        final response = await http.get(Uri.parse(url), headers: headers);
        if (response.statusCode == 200) {
          print('status code : ${response.statusCode}');
          await RefreshToken('worker', token);
          JobApplicationModel model =
              JobApplicationModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 &&
            PublicFunction.getToken('worker') != '') {
          await RefreshToken('worker', token);
          JobApplicationModel model =
              JobApplicationModel.fromJson(json.decode(response.body));
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getWorkerResult(bool all, String value) async {
    const endPoint = '/api/company/job-applications';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    var queryParams = 'confirmed_status=$value';

    try {
      if (all == false) {
        final response =
            await http.get(Uri.parse('$url?$queryParams'), headers: headers);
        if (response.statusCode == 200) {
          print('status code : ${response.statusCode}');
          await RefreshToken('company', token);
          WorkerApplicationModel model =
              WorkerApplicationModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 &&
            PublicFunction.getToken('company') != '') {
          await RefreshToken('company', token);
          WorkerApplicationModel model =
              WorkerApplicationModel.fromJson(json.decode(response.body));
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      } else {
        final response = await http.get(Uri.parse(url), headers: headers);
        if (response.statusCode == 200) {
          print('status code : ${response.statusCode}');
          await RefreshToken('company', token);
          WorkerApplicationModel model =
              WorkerApplicationModel.fromJson(json.decode(response.body));
          print(model);
          return model;
        }
        if (response.statusCode == 401 &&
            PublicFunction.getToken('company') != '') {
          await RefreshToken('company', token);
          WorkerApplicationModel model =
              WorkerApplicationModel.fromJson(json.decode(response.body));
          return model;
        } else {
          throw Exception("Failed to fetch data from API");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future detailPelamar(int id) async {
    var endPoint = '/api/company/job-applications/$id';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200 && token != '') {
        await RefreshToken('company', token);
        DetailPelamarModel model =
            DetailPelamarModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      }
      if (response.statusCode == 401 && token != '') {
        await RefreshToken('company', token);
        DetailPelamarModel model =
            DetailPelamarModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future defineConfirmation(
      BuildContext context, String confirmValue, String id) async {
    var endPoint = '/api/company/job-applications/$id/define-confirmation';
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
        print('Lamaran diterima');
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

  Future postcreateLowongan(
      BuildContext context,
      String title,
      File coverImage,
      File backdropImage,
      String location,
      String time_type,
      String salary,
      String companyId,
      String gender,
      String education,
      String minimum_age,
      String maximum_age,
      String description,
      List<int> tags,
      String pkl_status) async {
    var endPoint = '/api/company/jobs/create';
    final url = Uri.parse('$_baseUrl$endPoint');
    String token = await PublicFunction.getToken('company');
    var body = {
      "title": title,
      "location": location,
      "time_type": time_type,
      "salary": salary,
      "company_id": companyId,
      "gender": gender,
      "education": education,
      "minimum_age": minimum_age,
      "maximum_age": maximum_age,
      "description": description,
      "tags[0]": '1',
      "tags[1]": '4',
      "tags[2]": '7',
      "pkl_status": pkl_status
    };

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields.addAll(body)
      ..files.add(
          await http.MultipartFile.fromPath('cover_image', coverImage.path))
      ..files.add(await http.MultipartFile.fromPath(
          'backdrop_image', backdropImage.path));

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

  Future getTagList() async {
    const endPoint = '/api/company/jobs/available-tags';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('company');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        await RefreshToken('company', token);
        JobTagListModel model = jobTagListModelFromJson(response.body);
        print(model);
        return model;
      }
      if (response.statusCode == 401 &&
          PublicFunction.getToken('company') != '') {
        await RefreshToken('company', token);
        JobTagListModel model = jobTagListModelFromJson(response.body);
        print(model);
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postFillDataCompany(
      BuildContext context,
      File profilImage,
      String foundingDate,
      String userType,
      String location,
      String description,
      File insideImage,
      File outsideImage,
      ) async {
    var endPoint = '/api/company/fill-data';
    final url = Uri.parse('$_baseUrl$endPoint');
    String token = await PublicFunction.getToken('company');
    var body = {
      'founding_date': foundingDate,
      'user_type': userType,
      'location': location,
      'description': description,
    };

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath('profile_image', profilImage.path))
      ..files.add(await http.MultipartFile.fromPath('inside_image', insideImage.path))
      ..files.add(await http.MultipartFile.fromPath('outside_image', outsideImage.path));

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

   Future logoutWorker() async {
    const endPoint = '/api/worker/logout';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken('worker');

    final headers = {
      'Authorization' : 'Bearer $token'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        final response = await PublicFunction.removeToken(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
