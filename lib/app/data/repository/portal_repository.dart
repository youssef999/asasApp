import 'dart:convert';

import 'package:asas/app/data/model/agreements.dart';
import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/model/company_type.dart';
import 'package:asas/app/data/model/currency.dart';
import 'package:asas/app/data/model/curriculum_type.dart';
import 'package:asas/app/data/model/main_chat.dart';
import 'package:asas/app/data/model/message.dart';
import 'package:asas/app/data/model/my_notification.dart';
import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/model/program_type.dart';
import 'package:asas/app/data/model/reservation.dart';
import 'package:asas/app/data/model/reservation_details.dart';
import 'package:asas/app/data/model/reservation_status.dart';
import 'package:asas/app/data/model/time_type.dart';
import 'package:asas/app/data/network/portal_service.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../translations/strings_enum.dart';

class PortalRepository {
  static final PortalRepository _singleton = PortalRepository._internal();

  factory PortalRepository() {
    return _singleton;
  }

  PortalRepository._internal();

  Future<int?> getNotificationCount() async {
    try {
      var _response = await PortalService.create().getNotificationCount();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['success']) {
          return responseData['count'];
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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
      var _response = await PortalService.create().getNotification(page);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['success']) {
          final NotificationResponse notificationResponse =
              NotificationResponse.fromJson(responseData['notifications']);
          return notificationResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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

  Future<ReservationDetails?> getReservationDetails(int reservationId) async {
    try {
      var _response =
          await PortalService.create().getReservationDetails(reservationId);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          Logger().i(responseData);
          final ReservationDetails reservationDetails =
              ReservationDetails.fromJson(responseData);

          return reservationDetails;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e, s) {
      Logger().i(e);
      Logger().i(s);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<List<MainChat>?> getChatList() async {
    try {
      var _response = await PortalService.create().getChatList();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['success']) {
          Logger().e(responseData);
          final List<MainChat> mainChatList = (responseData['data'] as List)
              .map((e) => MainChat.fromJson(e))
              .toList();

          return mainChatList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<bool> updateReservationStatus(
      int childrenProgramId, int reservationStatusesId) async {
    try {
      var _response = await PortalService.create()
          .updateReservationStatus(childrenProgramId, reservationStatusesId);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<List<ReservationStatus>?> getReservationStatus() async {
    try {
      var _response = await PortalService.create().getReservationStatus();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          Logger().e(responseData);
          final List<ReservationStatus> reservationStatusList =
              (responseData['reservation_status'] as List)
                  .map((e) => ReservationStatus.fromJson(e))
                  .toList();

          return reservationStatusList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<ReservationResponse?> getReservationByStatusId(int statusId) async {
    try {
      var _response =
          await PortalService.create().getReservationByStatusId(statusId);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          //Logger().e(responseData);
          final ReservationResponse reservationResponse =
              ReservationResponse.fromJson(responseData);

          return reservationResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<ReservationResponse?> getReservation() async {
    try {
      var _response = await PortalService.create().getReservation();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          //Logger().e(responseData);
          final ReservationResponse reservationResponse =
              ReservationResponse.fromJson(responseData);

          return reservationResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<bool> sendMessage(
    int companyId,
    int fatherId,
    String message,
    String sender,
  ) async {
    try {
      var _response = await PortalService.create()
          .sendMessage(companyId, fatherId, message, sender);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['success']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<List<Message>?> getChat(int companyId, int fatherId) async {
    try {
      var _response = await PortalService.create().getChat(companyId, fatherId);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['success']) {
          final List<Message> messageList = (responseData['data'] as List)
              .map((e) => Message.fromJson(e))
              .toList();

          return messageList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<bool> updateCurrency(int id) async {
    try {
      var _response = await PortalService.create().updateCurrency(id);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<List<Currency>?> getCurrency() async {
    try {
      var _response = await PortalService.create().getCurrency();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        // Logger().w(responseData);
        if (responseData != null) {
          final List<Currency> currencyList =
              (responseData as List).map((e) => Currency.fromJson(e)).toList();

          return currencyList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      Logger().w(e);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<List<Agreement>?> getAgreements() async {
    try {
      var _response = await PortalService.create().getAgreements();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          final List<Agreement> agreementList = (responseData['data'] as List)
              .map((e) => Agreement.fromJson(e))
              .toList();

          return agreementList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  // Future<bool> updateCompany(Map<dynamic, dynamic> body, int id) async {
  //   print("------------ ${body['id_district']}");

  //   try {
  //     var _response = await PortalService.create().updateCompany(
  //         id,
  //         body["name_corporation"]!,
  //         body["name_corporation_ar"]!,
  //         body["desception_ar"]!,
  //         body["desception_en"]!,
  //         body["lat"]!,
  //         body["lng"]!,
  //         body["id_country"]!,
  //         body["id_city"]!,
  //         body["id_district"]!,
  //         body["id_coins"]!,
  //         body["id_company_type"]!,
  //         body["logo"]!
  //         );
      
  //     print(_response.isSuccessful);
  //     if (_response.isSuccessful) {
  //       final responseData = json.decode(Get.locale.toString() == 'en_US'
  //           ? _response.bodyString
  //               .replaceAll('_ar', '_')
  //               .replaceAll("_en", '_ar')
  //           : _response.bodyString);
  //       print("zxzx $responseData");
  //       if (responseData != null && responseData['status']) {
  //         CustomLoading.showSuccessToast(msg: responseData['message_ar']);
  //         return true;
  //       } else {
  //         CustomLoading.showWrongToast(msg: responseData['message_ar']);
  //       }
  //     } else if (_response.statusCode == 401) {
  //       CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
  //     } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
  //       final responseData = json.decode(Get.locale.toString() == 'en_US'
  //           ? _response.bodyString
  //               .replaceAll('_ar', '_')
  //               .replaceAll("_en", '_ar')
  //           : _response.bodyString);
  //       CustomLoading.showWrongToast(msg: responseData['message_ar']);
  //     } else {
  //       CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
  //     }
  //   } catch (e) {
  //     Logger().e(e);
  //     CustomLoading.cancelLoading();
  //     CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
  //   }
  //   return false;
  // }


  Future<Company?> getMyCompany() async {
    try {
      var _response = await PortalService.create().getMyCompany();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          // Logger().w(responseData);
          final Company company = Company.fromJson(responseData);

          return company;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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

  Future<bool> addMedia(Map<String, String> body, int id) async {
    try {
      var _response = await PortalService.create().addMedia(
        id.toString(),
        body['table_name']!, // programs , company
        body['media']!,
      );
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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

  Future<bool> addService(Map<String, String> body, int id) async {
    try {
      var _response = await PortalService.create().addService(
        id.toString(),
        body['price']!,
        body['service_ar']!,
        body['service_en']!,
      );
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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

  Future<bool> addDiscount(Map<String, String> body, int id) async {
    try {
      var _response = await PortalService.create().addDiscount(
        id.toString(),
        body['price_rate_discount']!,
        body['start_discount']!,
        body['end_discount']!,
      );
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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

  Future<bool> deleteMedia(int id) async {
    try {
      var _response = await PortalService.create().deleteMedia(id);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<bool> deleteService(int id) async {
    try {
      var _response = await PortalService.create().deleteService(id);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<bool> deleteDiscount(int id) async {
    try {
      var _response = await PortalService.create().deleteDiscount(id);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<List<CompanyType>?> getCompanyTypes() async {
    try {
      var _response = await PortalService.create().getCompanyTypes();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          final List<CompanyType> companyTypeList =
              (responseData['data'] as List)
                  .map((e) => CompanyType.fromJson(e))
                  .toList();

          return companyTypeList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<List<CurriculumType>?> getCurriculum() async {
    try {
      var _response = await PortalService.create().getCurriculum();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          final List<CurriculumType> curriculumTypeList =
              (responseData['data'] as List)
                  .map((e) => CurriculumType.fromJson(e))
                  .toList();

          return curriculumTypeList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<Program?> updateProgram(Map<String, String> body, int id) async {
    try {
      var _response = await PortalService.create().updateProgram(
        id,
        body['name_en']!,
        body['name_ar']!,
        body['description_en']!,
        body['description_ar']!,
        body['id_timeType']!,
        body['id_typeProgram']!,
        body['price_main']!,
        body['age_conditions_en']!,
        body['age_conditions_ar']!,
        body['other_conditions_en']!,
        body['other_conditions_ar']!,
        body['price_note_ar']!,
        body['price_note_en']!,
        body['other_fute']!,
        body['url_viedo']!,
        body['id_curriculum_type']!,
      );
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          Logger().e(responseData['data']);
          final Program programResponse =
              Program.fromJson(responseData['data']);
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return programResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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

  Future<Program?> getProgramById(int id) async {
    try {
      var _response = await PortalService.create().getProgramById(id);
      if (_response.isSuccessful) {
        Logger().w(_response.body.toString());
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        // Logger().w(responseData);
        if (responseData != null && responseData['status']) {
          final program = Program.fromJson(responseData);
          return program;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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

  Future<Program?> getProgramComById(int id) async {
    try {
      var _response = await PortalService.create().getProgramComById(id);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        Logger().w(responseData);
        if (responseData != null && responseData['status']) {
          final program = Program.fromJson(responseData);
          return program;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
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

  Future<bool> deleteProgram(int id) async {
    try {
      var _response = await PortalService.create().deleteProgram(id);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return true;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return false;
  }

  Future<Program?> addProgram(
      Map<String, String> body, List<String> images) async {
    try {
      var _response = await PortalService.create().addProgram(
          body['name_en']!,
          body['name_ar']!,
          body['description_en']!,
          body['description_ar']!,
          body['id_timeType']!,
          body['id_typeProgram']!,
          body['price_main']!,
          body['age_conditions_en']!,
          body['age_conditions_ar']!,
          body['other_conditions_en']!,
          body['other_conditions_ar']!,
          body['price_note_ar']!,
          body['price_note_en']!,
          body['other_fute']!,
          body['url_viedo']!,
          body['id_curriculum_type']!,
          body['discount']!,
          body['service_more']!,
          images);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          Logger().e(responseData['data']);
          final Program programResponse =
              Program.fromJson(responseData['data']);
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return programResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e, s) {
      print(e);
      print(s);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<List<TimeType>?> getTimeTypes() async {
    try {
      var _response = await PortalService.create().getTimeTypes();
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          final List<TimeType> timeTypeList = (responseData['data'] as List)
              .map((e) => TimeType.fromJson(e))
              .toList();

          return timeTypeList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<List<ProgramType>?> getProgramTypes() async {
    try {
      var _response = await PortalService.create().getProgramTypes();
      if (_response.isSuccessful) {
        Logger().i(_response.bodyString);
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          final List<ProgramType> programTypeList =
              (responseData['data'] as List)
                  .map((e) => ProgramType.fromJson(e))
                  .toList();

          return programTypeList;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<Program?> copyProgram(int id) async {
    try {
      var _response = await PortalService.create().copyProgram(id);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);

        if (responseData != null && responseData['status']) {
          final Program programResponse =
              Program.fromJson(responseData['data']);
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return programResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (_) {
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }

  Future<ProgramResponse?> getPrograms(int userId, int page) async {
    try {
      var _response = await PortalService.create().getPrograms(userId, page);
      if (_response.isSuccessful) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        if (responseData != null && responseData['status']) {
          //Logger().v(responseData);
          final ProgramResponse programResponse =
              ProgramResponse.fromJson(responseData['data']);

          return programResponse;
        } else {
          CustomLoading.showWrongToast(msg: responseData['message_ar']);
        }
      } else if (_response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (_response.statusCode >= 400 && _response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? _response.bodyString
                .replaceAll('_ar', '_')
                .replaceAll("_en", '_ar')
            : _response.bodyString);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e, s) {
      Logger().w(e);
      Logger().w(s);
      CustomLoading.showWrongToast(msg: Strings.NO_INTERNET_CONECTION.tr);
    }
    return null;
  }
}
