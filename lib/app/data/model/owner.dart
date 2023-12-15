import 'package:get/get.dart';

class Owner {
  int? id;
  String? name;
  String? token;
  String? nameCorporation;
  String? nameCorporationAr;
  String? phone;
  String? password;
  String? createdAt;
  String? updatedAt;

  Owner(
      {this.id,
        this.name,
        this.nameCorporation,
        this.nameCorporationAr,
        this.phone,
        this.password,
        this.createdAt,
        this.updatedAt});

  Owner.fromJson(Map<String, dynamic> json) {

    if(json.containsKey("access_token")){
      token = json['access_token'];
    }

    if(json.containsKey("token")){
      token = json['token'];
    }

    if(json.containsKey('data') && json['data'] != null){
      json = json['data'];
    }

    id = json['id'];
    name = json['name'];

    nameCorporation = Get.locale.toString() == 'en_US' ? json['name_corporation'] : json['name_corporation'];
    nameCorporationAr = Get.locale.toString() == 'en_US' ? json['name_corporation_'] : json['name_corporation_ar'];
    phone = json['phone'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_corporation'] = nameCorporation;
    data['name_corporation_ar'] = nameCorporationAr;
    data['phone'] = phone;
    data['password'] = password;
    data['access_token'] = token;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}