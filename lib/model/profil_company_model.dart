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
  String? profileImage;
  String? field;
  String? foundingDate;
  String? userType;
  String? location;
  String? description;
  String? outsideImage;
  String? insideImage;
  String? url;
  int? employees;
  String? confirmedStatus;
  String? role;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.profileImage,
        this.field,
        this.foundingDate,
        this.userType,
        this.location,
        this.description,
        this.outsideImage,
        this.insideImage,
        this.url,
        this.employees,
        this.confirmedStatus,
        this.role,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    field = json['field'];
    foundingDate = json['founding_date'];
    userType = json['user_type'];
    location = json['location'];
    description = json['description'];
    outsideImage = json['outside_image'];
    insideImage = json['inside_image'];
    url = json['url'];
    employees = json['employees'];
    confirmedStatus = json['confirmed_status'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['field'] = this.field;
    data['founding_date'] = this.foundingDate;
    data['user_type'] = this.userType;
    data['location'] = this.location;
    data['description'] = this.description;
    data['outside_image'] = this.outsideImage;
    data['inside_image'] = this.insideImage;
    data['url'] = this.url;
    data['employees'] = this.employees;
    data['confirmed_status'] = this.confirmedStatus;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
