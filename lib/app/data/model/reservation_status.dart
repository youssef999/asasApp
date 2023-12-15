class ReservationStatus {
  int? id;
  String? statusEn;
  String? statusAr;
  String? createdAt;
  String? updatedAt;

  ReservationStatus(
      {this.id, this.statusEn, this.statusAr, this.createdAt, this.updatedAt});

  ReservationStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusEn = json['status_en'];
    statusAr = json['status_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status_en'] = statusEn;
    data['status_ar'] = statusAr;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}