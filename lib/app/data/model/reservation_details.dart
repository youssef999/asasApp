import 'package:asas/app/data/model/currency.dart';
import 'package:asas/app/data/model/discount.dart';
import 'package:asas/app/data/model/service.dart';
import 'package:get/get.dart';

class ReservationDetails {
  int? childProgId;
  String? createdAt;
  String? childName;
  String? fatherName2;
  String? dateOfBirth;
  String? gender;
  String? fatherName;
  String? phone;
  String? priceNoteEn;
  String? priceNoteAr;
  String? programNameAr;
  String? programNameEn;
  num? price;
  int? priceAfterAddingService;
  int? idProgram;
  String? nameCompany;
  String? reservationStatusStatusAr;
  String? reservationStatusStatusEn;
  int? reservationStatusId;
  List<Discount>? discount;
  List<Service>? moreService;
  Currency? coins;

  ReservationDetails(
      {this.childProgId,
        this.createdAt,
        this.childName,
        this.fatherName2,
        this.dateOfBirth,
        this.gender,
        this.fatherName,
        this.programNameAr,
        this.programNameEn,
        this.price,
        this.idProgram,
        this.nameCompany,
        this.reservationStatusStatusAr,
        this.reservationStatusStatusEn,
        this.reservationStatusId,
        this.priceAfterAddingService,
      this.discount,
      this.coins,
        this.phone,
        this.priceNoteAr,
        this.priceNoteEn,
      this.moreService});

  ReservationDetails.fromJson(Map<String, dynamic> json) {

    if(json.containsKey('discount')){
      discount = (json['discount'] as List).map((e) => Discount.fromJson(e)).toList();
    }

    if(json.containsKey('coins')){
      coins = Currency.fromJson(json['coins']);
    }

    if(json.containsKey('more_service')){
      moreService = (json['more_service'] as List).map((e) => Service.fromJson(e)).toList();
    }

    if(json.containsKey('data')){
      json = json['data'];
    }

    childProgId = json['childProg_id'];
    createdAt = json['created_at'];
    childName = json['child_name'];
    fatherName2 = json['father_name2'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    fatherName = json['father_name'];
    phone = json['phone'];
    priceNoteEn = json['price_note_en'];
    priceNoteAr = json['price_note_ar'];
    programNameAr = json['program_name_ar'];
    programNameEn = json['program_name_en'];
    price = json['price'];
    idProgram = json['id_program'];
    nameCompany = Get.locale.toString() == 'en_US' ? json['name_company'] : json['name_company_ar'];
    reservationStatusStatusAr = json['reservationStatus_status_ar'];
    reservationStatusStatusEn = json['reservationStatus_status_en'];
    reservationStatusId = json['reservationStatus_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['childProg_id'] = childProgId;
    data['created_at'] = createdAt;
    data['child_name'] = childName;
    data['father_name2'] = fatherName2;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['father_name'] = fatherName;
    data['phone'] = phone;
    data['price_note_en'] = priceNoteEn;
    data['price_note_ar'] = priceNoteAr;
    data['program_name_ar'] = programNameAr;
    data['program_name_en'] = programNameEn;
    data['price'] = price;
    data['id_program'] = idProgram;
    data['name_company'] = nameCompany;
    data['reservationStatus_status_ar'] = reservationStatusStatusAr;
    data['reservationStatus_status_en'] = reservationStatusStatusEn;
    data['reservationStatus_id'] = reservationStatusId;
    data['discount'] = discount;
    data['coins'] = coins;
    data['more_service'] = moreService;
    return data;
  }
}