import 'package:asas/app/data/model/currency.dart';
import 'package:asas/app/data/model/curriculum_type.dart';
import 'package:asas/app/data/model/discount.dart';
import 'package:asas/app/data/model/media.dart';
import 'package:asas/app/data/model/service.dart';
import 'package:asas/app/modules/user/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../modules/owner/home/controllers/owner_home_controller.dart';

class ProgramResponse {
  int? currentPage;
  List<Program>? programs;
  int? lastPage;
  int? perPage;
  int? total;

  ProgramResponse(
      {this.currentPage,
      this.programs,
      this.lastPage,
      this.perPage,
      this.total});

  ProgramResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      programs = <Program>[];
      json['data'].forEach((v) {
        programs!.add(Program.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (programs != null) {
      data['data'] = programs!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total'] = total;
    return data;
  }
}

class Program {
  int? id;
  int? idFacilityOwner;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  String? idTimeType;
  String? idTypeProgram;
  double? priceMain;
  int? priceAfterAddingService;
  String? ageConditionsEn;
  String? ageConditionsAr;
  String? idCurriculumType;
  String? otherConditionsEn;
  String? otherConditionsAr;
  String? urlViedo;
  String? priceNoteEn;
  String? priceNoteAr;
  String? image;
  String? otherFute;
  String? sort;
  String? createdAt;
  String? updatedAt;
  String? name_corporation;
  String? price_rate_discount;
  CurriculumType? curriculum_type;
  String? country;
  String? city;
  String? coins;
  num? dollar;
  String? coins_name_en;
  String? coins_name_ar;
  List<Media>? media;
  List<Service>? service;
  List<Discount>? discount;

  Program(
      {this.id,
      this.coins_name_ar,
      this.coins_name_en,
      this.idFacilityOwner,
      this.nameEn,
      this.nameAr,
      this.sort,
      this.descriptionEn,
      this.descriptionAr,
      this.idTimeType,
      this.idTypeProgram,
      this.priceMain,
      this.ageConditionsEn,
      this.ageConditionsAr,
      this.otherConditionsEn,
      this.dollar,
      this.otherConditionsAr,
      this.image,
      this.priceAfterAddingService,
      this.otherFute,
      this.createdAt,
      this.updatedAt,
      this.idCurriculumType,
      this.priceNoteAr,
      this.priceNoteEn,
      this.price_rate_discount,
      this.name_corporation,
      this.curriculum_type,
      this.country,
      this.city,
      this.coins,
      this.urlViedo});

  double getPrice() {
    try {
      Currency? userCurrency;
      if (Get.isRegistered<HomeController>()) {
        userCurrency = Get.find<HomeController>().userCurrency;
      } else {
        userCurrency = Get.find<OwnerHomeController>().userCurrency;
      }

      if (userCurrency == null) {
        return priceMain!.toDouble() * dollar!;
      }

      try {
        List<Currency> currencyList;

        if (Get.isRegistered<HomeController>()) {
          currencyList = Get.find<HomeController>().currencyList;
        } else {
          currencyList = Get.find<OwnerHomeController>().currencyList;
        }

        Currency? compCurrency;

        if (coins != null) {
          try {
            compCurrency = currencyList
                .firstWhere((element) => element.coinsNameEn == coins);
          } catch (_) {
            compCurrency = currencyList
                .firstWhere((element) => element.coinsNameAr == coins);
          }
        } else if (coins_name_en == null) {
          // lang is en
          compCurrency = currencyList
              .firstWhere((element) => element.coinsNameEn == coins_name_ar);
        } else {
          // lang is ar
          compCurrency = currencyList
              .firstWhere((element) => element.coinsNameAr == coins_name_ar);
        }

        if (userCurrency.id == compCurrency.id) {
          return priceMain!.toDouble() * dollar!;
        } else {
          //return (priceMain! * compCurrency.dollar!.toDouble()) / userCurrency.dollar!;
          return (priceMain!) / userCurrency.dollar!;
        }
      } catch (e) {
        Logger().e(e.toString());
        return priceMain!.toDouble();
      }
    } catch (e, s) {
      Logger().e(e.toString());
      Logger().e(s.toString());
      return 0;
    }
  }

  getCoinsNameAr() {
    Currency? userCurrency;
    if (Get.isRegistered<HomeController>()) {
      userCurrency = Get.find<HomeController>().userCurrency;
    } else {
      userCurrency = Get.find<OwnerHomeController>().userCurrency;
    }

    if (userCurrency == null) {
      return coins_name_ar;
    }
    return userCurrency.coinsNameAr;
  }

  Program.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('media')) {
      media = (json['media'] as List).map((e) => Media.fromJson(e)).toList();
      service = (json['service_more'] as List)
          .map((e) => Service.fromJson(e))
          .toList();
      discount =
          (json['discount'] as List).map((e) => Discount.fromJson(e)).toList();
      try {
        name_corporation = Get.locale.toString() == 'en_US'
            ? json['name_corporation']['name_corporation']
            : json['name_corporation']['name_corporation_ar'];
      } catch (_) {
        name_corporation = json['name_corporation']['name_corporation'];
      }
      curriculum_type = CurriculumType.fromJson(json['curriculum_type']);
      if (json['country_companyData'] != null) {
        country = json['country_companyData']['name_ar'];
        city = json['city_companyData']['name_ar'];
        coins = json['coins_companyData']['coins_name_ar'];
        dollar = json['coins_companyData']['dollar'];
      }

      json = json['data'];
    } else {
      media = [];
      service = [];
      discount = [];
      dollar = json['dollar'];
    }

    id = json['id'];
    sort = json['sort'];
    idFacilityOwner = int.parse(json['id_facility_owner'].toString());
    idCurriculumType = json['id_curriculum_type'].toString();
    priceNoteAr = json['price_note_ar'];
    priceNoteEn = json['price_note_en'];
    urlViedo = json['url_viedo'];

    try {
      if (json['dollar'] != null) {
        dollar = json['dollar'];
      }
    } catch (_) {}

    coins_name_en = json['coins_name_en'];
    coins_name_ar = json['coins_name_ar'];

    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    price_rate_discount = json['price_rate_discount'] != null
        ? json['price_rate_discount'].toString()
        : null;
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    idTimeType = json['id_timeType'];
    idTypeProgram = json['id_typeProgram'];
    priceMain = double.parse(json['price_main'].toString());
    priceAfterAddingService = 0;
    ageConditionsEn = json['age_conditions_en'];
    ageConditionsAr = json['age_conditions_ar'];
    otherConditionsEn = json['other_conditions_en'];
    otherConditionsAr = json['other_conditions_ar'];
    image = json['image'];
    otherFute = json['other_fute'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_facility_owner'] = idFacilityOwner;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['description_en'] = descriptionEn;
    data['description_ar'] = descriptionAr;
    data['id_timeType'] = idTimeType;
    data['id_typeProgram'] = idTypeProgram;
    data['price_main'] = priceMain;
    data['age_conditions_en'] = ageConditionsEn;
    data['age_conditions_ar'] = ageConditionsAr;
    data['other_conditions_en'] = otherConditionsEn;
    data['other_conditions_ar'] = otherConditionsAr;
    data['image'] = image;
    data['other_fute'] = otherFute;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sort'] = sort;
    data['id_curriculum_type'] = idCurriculumType;
    data['price_note_ar'] = priceNoteAr;
    data['price_note_en'] = priceNoteEn;
    data['url_viedo'] = urlViedo;
    return data;
  }
}
