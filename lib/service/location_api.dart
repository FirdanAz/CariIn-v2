// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';

import '../model/location_api/kabupaten_model.dart';
import '../model/location_api/kecamatan_model.dart';
import '../model/location_api/kelurahan_model.dart';
import '../model/location_api/province_model.dart';
import 'package:http/http.dart' as http;

class LocationApi {
  var base_url = 'https://api.binderbyte.com/wilayah';
  final api_key = '?api_key=316b97d86c4504d4d033f857d3ebff491105eb96567dce4a2fa46940d959ed80';

  Future getProvince() async {
    const midPoint = '/provinsi';
    final url = base_url + midPoint + api_key;

    try {
      final response = await http.get(Uri.parse(url));
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        ProvinceModel provinceModel = ProvinceModel.fromJson(
            json.decode(response.body));
        print(provinceModel);
        return provinceModel;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getKabupaten(String id) async {
    const midPoint = '/kabupaten';
    final endPoint = '&id_provinsi=$id';
    final url = base_url + midPoint + api_key + endPoint;

    try {
      final response = await http.get(Uri.parse(url));
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        KabupatenModel kabupatenModel = KabupatenModel.fromJson(
            json.decode(response.body));
        print(kabupatenModel);
        return kabupatenModel;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getKecamatan(String id) async {
    const midPoint = '/kecamatan';
    final endPoint = '&id_kabupaten=$id';
    final url = base_url + midPoint + api_key + endPoint;

    try {
      final response = await http.get(Uri.parse(url));
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        KecamatanModel kecamatanModel = KecamatanModel.fromJson(
            json.decode(response.body));
        print(kecamatanModel);
        return kecamatanModel;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getKelurahan(String id) async {
    const midPoint = '/kelurahan';
    final endPoint = '&id_kecamatan=$id';
    final url = base_url + midPoint + api_key + endPoint;

    try {
      final response = await http.get(Uri.parse(url));
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        KelurahanModel kelurahanModel = KelurahanModel.fromJson(
            json.decode(response.body));
        print(kelurahanModel);
        return kelurahanModel;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

}