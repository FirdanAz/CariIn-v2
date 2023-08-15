class KelurahanModel {
  String? code;
  String? messages;
  List<Value>? value;

  KelurahanModel({this.code, this.messages, this.value});

  KelurahanModel.fromJson(Map<String, dynamic> json) {
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
  String? idKecamatan;
  String? name;

  Value({this.id, this.idKecamatan, this.name});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKecamatan = json['id_kecamatan'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_kecamatan'] = this.idKecamatan;
    data['name'] = this.name;
    return data;
  }
}
