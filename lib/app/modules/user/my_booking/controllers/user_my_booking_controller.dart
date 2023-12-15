import 'package:asas/app/data/model/booking.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/bottom_sheet.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class UserMyBookingController extends GetxController {


  List<Booking> bookList = [];
  ScrollController bookScrollController = ScrollController();
  int bookTotalPages = 0;
  int bookCurrentPage = 1;
  ApiCallStatus bookStatus = ApiCallStatus.loading;


  getMyBooking(int page) async {
    if(page == 1){
      bookStatus = ApiCallStatus.loading;
      update();
    }else{
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }


    BookingResponse? data = await UserRepository().getMyBooking(page);


    if(page != 1){
      CustomLoading.cancelLoading();
    }


    if(data != null && data.book!.isNotEmpty){
      bookStatus = ApiCallStatus.success;

      if(page == 1){
        bookList = data.book!;
      }else{
        if(data.book!.isNotEmpty){
          bookList.addAll(data.book!);
          _animateToOffset(bookScrollController.offset + (120 * 1));
        }
      }

      bookTotalPages = data.lastPage!;
      bookCurrentPage = data.currentPage!;

    }else if(data != null && data.book!.isEmpty){
      bookStatus = ApiCallStatus.empty;
    }else{
      bookStatus = ApiCallStatus.failed;
    }
    update();
  }

  void _animateToOffset(double offset) {
    bookScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }



  getCompaniesNextPage(){
    if(bookCurrentPage < bookTotalPages){
      getMyBooking(bookCurrentPage + 1);
    }
  }


  onRefresh() async {
    await getMyBooking(1);
  }

  deleteBooking(int index)async{
    DialogUtils.showConfirmDialog(
        Get.context!,
        title: Strings.cancellation_reservation.tr,
        body: Strings.Are_you_reservation.tr,
        onConfirm: () async {
          Get.back();
          CustomLoading.showLoading();
          final result = await UserRepository().deleteBooking(bookList[index].childProgId!);
          CustomLoading.cancelLoading();
          if(result){
            bookList.removeAt(index);
            update();
          }
        });
  }

  rateBooking(int companyId) async{
    BottomSheetUtils.showRattingBottomSheet(Get.context!, (r_1, r_2, r_3, r_4, r_5) async {
      if(r_1 == null || r_2 == null || r_3 == null || r_4 == null || r_5 == null ){
        CustomLoading.showWrongToast(msg: Strings.All_values_must_be_set.tr);
        return;
      }

      CustomLoading.showLoading();
      final result = await UserRepository().addRate(companyId, r_1, r_2, r_3, r_4, r_5);
      CustomLoading.cancelLoading();
      if(result){
        onRefresh();
        Get.back();
      }
    });
  }

  showCancelButton(int reservationStatusId){
    return reservationStatusId == ReservationStatus.underStudying ;
  }

  showRateButton(int reservationStatusId, int index){
    return reservationStatusId == ReservationStatus.acceptable  && bookList[index].rateFatherCompaniesid == null;
  }

  @override
  void onInit() {
    bookScrollController.addListener(() {
      if (bookScrollController.position.atEdge) {
        bool isTop = bookScrollController.position.pixels == 0;
        if (!isTop) {
          getCompaniesNextPage();
        }
      }
    });

    onRefresh();
    super.onInit();
  }

  @override
  void onClose() {
    bookScrollController.dispose();
  }
}
