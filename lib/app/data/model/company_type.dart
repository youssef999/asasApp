class CompanyType {
  int? id;
  String? typeNameEn;
  String? typeNameAr;
  String? icon;
  String? sort;
  String? createdAt;
  String? updatedAt;

  CompanyType(
      {this.id,
        this.typeNameEn,
        this.typeNameAr,
        this.icon,
        this.sort,
        this.createdAt,
        this.updatedAt});

  CompanyType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeNameEn = json['type_name_en'];
    typeNameAr = json['type_name_ar'];
    icon = json['icon'];
    sort = json['sort'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_name_en'] = typeNameEn;
    data['type_name_ar'] = typeNameAr;
    data['icon'] = icon;
    data['sort'] = sort;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}