import 'package:asas/app/data/model/count_status.dart';
import 'package:get/get.dart';

class ReservationResponse {
  int? currentPage;
  List<Reservation>? reservation;
  CountStatus? countStatus;
  int? lastPage;
  int? perPage;
  int? total;

  ReservationResponse(
      {this.currentPage, this.reservation, this.lastPage, this.perPage, this.total});

  ReservationResponse.fromJson(Map<String, dynamic> json) {

    currentPage = json['data']['current_page'];

    if(json.containsKey('count_status')){
      countStatus = CountStatus.fromJson(json['count_status']);
    }

    if (json['data']['data'] != null) {
      reservation = <Reservation>[];
      json['data']['data'].forEach((v) {
        reservation!.add(Reservation.fromJson(v));
      });
    }
    lastPage = json['data']['last_page'];
    perPage = json['data']['per_page'];
    total = json['data']['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (reservation != null) {
      data['data'] = reservation!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total'] = total;
    return data;
  }
}


class Reservation {
  int? childProgId;
  String? createdAt;
  String? childName;
  String? programNameAr;
  String? programNameEn;
  String? nameCompany;
  String? reservationStatusStatusAr;
  String? reservationStatusStatusEn;
  int? reservationStatusId;

  Reservation(
      {this.childProgId,
        this.createdAt,
        this.childName,
        this.programNameAr,
        this.programNameEn,
        this.nameCompany,
        this.reservationStatusStatusAr,
        this.reservationStatusStatusEn,
      this.reservationStatusId});

  Reservation.fromJson(Map<String, dynamic> json) {
    childProgId = json['childProg_id'];
    createdAt = json['created_at'];
    childName = json['child_name'];
    programNameAr = json['program_name_ar'];
    programNameEn = json['program_name_en'];
    nameCompany = Get.locale.toString() == 'en_US' ? json['name_company'] : json['name_company_ar'];
    reservationStatusId = json['reservationStatus_id'];
    reservationStatusStatusAr = json['reservationStatus_status_ar'];
    reservationStatusStatusEn = json['reservationStatus_status_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['childProg_id'] = childProgId;
    data['created_at'] = createdAt;
    data['child_name'] = childName;
    data['program_name_ar'] = programNameAr;
    data['program_name_en'] = programNameEn;
    data['name_company'] = nameCompany;
    data['reservationStatus_status_ar'] = reservationStatusStatusAr;
    data['reservationStatus_status_en'] = reservationStatusStatusEn;
    data['reservationStatus_id'] = reservationStatusId;
    return data;
  }
}