import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/currency.dart';
import '../../../../data/repository/auth_repository.dart';
import '../../../../data/repository/portal_repository.dart';
import '../../../../helpers/custom_loading.dart';

class OwnerHomeController extends GetxController {
  final xOffset = 0.0.obs;
  final yOffset = 0.0.obs;
  final scaleFactor = 1.0.obs;
  final verticalMargin = 0.0.obs;
  final isDrawerOpen = false.obs;

  Currency? userCurrency;

  getCoinsType() async {
    CustomLoading.showLoading();
    final userId = PreferenceUtils.getUserData()?.id;

    if(userId != null) {
      final result = await AuthRepository().getCoinsType(userId, "father");
      if (result != null) {
        userCurrency = result;
      }
    }

    CustomLoading.cancelLoading();
  }

  List<Currency> currencyList = [];

  getCurrency() async {
    CustomLoading.showLoading();
    final result = await PortalRepository().getCurrency();
    CustomLoading.cancelLoading();
    if(result != null){
      currencyList = result;
      await getCoinsType();
    }
  }
  onRefresh() async {
    await getCurrency();
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  @override
  void onClose() {}


  void openDrawer() {
    xOffset.value = PreferenceUtils.getCurrentLocale() == const Locale('en', 'US')
        ? Get.size.width * 0.70
        : -Get.size.width * 0.58;
    yOffset.value = 0;
    verticalMargin.value = 40;
    scaleFactor.value = 1;
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    if (isDrawerOpen.value) {
      xOffset.value = 0;
      yOffset.value = 0;
      verticalMargin.value = 0;
      scaleFactor.value = 1;
      isDrawerOpen.value = false;
    }
  }

  void toggleDrawer() {
    if (xOffset.value == 0) {
      openDrawer();
    } else {
      closeDrawer();
    }
  }

  Matrix4 getTransformValue() {
    return PreferenceUtils.getCurrentLocale() == const Locale('en', 'US')
        ? Matrix4.rotationY(22 / 7)
        : Matrix4.rotationY(0);
  }


}
