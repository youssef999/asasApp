import 'package:asas/app/data/model/my_notification.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class NotificationController extends GetxController {


  List<MyNotification> notificationList = [];
  ScrollController notificationScrollController = ScrollController();
  int notificationTotalPages = 0;
  int notificationCurrentPage = 1;
  ApiCallStatus notificationStatus = ApiCallStatus.loading;



  getNotifications(int page) async {
    if(page == 1){
      notificationStatus = ApiCallStatus.loading;
      update();
    }else{
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }


    NotificationResponse? data = await UserRepository().getNotification(page);

    if(page != 1){
      CustomLoading.cancelLoading();
    }


    if(data != null && data.notifications!.isNotEmpty){
      notificationStatus = ApiCallStatus.success;

      if(page == 1){
        notificationList = data.notifications!;
      }else{
        if(data.notifications!.isNotEmpty){
          notificationList.addAll(data.notifications!);
          _animateToOffset(notificationScrollController.offset + (75 * 2));
        }
      }

      notificationTotalPages = data.lastPage!;
      notificationCurrentPage = data.currentPage!;

    }else if(data != null && data.notifications!.isEmpty){
      notificationStatus = ApiCallStatus.empty;
    }else{
      notificationStatus = ApiCallStatus.failed;
    }
    update();
  }

  void _animateToOffset(double offset) {
    notificationScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }



  getCompaniesNextPage(){
    if(notificationCurrentPage < notificationTotalPages){
      getNotifications(notificationCurrentPage + 1);
    }
  }


  @override
  void onInit() {

    getNotifications(1);

    notificationScrollController.addListener(() {
      if (notificationScrollController.position.atEdge) {
        bool isTop = notificationScrollController.position.pixels == 0;
        if (!isTop) {
          getCompaniesNextPage();
        }
      }
    });

    super.onInit();
  }


  @override
  void onClose() {
    notificationScrollController.dispose();
    super.onClose();
  }
}
