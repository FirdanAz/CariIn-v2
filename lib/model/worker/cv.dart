class MyCvModel {
  bool? success;
  String? message;
  Data? data;

  MyCvModel({this.success, this.message, this.data});

  MyCvModel.fromJson(Map<String, dynamic> json) {
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
  String? cvFile;

  Data({this.id, this.cvFile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cvFile = json['cv_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cv_file'] = this.cvFile;
    return data;
  }
}
