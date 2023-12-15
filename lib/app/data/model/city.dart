class City {
  int? id;
  String? nameEn;
  String? nameAr;
  int? idCity;
  String? createdAt;
  String? updatedAt;

  City(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.idCity,
        this.createdAt,
        this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    idCity = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['city_id'] = idCity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}