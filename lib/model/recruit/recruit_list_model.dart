class RecruitListModel {
  bool? success;
  String? message;
  List<Data>? data;

  RecruitListModel({this.success, this.message, this.data});

  RecruitListModel.fromJson(Map<String, dynamic> json) {
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
  Worker? worker;
  Job? job;
  String? replyStatus;
  String? createdAt;

  Data({this.id, this.worker, this.job, this.replyStatus, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    worker =
    json['worker'] != null ? new Worker.fromJson(json['worker']) : null;
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    replyStatus = json['reply_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.worker != null) {
      data['worker'] = this.worker!.toJson();
    }
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    data['reply_status'] = this.replyStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Worker {
  int? id;
  String? username;
  String? profileImage;

  Worker({this.id, this.username, this.profileImage});

  Worker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['profile_image'] = this.profileImage;
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
