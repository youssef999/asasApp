import 'package:get/get.dart';

class Agreement {
  int? id;
  String? idAgreement;
  String? idFacility;
  String? endDate;
  String? status;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? nameAr;
  String? nameEn;
  String? shortDescriptionEn;
  String? shortDescriptionAr;
  String? descriptionEn;
  String? descriptionAr;
  int? agId;
  String? nameCorporation;

  Agreement(
      {this.id,
        this.idAgreement,
        this.idFacility,
        this.endDate,
        this.status,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.nameAr,
        this.nameEn,
        this.shortDescriptionEn,
        this.shortDescriptionAr,
        this.descriptionEn,
        this.descriptionAr,
        this.agId,
        this.nameCorporation});

  Agreement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idAgreement = json['id_agreement'];
    idFacility = json['id_facility'];
    endDate = json['end_date'];
    status = json['status'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    shortDescriptionEn = json['short_description_en'];
    shortDescriptionAr = json['short_description_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    agId = json['ag_id'];
    nameCorporation = Get.locale.toString() == 'en_US' ? json['name_corporation'] : json['name_corporation_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_agreement'] = idAgreement;
    data['id_facility'] = idFacility;
    data['end_date'] = endDate;
    data['status'] = status;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['short_description_en'] = shortDescriptionEn;
    data['short_description_ar'] = shortDescriptionAr;
    data['description_en'] = descriptionEn;
    data['description_ar'] = descriptionAr;
    data['ag_id'] = agId;
    data['name_corporation'] = nameCorporation;
    return data;
  }
}