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
  String? city;
  Company? company;
  bool? pklStatus;
  String? confirmedStatus;

  Data(
      {this.id,
        this.title,
        this.city,
        this.company,
        this.pklStatus,
        this.confirmedStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    city = json['city'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    pklStatus = json['pkl_status'];
    confirmedStatus = json['confirmed_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['city'] = this.city;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
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
