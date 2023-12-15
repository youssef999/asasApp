import 'package:get/get.dart';

class BookingResponse {
  int? currentPage;
  List<Booking>? book;
  int? lastPage;
  int? perPage;
  int? total;

  BookingResponse(
      {this.currentPage, this.book, this.lastPage, this.perPage, this.total});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      book = <Booking>[];
      json['data'].forEach((v) {
        book!.add(Booking.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (book != null) {
      data['data'] = book!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total'] = total;
    return data;
  }
}

class Booking {
  int? childProgId;
  String? createdAt;
  String? childName;
  String? programNameAr;
  String? programNameEn;
  String? nameCompany;
  int? companyId;
  String? reservationStatusStatusAr;
  String? reservationStatusStatusEn;
  int? reservationStatusId;
  int? rateFatherCompaniesid;
  int? programPrice;
  String? descriptionProgramAr;
  String? descriptionProgramEn;
  var discount;
  int? rateCompany;
  Booking(
      {this.childProgId,
      this.createdAt,
      this.childName,
      this.programNameAr,
      this.programNameEn,
      this.nameCompany,
      this.reservationStatusStatusAr,
      this.reservationStatusStatusEn,
      this.reservationStatusId,
      this.rateFatherCompaniesid,
      this.companyId,
      this.programPrice,
      this.descriptionProgramAr,
      this.descriptionProgramEn,
      this.rateCompany,
      this.discount});

  Booking.fromJson(Map<String, dynamic> json) {
    childProgId = json['childProg_id'];
    createdAt = json['created_at'];
    childName = json['child_name'];
    programNameAr = json['program_name_ar'];
    programNameEn = json['program_name_en'];
    nameCompany = Get.locale.toString() == 'en_US'
        ? json['name_company']
        : json['name_company_ar'];
    descriptionProgramEn = Get.locale.toString() == 'en_US'
        ? json['program_description_en']
        : json['program_description_ar'];
    descriptionProgramAr = json['program_description_ar'];
    companyId = json['company_id'];
    rateFatherCompaniesid = json['rate_father_companiesid'];
    reservationStatusStatusAr = json['reservationStatus_status_ar'];
    reservationStatusStatusEn = json['reservationStatus_status_en'];
    reservationStatusId = json['reservationStatus_id'];
    programPrice = json["program_price"];
    discount = json['discount'];
    rateCompany = json["rate_father_companiesid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['childProg_id'] = childProgId;
    data['created_at'] = createdAt;
    data['child_name'] = childName;
    data['rate_father_companiesid'] = rateFatherCompaniesid;
    data['program_name_ar'] = programNameAr;
    data['program_name_en'] = programNameEn;
    data['name_company'] = nameCompany;
    data['company_id'] = companyId;
    data['reservationStatus_status_ar'] = reservationStatusStatusAr;
    data['reservationStatus_status_en'] = reservationStatusStatusEn;
    data['reservationStatus_id'] = reservationStatusId;
    data['program_price'] = programPrice;
    data['program_description_en'] = descriptionProgramEn;
    data['program_description_ar'] = descriptionProgramAr;
    data['discount'] = discount;
    data['rate_father_companiesid'] = rateCompany;
    return data;
  }
}
