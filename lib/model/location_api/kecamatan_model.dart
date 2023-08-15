class KecamatanModel {
  String? code;
  String? messages;
  List<Value>? value;

  KecamatanModel({this.code, this.messages, this.value});

  KecamatanModel.fromJson(Map<String, dynamic> json) {
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
  String? idKabupaten;
  String? name;

  Value({this.id, this.idKabupaten, this.name});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKabupaten = json['id_kabupaten'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_kabupaten'] = this.idKabupaten;
    data['name'] = this.name;
    return data;
  }
}
