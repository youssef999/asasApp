import 'package:get/get.dart';

class MainChat {
  int? id;
  String? idCompany;
  String? idFather;
  String? message;
  String? sender;
  int? isRead;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? logo;
  String? name;
  String? nameCorporation;

  MainChat(
      {this.id,
        this.idCompany,
        this.idFather,
        this.message,
        this.sender,
        this.isRead,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.logo,
        this.name,
        this.nameCorporation});

  MainChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCompany = json['id_company'];
    idFather = json['id_father'];
    message = json['message'];
    sender = json['sender'];
    isRead = json['is_read'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    logo = json['logo'];
    name = json['name'];
    nameCorporation = Get.locale.toString() == 'en_US' ? json['name_corporation'] : json['name_corporation_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_company'] = idCompany;
    data['id_father'] = idFather;
    data['message'] = message;
    data['sender'] = sender;
    data['is_read'] = isRead;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['logo'] = logo;
    data['name'] = name;
    data['name_corporation'] = nameCorporation;
    return data;
  }
}