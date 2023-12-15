class ImageModel {
  String? name;
  String? path;
  String? size;
  int? id; // Dummy

  ImageModel({this.name, this.size, this.path, this.id});

  ImageModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    data['size'] = size;
    return data;
  }
}