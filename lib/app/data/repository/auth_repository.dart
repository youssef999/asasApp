import 'dart:convert';

import 'package:asas/app/data/model/currency.dart';
import 'package:asas/app/data/model/owner.dart';
import 'package:asas/app/data/model/user.dart';
import 'package:asas/app/data/network/auth_service.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../translations/strings_enum.dart';


class AuthRepository {

  static final AuthRepository _singleton = AuthRepository._internal();


  factory AuthRepository() {
    return _singleton;
  }

  AuthRepository._internal();

  Future<Currency?> getCoinsType(int userId, String type) async {
    try {
      CustomLoading.showLoading();
      var _response = await AuthService.create().getCoinsType(
          userId: userId, type: type);
      CustomLoading.cancelLoading();
      if (_response.isSuccessful) {
        final responseData = json.decode(
            Get.locale.toString() == 'en_US' ? Get.locale.toString() == 'en_US'
                ? _response.bodyString.replaceAll('_ar', '_').replaceAll(
                "_en", '_ar')
                : _response.bodyString.replaceAll('_ar', '_').replaceAll(
                "_en", '_ar') : Get.locale.toString() == 'en_US'
                ? _response.bodyString.replaceAll('_ar', '_').replaceAll(
                "_en", '_ar')
                : _response.bodyString);
        if (responseData != null && responseData['status']) {
          Currency currency = Currency.fromJson(responseData['data']);
          return currency;
        } else {
          CustomLoading.showWrongToast(
              msg: responseData['message_ar'] ?? responseData['message']);
        }
      } else if (_response.statusCode >= 400 && _response.statusCode < 500) {
        final responseData = json.decode(
            Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll(
                '_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
        CustomLoading.showWrongToast(
            msg: responseData['message_ar'] ?? responseData['message']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
      }
    }catch(e){
      CustomLoading.cancelLoading();
      CustomLoading.showWrongToast(msg: e.toString());
    }
    return null;
  }

  Future<bool> userSignup(String name, String phone, String password, String cityId, String countryId) async {
    try {
      CustomLoading.showLoading(msg: Strings.CREATE_ACCOUNT.tr);
      final fcmToken = PreferenceUtils.getFcmToken();
      var _response = await AuthService.create().userSignup(name: name,
          password: password,
          phone: phone,
          deviceToken: fcmToken ?? '00s5h6er51h6er5h16ewr1h6',
          countryId: countryId,
          cityId: cityId);
      CustomLoading.cancelLoading();
      if (_response.isSuccessful) {
        final responseData = json.decode(
            Get.locale.toString() == 'en_US' ? Get.locale.toString() == 'en_US'
                ? _response.bodyString.replaceAll('_ar', '_').replaceAll(
                "_en", '_ar')
                : _response.bodyString.replaceAll('_ar', '_').replaceAll(
                "_en", '_ar') : Get.locale.toString() == 'en_US'
                ? _response.bodyString.replaceAll('_ar', '_').replaceAll(
                "_en", '_ar')
                : _response.bodyString);
        if(responseData['status'] == null){
          CustomLoading.showWrongToast(
              msg: responseData['name'][0]);
        }else if (responseData != null && responseData['status']) {
          User authUser = User.fromJson(responseData);
          PreferenceUtils.setUserAsLogged(true, user: authUser);
          CustomLoading.showSuccessToast(
              msg: Strings.CREATE_ACCOUNT_SUCCESS.tr);
          return true;
        } else {
          CustomLoading.showWrongToast(
              msg: responseData['message_ar'] ?? responseData['message']);
        }
      } else if (_response.statusCode >= 400 && _response.statusCode < 500) {
        final responseData = json.decode(
            Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll(
                '_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
        CustomLoading.showWrongToast(
            msg: responseData['message_ar'] ?? responseData['message']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
      }
    }catch(e){
      CustomLoading.showWrongToast(msg: e.toString());
      CustomLoading.cancelLoading();
    }
    return false;
  }

  Future<bool> ownerSignup(String name, String corporationName, String corporationNameAr,String phone, String password) async {
    CustomLoading.showLoading(msg: Strings.CREATE_ACCOUNT.tr);
    final fcmToken = PreferenceUtils.getFcmToken();
    var _response = await AuthService.create().ownerSignup(name: name, password: password, corporationName: corporationName, corporationNameAr: corporationNameAr, phone: phone, deviceToken: fcmToken ?? '');
    CustomLoading.cancelLoading();
    if (_response.isSuccessful) {
      final responseData = json.decode(Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
      if (responseData != null && responseData['status']) {
        Owner authUser = Owner.fromJson(responseData);
        OwnerSharedPref.setUserAsLogged(true, user: authUser);
        CustomLoading.showSuccessToast(msg: Strings.CREATE_ACCOUNT_SUCCESS.tr);
        return true;
      } else {
        CustomLoading.showWrongToast(msg: responseData['message_ar'] ?? responseData['message']);
      }
    }else if (_response.statusCode >= 400 && _response.statusCode < 500) {
      final responseData = json.decode(Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
      CustomLoading.showWrongToast(msg: responseData['message_ar'] ?? responseData['message']);
    } else {
      CustomLoading.showWrongToast(msg:  Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<bool> login(String name, String password) async {
    CustomLoading.showLoading(msg: Strings.SIGINING_IN.tr);
    final fcmToken = PreferenceUtils.getFcmToken();
    var _response = await AuthService.create().login(name: name, password: password, fcmToken: fcmToken ?? '');
    CustomLoading.cancelLoading();
    if (_response.isSuccessful) {
      final responseData = json.decode(Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
      if (responseData != null && responseData['status']) {
      //  Logger().w(responseData);
        Owner authUser = Owner.fromJson(responseData);
        OwnerSharedPref.setUserAsLogged(true, user: authUser);
        CustomLoading.showSuccessToast(msg: Strings.lOGGED_SUCCESS.tr);
        return true;
      } else {
        CustomLoading.showWrongToast(msg: responseData['message_ar'] ?? responseData['message']);
      }
    }else if (_response.statusCode >= 400 && _response.statusCode < 500) {
      final responseData = json.decode(Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
      CustomLoading.showWrongToast(msg: responseData['message_ar'] ?? responseData['message']);
    } else {
      CustomLoading.showWrongToast(msg:  Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<bool> userLogin(String name, String password) async {
    CustomLoading.showLoading(msg: Strings.SIGINING_IN.tr);
    final fcmToken = PreferenceUtils.getFcmToken();
    var _response = await AuthService.create().userLogin(name: name, password: password, fcmToken: fcmToken ?? '');
    CustomLoading.cancelLoading();
    if (_response.isSuccessful) {
      final responseData = json.decode(Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
      if (responseData != null && responseData['status']) {
        User authUser = User.fromJson(responseData);
        PreferenceUtils.setUserAsLogged(true, user: authUser);
        CustomLoading.showSuccessToast(msg: Strings.lOGGED_SUCCESS.tr);
        return true;
      } else {
        CustomLoading.showWrongToast(msg: responseData['message_ar'] ?? responseData['message']);
      }
    }else if (_response.statusCode >= 400 && _response.statusCode < 500) {
      final responseData = json.decode(Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
      CustomLoading.showWrongToast(msg: responseData['message_ar'] ?? responseData['message']);
    } else {
      CustomLoading.showWrongToast(msg:  Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }


  Future<bool> userLoginWithFacebookUrl(String accessToken, String providerName, String countryId, String cityId) async {
    CustomLoading.showLoading(msg: Strings.SIGINING_IN.tr);
    final fcmToken = PreferenceUtils.getFcmToken();
    var _response = await AuthService.create().userLoginWithFacebookUrl(accessToken: accessToken, providerName: providerName, cityId: cityId, countryId: countryId, fcmToken: fcmToken ?? 'يسسيسيسي');
    CustomLoading.cancelLoading();
    if (_response.isSuccessful) {
      final responseData = json.decode(Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
      Logger().w(responseData);
      if (responseData != null && responseData['status']) {
        User authUser = User.fromJson(responseData);
        PreferenceUtils.setUserAsLogged(true, user: authUser);
        CustomLoading.showSuccessToast(msg: Strings.lOGGED_SUCCESS.tr);
        return true;
      } else {
        CustomLoading.showWrongToast(msg: responseData['message_ar'] ?? responseData['message']);
      }
    }else if (_response.statusCode >= 400 && _response.statusCode < 500) {
      final responseData = json.decode(Get.locale.toString() == 'en_US' ? _response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : _response.bodyString);
      CustomLoading.showWrongToast(msg: responseData['message_ar'] ?? responseData['message']);
    } else {
      CustomLoading.showWrongToast(msg:  Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }




}
