class KabupatenModel {
  String? code;
  String? messages;
  List<Value>? value;

  KabupatenModel({this.code, this.messages, this.value});

  KabupatenModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    messages = json['messages'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(new Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['messages'] = this.messages;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String? id;
  String? idProvinsi;
  String? name;

  Value({this.id, this.idProvinsi, this.name});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProvinsi = json['id_provinsi'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_provinsi'] = this.idProvinsi;
    data['name'] = this.name;
    return data;
  }
}
