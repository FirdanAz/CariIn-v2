class ListInboxModel {
  bool? success;
  String? message;
  List<Data>? data;

  ListInboxModel({this.success, this.message, this.data});

  ListInboxModel.fromJson(Map<String, dynamic> json) {
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
  String? subject;
  String? message;
  String? sentDate;
  bool? read;
  String? type;
  String? redirectId;

  Data(
      {this.id,
        this.subject,
        this.message,
        this.sentDate,
        this.read,
        this.type,
        this.redirectId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    message = json['message'];
    sentDate = json['sent_date'];
    read = json['read'];
    type = json['type'];
    redirectId = json['redirect_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['sent_date'] = this.sentDate;
    data['read'] = this.read;
    data['type'] = this.type;
    data['redirect_id'] = this.redirectId;
    return data;
  }
}
