class PklDetailModel {
  bool? success;
  String? message;
  Data? data;

  PklDetailModel({this.success, this.message, this.data});

  PklDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? portfolioFile;
  String? applicationLetterFile;
  String? studentEvidenceFile;
  String? educationalInstitution;
  String? description;
  String? confirmedStatus;
  String? createdAt;

  Data(
      {this.id,
        this.job,
        this.worker,
        this.cvFile,
        this.portfolioFile,
        this.applicationLetterFile,
        this.studentEvidenceFile,
        this.educationalInstitution,
        this.description,
        this.confirmedStatus,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    worker =
    json['worker'] != null ? new Worker.fromJson(json['worker']) : null;
    cvFile = json['cv_file'];
    portfolioFile = json['portfolio_file'];
    applicationLetterFile = json['application_letter_file'];
    studentEvidenceFile = json['student_evidence_file'];
    educationalInstitution = json['educational_institution'];
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
    data['portfolio_file'] = this.portfolioFile;
    data['application_letter_file'] = this.applicationLetterFile;
    data['student_evidence_file'] = this.studentEvidenceFile;
    data['educational_institution'] = this.educationalInstitution;
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
  String? location;

  Company({this.id, this.name, this.location});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
