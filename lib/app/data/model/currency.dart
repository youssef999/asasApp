class Currency {
  int? id;
  num? dollar;
  String? coinsNameEn;
  String? coinsNameAr;
  String? createdAt;
  String? updatedAt;

  Currency(
      {this.id,
        this.coinsNameEn,
        this.coinsNameAr,
        this.dollar,
        this.createdAt,
        this.updatedAt});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dollar = json['dollar'];
    coinsNameEn = json['coins_name_en'];
    coinsNameAr = json['coins_name_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dollar'] = dollar;
    data['coins_name_en'] = coinsNameEn;
    data['coins_name_ar'] = coinsNameAr;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}