class ListExperienceModel {
  bool? success;
  String? message;
  List<Data>? data;

  ListExperienceModel({this.success, this.message, this.data});

  ListExperienceModel.fromJson(Map<String, dynamic> json) {
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
  String? startAt;
  String? endAt;
  String? location;
  String? description;
  String? createdAt;

  Data(
      {this.id,
        this.title,
        this.startAt,
        this.endAt,
        this.location,
        this.description,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    location = json['location'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['location'] = this.location;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
