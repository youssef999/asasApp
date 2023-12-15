import 'package:asas/app/data/model/reservation.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class OwnerBookingRequsetsController extends GetxController {

  List<Reservation> reservationList = [];
  ReservationResponse? reservationResponse;
  ScrollController reservationScrollController = ScrollController();
  int reservationTotalPages = 0;
  int reservationCurrentPage = 1;
  ApiCallStatus reservationStatus = ApiCallStatus.loading;


  gotToDetailsPage(childProgId) async{
    final result = await Get.toNamed(Routes.OWNER_BOOKING_DETAILS, arguments: [childProgId]);

    if(result != null && result){
      onRefresh();
    }
  }


  showCancelButton(int reservationStatusId){
    return reservationStatusId == ReservationStatus.underStudying ? true : false ;
  }

  // Reservation == Book == Booking
  getReservation(int page) async {
    if(page == 1){
      reservationStatus = ApiCallStatus.loading;
      update();
    }else{
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }


    ReservationResponse? data = await PortalRepository().getReservation();


    if(page != 1){
      CustomLoading.cancelLoading();
    }


    if(data != null){

      reservationStatus = ApiCallStatus.success;

      reservationResponse = data;

      if(page == 1){
        reservationList = data.reservation!;
      }else{
        if(data.reservation!.isNotEmpty){
          reservationList.addAll(data.reservation!);
          _animateToOffset(reservationScrollController.offset + (120 * 1));
        }
      }

      reservationTotalPages = data.lastPage!;
      reservationCurrentPage = data.currentPage!;

    }else if(data != null){
      reservationStatus = ApiCallStatus.empty;
    }else{
      reservationStatus = ApiCallStatus.failed;
    }
    update();
  }


  getReservationByStatusId(int page, int statusId) async {
    if(statusId < 0){
      getReservation(1);
      return;
    }
    if(page == 1){
      reservationStatus = ApiCallStatus.loading;
      update();
    }else{
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }


    ReservationResponse? data = await PortalRepository().getReservationByStatusId(statusId);


    if(page != 1){
      CustomLoading.cancelLoading();
    }


    if(data != null){

      reservationStatus = ApiCallStatus.success;

      data.countStatus = reservationResponse!.countStatus;

      reservationResponse = data;

      if(page == 1){
        reservationList = data.reservation!;
      }else{
        if(data.reservation!.isNotEmpty){
          reservationList.addAll(data.reservation!);
          _animateToOffset(reservationScrollController.offset + (120 * 1));
        }
      }

      reservationTotalPages = data.lastPage!;
      reservationCurrentPage = data.currentPage!;

    }else if(data!.reservation!.isEmpty){
      reservationStatus = ApiCallStatus.empty;
    }else{
      reservationStatus = ApiCallStatus.failed;
    }
    update();
  }

  void _animateToOffset(double offset) {
    reservationScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }



  getCompaniesNextPage(){
    if(reservationCurrentPage < reservationTotalPages){
      getReservation(reservationCurrentPage + 1);
    }
  }


  onRefresh() async {
    await getReservation(1);
  }


  deleteReservation(int index)async{
    DialogUtils.showConfirmDialog(
        Get.context!,
        title: Strings.cancellation_reservation.tr,
        body: Strings.Are_you_reservation.tr,
        textButton: Strings.Cancellation.tr,
        onConfirm: () async {
          Get.back();
          CustomLoading.showLoading();
          final result = await PortalRepository().updateReservationStatus(reservationList[index].childProgId! , ReservationStatus.canceled);
          CustomLoading.cancelLoading();

          if(result){
            onRefresh();
          }
        });
  }

  @override
  void onInit() {
    super.onInit();
    reservationScrollController.addListener(() {
      if (reservationScrollController.position.atEdge) {
        bool isTop = reservationScrollController.position.pixels == 0;
        if (!isTop) {
          getCompaniesNextPage();
        }
      }
    });

    onRefresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    reservationScrollController.dispose();
  }
}
