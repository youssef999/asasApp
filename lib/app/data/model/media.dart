class Media {
  int? id;
  String? media;
  String? id_;
  String? tableName;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? path;

  Media(
      {this.id,
        this.media,
        this.id_,
        this.tableName,
        this.createdAt,
        this.name,
        this.path,
        this.updatedAt});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    media = json['media'];
    id_ = json['id_'];
    tableName = json['table_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media'] = media;
    data['id_'] = id_;
    data['table_name'] = tableName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}