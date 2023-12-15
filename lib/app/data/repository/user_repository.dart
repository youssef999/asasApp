import 'dart:convert';

import 'package:asas/app/data/model/booking.dart';
import 'package:asas/app/data/model/comment_response.dart';
import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/model/country.dart';
import 'package:asas/app/data/model/main_chat.dart';
import 'package:asas/app/data/model/message.dart';
import 'package:asas/app/data/model/my_notification.dart';
import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/model/rating.dart';
import 'package:asas/app/data/model/student.dart';
import 'package:asas/app/data/model/user.dart';
import 'package:asas/app/data/network/user_service.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/modules/user/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../translations/strings_enum.dart';

class UserRepository {
  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  Future<int?> getCountNotRead(int idCompany, int getFA) async {
    // try {
    //   CustomLoading.showLoading();
    //   var response = await UserService.create().getCountNotRead(idCompany);
    //   CustomLoading.cancelLoading();
    //   if (response.isSuccessful) {
    //     final responseData = json.decode(Get.locale.toString() == 'en_US' ? response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : response.bodyString);
    //
    //     if (responseData != null && responseData['status']) {
    //       CustomLoading.showSuccessToast(msg: responseData['message_ar']);
    //       return responseData['id'];
    //     } else {
    //       CustomLoading.showWrongToast(msg: responseData['message_ar']);
    //     }
    //   } else if (response.statusCode == 401) {
    //     CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
    //   } else if (response.statusCode >= 400 && response.statusCode <= 500) {
    //     final responseData = json.decode(Get.locale.toString() == 'en_US' ? response.bodyString.replaceAll('_ar', '_').replaceAll("_en", '_ar') : response.bodyString);
    //     CustomLoading.showWrongToast(msg: responseData['message_ar']);
    //   } else {
    //     CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
    //   }
    // } catch (e) {
    //   Logger().e(e);
    //   CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    // }
    // return null;
  }

