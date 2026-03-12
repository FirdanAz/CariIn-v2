import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());
class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? email;
  String? gender;
  String? phoneNumber;
  String? address;
  String? bornDate;
  String? role;

  Data(
      {this.username,
        this.email,
        this.gender,
        this.phoneNumber,
        this.address,
        this.bornDate,
        this.role});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    bornDate = json['born_date'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['born_date'] = this.bornDate;
    data['role'] = this.role;
    return data;
  }
}
