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
  int? id;
  String? username;
  String? email;
  Null? profilImage;
  Null? backdropImage;
  String? gender;
  String? phoneNumber;
  int? age;
  String? address;
  String? bornDate;
  String? interested;
  Null? description;
  bool? companyVisible;
  String? createdAt;

  Data(
      {this.id,
        this.username,
        this.email,
        this.profilImage,
        this.backdropImage,
        this.gender,
        this.phoneNumber,
        this.age,
        this.address,
        this.bornDate,
        this.interested,
        this.description,
        this.companyVisible,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    profilImage = json['profil_image'];
    backdropImage = json['backdrop_image'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    age = json['age'];
    address = json['address'];
    bornDate = json['born_date'];
    interested = json['interested'];
    description = json['description'];
    companyVisible = json['company_visible'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['profil_image'] = this.profilImage;
    data['backdrop_image'] = this.backdropImage;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['age'] = this.age;
    data['address'] = this.address;
    data['born_date'] = this.bornDate;
    data['interested'] = this.interested;
    data['description'] = this.description;
    data['company_visible'] = this.companyVisible;
    data['created_at'] = this.createdAt;
    return data;
  }
}
