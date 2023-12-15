import 'package:asas/app/data/model/currency.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerSettingsController extends GetxController {

  late bool checkbox ;
  List<Currency> currencyList = [];

  getCurrency() async {
    CustomLoading.showLoading();
    final result = await PortalRepository().getCurrency();
    CustomLoading.cancelLoading();
    if(result != null){
      currencyList = result;
    }
    update();
  }

  setCurrency(int? value){
    updateCurrency(value);
  }

  updateCurrency(id) async {
    CustomLoading.showLoading();
    final result = await PortalRepository().updateCurrency(id);
    CustomLoading.cancelLoading();
    if(result){
      update();
    }
  }

  getCurrencyIndex(){
    if(currencyList.isEmpty){
      return null;
    }


  }
  

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return LightColors.PRIMARY_COLOR;
  }

  void checkboxChange(bool val){
    checkbox = val;
    OwnerSharedPref.setNotificationStatus(val);
    update();
  }

  notificationStatus() {
    checkbox = OwnerSharedPref.getNotificationStatus();
  }

  @override
  void onInit() {
    notificationStatus();
   // getCurrency();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
