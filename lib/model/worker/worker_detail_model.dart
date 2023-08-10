class WorkerDetailModel {
  bool? success;
  String? message;
  Data? data;

  WorkerDetailModel({this.success, this.message, this.data});

  WorkerDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? username;
  String? email;
  String? gender;
  int? age;
  String? address;
  String? bornDate;
  String? interested;
  String? description;
  String? createdAt;

  Data(
      {this.id,
        this.username,
        this.email,
        this.gender,
        this.age,
        this.address,
        this.bornDate,
        this.interested,
        this.description,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    address = json['address'];
    bornDate = json['born_date'];
    interested = json['interested'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['address'] = this.address;
    data['born_date'] = this.bornDate;
    data['interested'] = this.interested;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
