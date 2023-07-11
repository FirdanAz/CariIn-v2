class AcceptedJobCompany {
  bool? success;
  String? message;
  List<Data>? data;

  AcceptedJobCompany({this.success, this.message, this.data});

  AcceptedJobCompany.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  int? salary;
  Company? company;
  bool? pklStatus;
  String? confirmedStatus;
  String? createdAt;

  Data(
      {this.id,
        this.title,
        this.description,
        this.salary,
        this.company,
        this.pklStatus,
        this.confirmedStatus,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    salary = json['salary'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    pklStatus = json['pkl_status'];
    confirmedStatus = json['confirmed_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['salary'] = this.salary;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['pkl_status'] = this.pklStatus;
    data['confirmed_status'] = this.confirmedStatus;
    data['created_at'] = this.createdAt;
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
