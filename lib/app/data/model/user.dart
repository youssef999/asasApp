
class User {
  int? id;
  int? id_coins;
  String? name;
  String? accessToken;
  String? phone;
  String? email;
  String? idCountry;
  String? idCity;
  String? password;
  String? facebookId;
  String? googleId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.idCountry,
        this.idCity,
        this.password,
        this.facebookId,
        this.googleId,
        this.accessToken,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {

    if(json.containsKey("access_token")){
      accessToken = json['access_token'];
    }

    if(json.containsKey('data') && json['data'] != null){
      json = json['data'];
    }


    id = json['id'];
    id_coins = json['id_coins'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    try{
      idCountry = json['id_country'];
    }catch(_){
      idCountry = json['id_country'].toString();
    }
    try{
      idCity = json['id_city'];
    }catch(_){
      idCity = json['id_city'].toString();
    }
    password = json['password'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['id_country'] = idCountry;
    data['id_city'] = idCity;
    data['password'] = password;
    data['facebook_id'] = facebookId;
    data['google_id'] = googleId;
    data['access_token'] = accessToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}