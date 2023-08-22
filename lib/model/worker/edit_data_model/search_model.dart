class WorkerSearchModel {
  bool? success;
  String? message;
  Data? data;

  WorkerSearchModel({this.success, this.message, this.data});

  WorkerSearchModel.fromJson(Map<String, dynamic> json) {
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
  String? query;
  List<Job>? job;

  Data({this.query, this.job});

  Data.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    if (json['job'] != null) {
      job = <Job>[];
      json['job'].forEach((v) {
        job!.add(new Job.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    if (this.job != null) {
      data['job'] = this.job!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Job {
  int? id;
  String? title;
  String? coverImage;
  String? description;
  int? salary;
  List<Tags>? tags;
  Company? company;
  bool? pklStatus;
  String? confirmedStatus;
  String? createdAt;

  Job(
      {this.id,
        this.title,
        this.coverImage,
        this.description,
        this.salary,
        this.tags,
        this.company,
        this.pklStatus,
        this.confirmedStatus,
        this.createdAt});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    coverImage = json['cover_image'];
    description = json['description'];
    salary = json['salary'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
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
    data['cover_image'] = this.coverImage;
    data['description'] = this.description;
    data['salary'] = this.salary;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['pkl_status'] = this.pklStatus;
    data['confirmed_status'] = this.confirmedStatus;
    data['created_at'] = this.createdAt;
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
