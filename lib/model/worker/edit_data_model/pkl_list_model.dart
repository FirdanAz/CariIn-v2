class PklListModel {
  bool? success;
  String? message;
  List<Data>? data;

  PklListModel({this.success, this.message, this.data});

  PklListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  Job? job;
  Worker? worker;
  String? confirmedStatus;
  String? createdAt;

  Data({this.id, this.job, this.worker, this.confirmedStatus, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    worker =
    json['worker'] != null ? new Worker.fromJson(json['worker']) : null;
    confirmedStatus = json['confirmed_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    if (this.worker != null) {
      data['worker'] = this.worker!.toJson();
    }
    data['confirmed_status'] = this.confirmedStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Job {
  int? id;
  String? title;
  String? coverImage;

  Job({this.id, this.title, this.coverImage});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover_image'] = this.coverImage;
    return data;
  }
}

class Worker {
  int? id;
  String? username;
  String? profilImage;
  String? gender;
  int? age;
  String? address;
  String? interested;
  String? createdAt;

  Worker(
      {this.id,
        this.username,
        this.profilImage,
        this.gender,
        this.age,
        this.address,
        this.interested,
        this.createdAt});

  Worker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profilImage = json['profil_image'];
    gender = json['gender'];
    age = json['age'];
    address = json['address'];
    interested = json['interested'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['profil_image'] = this.profilImage;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['address'] = this.address;
    data['interested'] = this.interested;
    data['created_at'] = this.createdAt;
    return data;
  }
}
