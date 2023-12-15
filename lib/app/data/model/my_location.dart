class MyLocation {
  int? id; // Dummy
  String? name;
  String? latitude;
  String? longitude;
  bool? isSelected;


  MyLocation({this.name, this.isSelected, this.latitude,this.longitude, this.id});

  MyLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSelected = json['isSelected'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isSelected'] = isSelected;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}