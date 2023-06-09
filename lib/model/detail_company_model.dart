class DetailCompanyModel {
  bool? success;
  String? message;
  Data? data;

  DetailCompanyModel({this.success, this.message, this.data});

  DetailCompanyModel.fromJson(Map<String, dynamic> json) {
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
  int? title;
  String? city;
  String? timeType;
  int? salary;
  Company? company;
  String? gender;
  String? education;
  int? minimumAge;
  int? maximumAge;
  String? description;
  bool? pklStatus;
  String? confirmedStatus;

  Data(
      {this.id,
        this.title,
        this.city,
        this.timeType,
        this.salary,
        this.company,
        this.gender,
        this.education,
        this.minimumAge,
        this.maximumAge,
        this.description,
        this.pklStatus,
        this.confirmedStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    city = json['city'];
    timeType = json['time_type'];
    salary = json['salary'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    gender = json['gender'];
    education = json['education'];
    minimumAge = json['minimum_age'];
    maximumAge = json['maximum_age'];
    description = json['description'];
    pklStatus = json['pkl_status'];
    confirmedStatus = json['confirmed_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['city'] = this.city;
    data['time_type'] = this.timeType;
    data['salary'] = this.salary;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['gender'] = this.gender;
    data['education'] = this.education;
    data['minimum_age'] = this.minimumAge;
    data['maximum_age'] = this.maximumAge;
    data['description'] = this.description;
    data['pkl_status'] = this.pklStatus;
    data['confirmed_status'] = this.confirmedStatus;
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
