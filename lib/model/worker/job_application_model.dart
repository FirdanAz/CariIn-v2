class JobApplicationModel {
  bool? success;
  String? message;
  List<Data>? data;

  JobApplicationModel({this.success, this.message, this.data});

  JobApplicationModel.fromJson(Map<String, dynamic> json) {
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
  Job? job;
  Worker? worker;
  String? confirmedStatus;
  String? createdAt;

  Data({this.id, this.job, this.worker, this.confirmedStatus, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    worker =
    json['worker'] != null ? new Worker.fromJson(json['worker']) : null;
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
    data['confirmed_status'] = this.confirmedStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Job {
  int? id;
  String? title;

  Job({this.id, this.title});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Worker {
  int? id;
  String? username;

  Worker({this.id, this.username});

  Worker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}