  Future<User?> updateProfile(
      String name, String phone, int idCountry, int idCity, int idCoins) async {
    try {
      CustomLoading.showLoading();
      var response = await UserService.create()
          .updateProfile(name, phone, idCountry, idCity, idCoins);
      CustomLoading.cancelLoading();
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);

          User authUser = User.fromJson(responseData['data']);
          PreferenceUtils.setUserAsLogged(true, user: authUser);
          PreferenceUtils.setCityCountry(authUser.idCity, authUser.idCountry);
          Get.find<HomeController>().onRefresh();
          return authUser;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<User?> getProfile() async {
    try {
      var response = await UserService.create().getProfile();
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          //   Logger().w(responseData);

          User authUser = User.fromJson(responseData['data']);
          PreferenceUtils.setUserAsLogged(true, user: authUser);

          return authUser;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> getFavorite(int page) async {
    try {
      var response = await UserService.create().getFavorite(page);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          Logger().w(responseData);
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<bool> deleteFavorite(int favoriteId) async {
    try {
      CustomLoading.showLoading();
      var response = await UserService.create().deleteFavorite(favoriteId);
      CustomLoading.cancelLoading();
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<int?> addFavorite(int idCompany) async {
    try {
      CustomLoading.showLoading();
      var response = await UserService.create().addFavorite(idCompany);
      CustomLoading.cancelLoading();
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return responseData['id'];
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<int?> getNotificationCount() async {
    try {
      var response = await UserService.create().getNotificationCount();
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['success']) {
          return responseData['count'];
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<NotificationResponse?> getNotification(int page) async {
    try {
      var response = await UserService.create().getNotification(page);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['success']) {
          final NotificationResponse notificationResponse =
              NotificationResponse.fromJson(responseData['data']);
          return notificationResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<ProgramResponse?> programsSearch(
      int page, int categoryId, String query) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      var response = await UserService.create()
          .programsSearch(query, categoryId, city, page);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          Logger().w(responseData);
          final ProgramResponse programResponse =
              ProgramResponse.fromJson(responseData['data']);

          return programResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> getCompanyByLocation(
      String latitude, String longitude, int page) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      var response = await UserService.create()
          .getCompanyByLocation(latitude, longitude, page, city);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        //Logger().w(responseData);
        if (responseData != null && responseData['status']) {
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> getTopRatedCompany(int page) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();

      var response = await UserService.create().getTopRatedCompany(page, city);
      if (response.isSuccessful) {
        //   Logger().d(response.bodyString);
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        // Logger().d(responseData);
        if (responseData != null && responseData['status']) {
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> getAllCompany(int page) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      var response = await UserService.create().getAllCompany(page, city);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        if (responseData != null && responseData['status']) {
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> companyCategorySearch(
      int page, int categoryId, String query) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      var response = await UserService.create()
          .companyCategorySearch(query, categoryId, page, city);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> companySearch(int page, String query) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();

      var response =
          await UserService.create().companySearch(query, page, city);
      if (response.isSuccessful) {
        Logger().w(response.bodyString);
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<Rating?> getCompanyRate(int companyId) async {
    try {
      var response = await UserService.create().getRate(companyId);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          //Logger().e(responseData);

          final Rating rating = Rating.fromJson(responseData['rate']);

          return rating;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<bool> addRate(
    int idCompany,
    double scientificLevel,
    double activityLevel,
    double buildingsAndStadiums,
    double attentionAndCommunication,
    double disciplineAndCleanliness,
  ) async {
    try {
      var response = await UserService.create().addRate(
          idCompany,
          scientificLevel,
          activityLevel,
          buildingsAndStadiums,
          attentionAndCommunication,
          disciplineAndCleanliness);

      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        Logger().e(responseData);
        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<List<MainChat>?> getChatList() async {
    try {
      var response = await UserService.create().getChatList();
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['success']) {
          Logger().e(responseData);
          final List<MainChat> studentList = (responseData['data'] as List)
              .map((e) => MainChat.fromJson(e))
              .toList();

          return studentList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  void uniqifyList(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      dynamic o = list[i];
      int index;
      // Remove duplicates
      do {
        index = list.indexWhere((element) => element.id == o.id);
        if (index != -1) {
          list.removeRange(index, 1);
        }
      } while (index != -1);
    }
  }

  Future<List<Student>?> getStudentsNotReserved(int id) async {
    try {
      var response = await UserService.create().getStudentsNotReserved(id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          // Logger().w(responseData);
          final List<Student> list = (responseData['data'] as List)
              .map((e) => Student.fromJson(e))
              .toList();
          final List<Student> list2 = (responseData['data2'] as List)
              .map((e) => Student.fromJson(e))
              .toList();

          list.addAll(list2);

          final List<Student> finalList = [];

          for (var element in list) {
            try {
              finalList.firstWhere((e) => e.id == element.id);
            } catch (_) {
              finalList.add(element);
            }
          }

          return finalList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<bool> deleteBooking(int id) async {
    try {
      var response = await UserService.create().deleteBooking(id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<BookingResponse?> getMyBooking(int page) async {
    try {
      var response = await UserService.create().getMyBooking(page);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          Logger().e(responseData);
          final BookingResponse bookingList =
              BookingResponse.fromJson(responseData['data']);

          return bookingList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<String?> addStudentToProgram(
    String childIds,
    int programId,
    String serviceIds,
  ) async {
    try {
      var response = await UserService.create()
          .addStudentToProgram(childIds, programId, serviceIds);
      print("ddllk1 $response");
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          //CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return responseData['message_ar'];
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
      Logger().w(_);
      print("ddllk $_");
    }
    return null;
  }

  Future<CommentResponse?> getComments(int companyId, int page) async {
    try {
      var response = await UserService.create().getComments(companyId, page);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        //Logger().e(responseData);
        if (responseData != null && responseData['status']) {
          final CommentResponse commentResponse =
              CommentResponse.fromJson(responseData['data']);

          return commentResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<bool> addComment(int companyId, String comment) async {
    print("ddllkt $companyId");
    try {
      var response = await UserService.create().addComment(companyId, comment);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['meessage_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['meessage_ar']);
        }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(
            msg: responseData['meessage_ar'] ?? Strings.MUST_BE_LOGGED);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['meessage_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      // Logger().w(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
      print("ddllkt $e");
    }
    return false;
  }

  Future<bool> sendMessage(
    int companyId,
    int fatherId,
    String message,
    String sender,
  ) async {
    try {
      var response = await UserService.create()
          .sendMessage(companyId, fatherId, message, sender);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['success']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
      print("ddllkq $_");
    }
    return false;
  }

  Future<List<Message>?> getChat(int companyId, int fatherId) async {
    try {
      var response = await UserService.create().getChat(companyId, fatherId);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['success']) {
          final List<Message> messageList = (responseData['data'] as List)
              .map((e) => Message.fromJson(e))
              .toList();

          return messageList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> getCompaniesByCategoryId(
      int categoryId, int page) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      var response = await UserService.create()
          .getCompaniesByCategoryId(categoryId, city, page);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<Company?> getCompanyById(int id) async {
    try {
      var response = await UserService.create().getCompanyById(id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        // Logger().e(responseData);

        if (responseData != null && responseData['status']) {
          final Company companyResponse = Company.fromJson(responseData);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e, s) {
      Logger().e(e);
      Logger().e(s);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<Company?> getCompanyByIdWithFav(int id, int idFather) async {
    try {
      var response =
          await UserService.create().getCompanyByIdWithFav(id, idFather);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        // Logger().w(responseData);

        if (responseData != null && responseData['status']) {
          final Company companyResponse = Company.fromJson(responseData);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> getCompaniesByToken(int page) async {
    try {
      var response = await UserService.create().getCompaniesByToken(page);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().e(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> getCompaniesByCountryAndCityId(int page) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      String? country = PreferenceUtils.getUserData()?.idCountry;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      country ??= PreferenceUtils.getCityCountry()!['countryId'].toString();
      var response = await UserService.create()
          .getCompaniesByCountryAndCityId(country, city, page);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        if (responseData != null && responseData['status']) {
          //  Logger().w(responseData);
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<CompanyResponse?> getDistricts(int page, int sort,int id) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      String? country = PreferenceUtils.getUserData()?.idCountry;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      country ??= PreferenceUtils.getCityCountry()!['countryId'].toString();
      var response =
          await UserService.create().getDistricts(country, city, page, sort,id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        if (responseData != null && responseData['status']) {
          //  Logger().w(responseData);
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }
Future<CompanyResponse?> getNewest(int page, int id,int district) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      String? country = PreferenceUtils.getUserData()?.idCountry;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      country ??= PreferenceUtils.getCityCountry()!['countryId'].toString();
      var response =
          await UserService.create().getNewest(country, city, page, id,district);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        if (responseData != null && responseData['status']) {
          //  Logger().w(responseData);
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }
  Future<CompanyResponse?> getClosest(int page, int id,String latitude,String longitude,int district) async {
    try {
      String? city = PreferenceUtils.getUserData()?.idCity;
      String? country = PreferenceUtils.getUserData()?.idCountry;
      city ??= PreferenceUtils.getCityCountry()!['cityId'].toString();
      country ??= PreferenceUtils.getCityCountry()!['countryId'].toString();
      var response =
          await UserService.create().getClosest(country, city, page, id,latitude,longitude,district);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        if (responseData != null && responseData['status']) {
          //  Logger().w(responseData);
          final CompanyResponse companyResponse =
              CompanyResponse.fromJson(responseData['data']);

          return companyResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }
  Future<bool> deleteMedia(int id) async {
    try {
      var response = await UserService.create().deleteMedia(id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<bool> addMedia(Map<String, String> body, int id) async {
    try {
      var response = await UserService.create().addMedia(
        id.toString(),
        body['table_name']!, // programs , company
        body['media']!,
      );
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      print(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<Student?> getStudentById(int id) async {
    try {
      var response = await UserService.create().getStudentById(id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final Student student = Student.fromJson(responseData);
          return student;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<List<Country>?> getCity(int id) async {
    try {
      var response = await UserService.create().getCity(id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final List<Country> countryList = (responseData['data'] as List)
              .map((e) => Country.fromJson(e))
              .toList();
          print("xoxoxo1 $countryList");
          return countryList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<List<Country>?> getDistrict(int id) async {
    try {
      var response = await UserService.create().getDistrict(id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        if (responseData != null && responseData['status']) {
          final List<Country> districtList = (responseData['data'] as List)
              .map((e) => Country.fromJson(e))
              .toList();
          return districtList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<List<Country>?> getCountries() async {
    try {
      var response = await UserService.create().getCountries();
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final List<Country> countryList = (responseData['data'] as List)
              .map((e) => Country.fromJson(e))
              .toList();

          return countryList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<Student?> updateStudents(Map<String, String> body, int id) async {
    try {
      var response = await UserService.create().updateStudents(
        id,
        body['name']!,
        body['name_father']!,
        body['date_of_birth']!,
        body['gender']!,
        body['nationality']!,
        body['country_of_residence']!,
        body['id_curriculum_type']!,
        body['current_academic_certificates']!,
        body['sports_of_interest']!,
        body['artistic_activities_of_interest']!,
        body['religious_activities_of_interest']!,
      );
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          Logger().e(responseData['data']);
          final Student studentResponse =
              Student.fromJson(responseData['data']);
          CustomLoading.showSuccessToast(
              msg: responseData['message_ar'] ?? Strings.SAVE_SUCCESS);
          return studentResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      print(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<Student?> addStudents(
      Map<String, String> body, List<String> images) async {
    try {
      var response = await UserService.create().addStudents(
          body['name']!,
          body['name_father']!,
          body['date_of_birth']!,
          body['gender']!,
          body['nationality']!,
          body['country_of_residence']!,
          body['id_curriculum_type']!,
          body['current_academic_certificates']!,
          body['sports_of_interest']!,
          body['artistic_activities_of_interest']!,
          body['religious_activities_of_interest']!,
          images);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final Student studentResponse =
              Student.fromJson(responseData['data']);
          CustomLoading.showSuccessToast(
              msg: responseData['message_ar'] ?? Strings.SAVE_SUCCESS);
          return studentResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      print(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<bool> deleteStudents(int id) async {
    try {
      var response = await UserService.create().deleteStudents(id);
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<List<Student>?> getStudents() async {
    try {
      var response = await UserService.create().getStudents();
      if (response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);

        if (responseData != null && responseData['status']) {
          final List<Student> studentList = (responseData['data'] as List)
              .map((e) => Student.fromJson(e))
              .toList();

          return studentList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }
}
