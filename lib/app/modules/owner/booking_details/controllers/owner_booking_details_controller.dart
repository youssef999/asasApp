import 'package:asas/app/data/model/reservation_details.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:get/get.dart';

import '../../../../helpers/bottom_sheet.dart';
import '../../../../translations/strings_enum.dart';

class OwnerBookingDetailsController extends GetxController {


  late int childrenProgramId;
  ReservationDetails? reservationDetails;
  ApiCallStatus reservationDetailsStatus = ApiCallStatus.loading;


  getDiscount(){
    if(reservationDetailsStatus != ApiCallStatus.success){
      return;
    }
    if(reservationDetails!.discount!.isNotEmpty){
      return reservationDetails!.discount![0].priceRateDiscount! + "%";
    }
    return "${Strings.there_is_no_discount.tr}";
  }

  getPriceAfterDiscount(){
    if(reservationDetailsStatus != ApiCallStatus.success){
      return;
    }
    if(reservationDetails!.discount!.isNotEmpty){
      return (reservationDetails!.price! - (reservationDetails!.price! * (int.parse(reservationDetails!.discount![0].priceRateDiscount!) / 100))).toString();
    }else{
      return reservationDetails!.price!.toString();
    }
  }

  getPriceAfterAddServices(){
    if(reservationDetailsStatus != ApiCallStatus.success){
      return;
    }

    if(reservationDetails!.moreService!.isEmpty){
      return null ;
    }else{
      int amount = 0;
      for(var item in reservationDetails!.moreService!){
        amount+= int.parse(item.price ?? '0');
      }
      return amount.toString();
    }
  }

  getReservationDetails(int childrenProgramId) async{
    CustomLoading.showLoading();
    final result = await PortalRepository().getReservationDetails(childrenProgramId);
    CustomLoading.cancelLoading();
    if(result != null){
      reservationDetailsStatus = ApiCallStatus.success;
      reservationDetails = result;
    }else{
      reservationDetailsStatus = ApiCallStatus.failed;
    }
    update();
    updateTotalPrice();
  }

  _addAction(int reservationStatusesId) async {
    CustomLoading.showLoading();
    final result = await PortalRepository().updateReservationStatus(childrenProgramId, reservationStatusesId);
    CustomLoading.cancelLoading();

    if(result){
      Get.back();
      Get.back(result: true);
    }
  }

  addAction() async {
    CustomLoading.showLoading();
    final statusList = await PortalRepository().getReservationStatus();
    CustomLoading.cancelLoading();
    if(statusList == null ){
      return;
    }
    BottomSheetUtils.showAddActionBottomSheet(
      Get.context!,
      statusList,
      (actionId){
        _addAction(actionId!);
      }
    );

  }


  double priceAfterDiscount(){
    if(reservationDetails!.discount!.isNotEmpty) {
      return (reservationDetails!.price! - (reservationDetails!.price! * (int.parse(reservationDetails!.discount![0].priceRateDiscount!) / 100)));
    } else {
      return reservationDetails!.price!.toDouble();
    }
  }

  updateTotalPrice(){
    if(reservationDetails == null){
      return;
    }
    int amount = 0;
    reservationDetails!.moreService!.map((e) {
      if(e.selected){
        amount+=int.parse(e.price!);
      }
    }).toList();
    reservationDetails!.priceAfterAddingService = (priceAfterDiscount() + amount).toInt();
    update(['priceAfter']);
  }

  showAddAction(){
    if(
      reservationDetails!.reservationStatusId == ReservationStatus.acceptable ||
      reservationDetails!.reservationStatusId == ReservationStatus.canceled ||
      reservationDetails!.reservationStatusId == ReservationStatus.rejected
    ){
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    childrenProgramId = Get.arguments[0];
    getReservationDetails(childrenProgramId);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
