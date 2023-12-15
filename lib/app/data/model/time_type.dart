class TimeType {
  int? id;
  String? timeTypeEn;
  String? timeTypeAr;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;

  TimeType(
      {this.id,
        this.timeTypeEn,
        this.timeTypeAr,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  TimeType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeTypeEn = json['time_type_en'];
    timeTypeAr = json['time_type_ar'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time_type_en'] = timeTypeEn;
    data['time_type_ar'] = timeTypeAr;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}