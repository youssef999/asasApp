class Country {
  int? id;
  String? nameEn;
  String? nameAr;
  String? type;
  String? idCountry;
  String? createdAt;
  String? updatedAt;

  Country(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.type,
        this.idCountry,
        this.createdAt,
        this.updatedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    type = json['type'];
    idCountry = json['id_country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['type'] = type;
    data['id_country'] = idCountry;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}