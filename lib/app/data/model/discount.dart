
class Discount {
  int? id;
  String? idProgram;
  String? priceRateDiscount;
  String? startDiscount;
  String? endDiscount;
  String? createdAt;
  String? updatedAt;

  Discount(
      {this.id,
        this.idProgram,
        this.priceRateDiscount,
        this.startDiscount,
        this.endDiscount,
        this.createdAt,
        this.updatedAt});

  Discount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProgram = json['id_program'];
    priceRateDiscount = json['price_rate_discount'].toString();
    startDiscount = json['start_discount'];
    endDiscount = json['end_discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_program'] = idProgram;
    data['price_rate_discount'] = priceRateDiscount;
    data['start_discount'] = startDiscount;
    data['end_discount'] = endDiscount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}