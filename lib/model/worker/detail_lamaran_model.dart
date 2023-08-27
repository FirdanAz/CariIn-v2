class DetailLamaranModel {
  bool? success;
  String? message;
  Data? data;

  DetailLamaranModel({this.success, this.message, this.data});

  DetailLamaranModel.fromJson(Map<String, dynamic> json) {
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
  Job? job;
  Worker? worker;
  String? cvFile;
  String? description;
  String? confirmedStatus;
  String? createdAt;

  Data(
      {this.id,
        this.job,
        this.worker,
        this.cvFile,
        this.description,
        this.confirmedStatus,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    worker =
    json['worker'] != null ? new Worker.fromJson(json['worker']) : null;
    cvFile = json['cv_file'];
    description = json['description'];
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
    data['cv_file'] = this.cvFile;
    data['description'] = this.description;
    data['confirmed_status'] = this.confirmedStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Job {
  int? id;
  String? title;
  String? coverImage;
  String? location;
  Company? company;

  Job({this.id, this.title, this.coverImage, this.location, this.company});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    coverImage = json['cover_image'];
    location = json['location'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover_image'] = this.coverImage;
    data['location'] = this.location;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? profileImage;
  String? location;

  Company({this.id, this.name, this.profileImage, this.location});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['location'] = this.location;
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
