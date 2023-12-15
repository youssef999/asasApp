import 'package:asas/app/data/model/company_type.dart';
import 'package:asas/app/data/model/currency.dart';
import 'package:asas/app/data/model/media.dart';
import 'package:asas/app/data/model/owner.dart';
import 'package:asas/app/data/model/rating.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CompanyResponse {
  int? currentPage;
  List<Company>? companies;
  int? lastPage;
  int? perPage;
  int? total;

  CompanyResponse(
      {this.currentPage,
      this.companies,
      this.lastPage,
      this.perPage,
      this.total});

  CompanyResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? json['pegn']['current_page'];

    if (json['data'] != null) {
      companies = <Company>[];
      json['data'].forEach((v) {
        companies!.add(Company.fromJson(v));
      });
    }
    lastPage = json['last_page'] ?? json['pegn']['last_page'];
    perPage = json['per_page'] ?? json['pegn']['per_page'];
    total = json['total'] ?? json['pegn']['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (companies != null) {
      data['data'] = companies!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total'] = total;
    return data;
  }
}

class Company {
  int? id;
  String? logo;
  String? desceptionEn;
  String? desceptionAr;
  String? lat;
  String? lng;
  String? idFacilityOwner;
  String? nameCorporation;
  int? isDeleted;
  String? idCoins;
  String? idCountry;
  num? rateTotal;
  String? idCity;
  String? idDistrict;
  String? idCompanyType;
  String? createdAt;
  String? updatedAt;
  num? distance;
  List<Media>? media;
  Owner? owner;
  Rating? rate;
  CompanyType? companyType;
  Currency? coins;
  bool? addToFav;
  int? favoriteId;

  Company(
      {this.id,
      this.logo,
      this.desceptionEn,
      this.desceptionAr,
      this.lat,
      this.lng,
      this.idFacilityOwner,
      this.nameCorporation,
      this.isDeleted,
      this.idCoins,
      this.idCountry,
      this.idCity,
      this.idDistrict,
      this.idCompanyType,
      this.createdAt,
      this.favoriteId,
      this.updatedAt,
      this.media,
      this.addToFav,
      this.owner,
      this.rateTotal,
      this.rate,
      this.coins,
      this.companyType,
      this.distance});

  Company.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('media')) {
      try {
        media = (json['media'] as List).map((e) => Media.fromJson(e)).toList();
      } catch (e) {
        Logger().e(e);
      }
    }

    if (json.containsKey('facility_owner')) {
      try {
        owner = Owner.fromJson(json['facility_owner'][0]);
      } catch (e) {
        // Logger().e(e);
        owner = Owner.fromJson(json['facility_owner']);
      }
    }

    if (json.containsKey('company_rate')) {
      try {
        rate = Rating.fromJson(json['company_rate'][0]);
      } catch (e) {
        Logger().e(e);
        rate = Rating.fromJson(json['company_rate']);
      }
    }

    if (json.containsKey('company_type')) {
      try {
        companyType = CompanyType.fromJson(json['company_type'][0]);
      } catch (e) {
        Logger().e(e);
        //companyType = CompanyType.fromJson(json['company_type']);
      }
    }

    if (json.containsKey('coins')) {
      try {
        coins = Currency.fromJson(json['coins'][0]);
      } catch (e) {
        try {
          coins = Currency.fromJson(json['coins']);
        } catch (_) {}
      }
    }

    if (json.containsKey('favoraite')) {
      try {
        favoriteId = json['favoraite'][0]['id'];
        // ignore: empty_catches
      } catch (e) {}
    }

    addToFav = json['addToFav'] ?? false;

    if (json.containsKey('data')) {
      try {
        json = json['data'][0];
      } catch (e) {
        ///Logger().e(e);
        json = json['data'];
      }
    }

    id = json['id'];
    logo = json['logo'];
    desceptionEn = json['desception_en'];
    desceptionAr = json['desception_ar'];
    try {
      rateTotal = json['rate_total'];
    } catch (_) {
      rateTotal = json['rate_total'][0]['rate_total'];
    }

    nameCorporation = Get.locale.toString() == 'en_US'
        ? json['name_corporation']
        : json['name_corporation_ar'];

    lat = (json['lat'] ?? json['latitude']).toString();
    lng = (json['lng'] ?? json['longitude']).toString();
    idFacilityOwner = json['id_facility_owner'];
    distance = json['distance'];
    isDeleted = json['is_deleted'];
    idCoins = json['id_coins'];
    idCountry = json['id_country'];
    idCity = json['id_city'];
    idDistrict = json['id_district'];
    idCompanyType = json['id_company_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo'] = logo;
    data['desception_en'] = desceptionEn;
    data['name_corporation'] = nameCorporation;
    data['rate_total'] = rateTotal;
    data['desception_ar'] = desceptionAr;
    data['lat'] = lat;
    data['lng'] = lng;
    data['id_facility_owner'] = idFacilityOwner;
    data['is_deleted'] = isDeleted;
    data['id_coins'] = idCoins;
    data['id_country'] = idCountry;
    data['id_city'] = idCity;
    data['id_district'] = idDistrict;
    data['id_company_type'] = idCompanyType;
    data['created_at'] = createdAt;
    data['distance'] = distance;
    data['updated_at'] = updatedAt;
    return data;
  }
}
