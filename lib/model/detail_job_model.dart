class JobDetailModel {
  bool? success;
  String? message;
  Data? data;

  JobDetailModel({this.success, this.message, this.data});

  JobDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? coverImage;
  String? backdropImage;
  String? gender;
  String? companyName;
  String? companyLocation;
  String? jobCreated;
  String? timeType;
  int? salary;
  Description? description;
  Company? company;
  Location? location;
  bool? pklStatus;
  String? confirmedStatus;

  Data(
      {this.id,
        this.title,
        this.coverImage,
        this.backdropImage,
        this.gender,
        this.companyName,
        this.companyLocation,
        this.jobCreated,
        this.timeType,
        this.salary,
        this.description,
        this.company,
        this.location,
        this.pklStatus,
        this.confirmedStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    coverImage = json['cover_image'];
    backdropImage = json['backdrop_image'];
    gender = json['gender'];
    companyName = json['company_name'];
    companyLocation = json['company_location'];
    jobCreated = json['job_created'];
    timeType = json['time_type'];
    salary = json['salary'];
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    pklStatus = json['pkl_status'];
    confirmedStatus = json['confirmed_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover_image'] = this.coverImage;
    data['backdrop_image'] = this.backdropImage;
    data['gender'] = this.gender;
    data['company_name'] = this.companyName;
    data['company_location'] = this.companyLocation;
    data['job_created'] = this.jobCreated;
    data['time_type'] = this.timeType;
    data['salary'] = this.salary;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['pkl_status'] = this.pklStatus;
    data['confirmed_status'] = this.confirmedStatus;
    return data;
  }
}

class Description {
  String? description;
  String? timeType;
  String? title;
  int? salary;
  String? education;
  int? minimumAge;
  int? maximumAge;
  List<Tags>? tags;

  Description(
      {this.description,
        this.timeType,
        this.title,
        this.salary,
        this.education,
        this.minimumAge,
        this.maximumAge,
        this.tags});

  Description.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    timeType = json['time_type'];
    title = json['title'];
    salary = json['salary'];
    education = json['education'];
    minimumAge = json['minimum_age'];
    maximumAge = json['maximum_age'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['time_type'] = this.timeType;
    data['title'] = this.title;
    data['salary'] = this.salary;
    data['education'] = this.education;
    data['minimum_age'] = this.minimumAge;
    data['maximum_age'] = this.maximumAge;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  int? id;
  String? name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Company {
  int? id;
  Null? url;
  String? location;
  String? foundingDate;
  int? employees;

  Company(
      {this.id, this.url, this.location, this.foundingDate, this.employees});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    location = json['location'];
    foundingDate = json['founding_date'];
    employees = json['employees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['location'] = this.location;
    data['founding_date'] = this.foundingDate;
    data['employees'] = this.employees;
    return data;
  }
}

class Location {
  String? location;

  Location({this.location});

  Location.fromJson(Map<String, dynamic> json) {
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    return data;
  }
}
