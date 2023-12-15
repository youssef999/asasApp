class ProgramType {
  int? id;
  String? programTypeEn;
  String? programTypeAr;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;

  ProgramType(
      {this.id,
        this.programTypeEn,
        this.programTypeAr,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  ProgramType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    programTypeEn = json['program_type_en'];
    programTypeAr = json['program_type_ar'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['program_type_en'] = programTypeEn;
    data['program_type_ar'] = programTypeAr;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}