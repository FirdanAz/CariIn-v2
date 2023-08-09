class WorkerModel {
  bool? success;
  String? message;
  Data? data;

  WorkerModel({this.success, this.message, this.data});

  WorkerModel.fromJson(Map<String, dynamic> json) {
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
  String? bornDate;
  String? address;
  int? companyVisible;
  String? role;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.username,
        this.email,
        this.gender,
        this.phoneNumber,
        this.bornDate,
        this.address,
        this.companyVisible,
        this.role,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    bornDate = json['born_date'];
    address = json['address'];
    companyVisible = json['company_visible'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['born_date'] = this.bornDate;
    data['address'] = this.address;
    data['company_visible'] = this.companyVisible;
    data['role'] = this.role;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
