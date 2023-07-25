class ProfilCompanyModel {
  bool? success;
  String? message;
  Data? data;

  ProfilCompanyModel({this.success, this.message, this.data});

  ProfilCompanyModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? field;
  String? foundingDate;
  String? userType;
  String? location;
  String? description;
  int? employees;
  String? role;

  Data(
      {this.id,
        this.name,
        this.email,
        this.field,
        this.foundingDate,
        this.userType,
        this.location,
        this.description,
        this.employees,
        this.role});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    field = json['field'];
    foundingDate = json['founding_date'];
    userType = json['user_type'];
    location = json['location'];
    description = json['description'];
    employees = json['employees'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['field'] = this.field;
    data['founding_date'] = this.foundingDate;
    data['user_type'] = this.userType;
    data['location'] = this.location;
    data['description'] = this.description;
    data['employees'] = this.employees;
    data['role'] = this.role;
    return data;
  }
}
