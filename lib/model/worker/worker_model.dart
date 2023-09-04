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
  String? profilImage;
  String? backdropImage;
  String? gender;
  String? phoneNumber;
  int? age;
  String? address;
  String? bornDate;
  String? interested;
  String? description;
  String? status;
  List<Experiences>? experiences;
  List<Educations>? educations;
  List<Skills>? skills;
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
        this.status,
        this.experiences,
        this.educations,
        this.skills,
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
    status = json['status'];
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(new Experiences.fromJson(v));
      });
    }
    if (json['educations'] != null) {
      educations = <Educations>[];
      json['educations'].forEach((v) {
        educations!.add(new Educations.fromJson(v));
      });
    }
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(new Skills.fromJson(v));
      });
    }
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
    data['status'] = this.status;
    if (this.experiences != null) {
      data['experiences'] = this.experiences!.map((v) => v.toJson()).toList();
    }
    if (this.educations != null) {
      data['educations'] = this.educations!.map((v) => v.toJson()).toList();
    }
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    data['company_visible'] = this.companyVisible;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Experiences {
  int? id;
  String? title;
  String? startAt;
  String? endAt;
  String? location;
  String? description;
  String? createdAt;

  Experiences(
      {this.id,
        this.title,
        this.startAt,
        this.endAt,
        this.location,
        this.description,
        this.createdAt});

  Experiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    location = json['location'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['location'] = this.location;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Educations {
  int? id;
  String? educationalInstitution;
  String? startAt;
  String? endAt;
  String? title;
  String? description;

  Educations(
      {this.id,
        this.educationalInstitution,
        this.startAt,
        this.endAt,
        this.title,
        this.description});

  Educations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    educationalInstitution = json['educational_institution'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['educational_institution'] = this.educationalInstitution;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class Skills {
  int? id;
  String? name;
  String? createdAt;

  Skills({this.id, this.name, this.createdAt});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    return data;
  }
}
