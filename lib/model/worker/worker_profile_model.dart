class ProfileWorkerModel {
  bool? success;
  String? message;
  Data? data;

  ProfileWorkerModel({this.success, this.message, this.data});

  ProfileWorkerModel.fromJson(Map<String, dynamic> json) {
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
  String? profileImage;

  Data({this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'] ?? 'null';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    return data;
  }
}
