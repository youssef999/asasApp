import 'dart:convert';

import 'package:asas/app/data/model/owner.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerSharedPref {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  //KEYS
  static final String USER_IS_LOGGED = 'owner_is_logged';
  static final String USER_PHONE_NUM = 'owner_phone_num';
  static final String USER_DATA = 'owner_data';
  static final String FCM_TOKEN = 'owner_fcm_token';
  static final String CURRENT_LOCAL = 'owner_current_local';
  static final String OWNER_INTRO = 'owner_intro';
  static final String OWNER_NOTIFICATION = 'owner_notification';

  static void setNotificationStatus(bool show) {
    try {
      _prefsInstance!.setBool(OWNER_NOTIFICATION, show);
    } catch (error) {
      print('ERRROR +> $error');
    }
  }

  static bool getNotificationStatus() {
    try {
      return _prefsInstance!.getBool(OWNER_NOTIFICATION) ?? false;
    } catch (error) {
      print('ERRROR +> $error');
    }
    return false;
  }

  static bool getIntroShow() {
    try {
      return _prefsInstance!.getBool(OWNER_INTRO) ?? false;
    } catch (error) {
      print('ERRROR +> $error');
    }
    return false;
  }

  static void setIntroShow(bool show) {
    try {
      _prefsInstance!.setBool(OWNER_INTRO, show);
    } catch (error) {
      print('ERRROR +> $error');
    }
  }
  // ///save fcm token
  // static void setCurrentLocale(Locale locale) {
  //   try {
  //     Logger().e(locale.languageCode);
  //     _prefsInstance!.setString(CURRENT_LOCAL, locale.languageCode);
  //   } catch (error) {
  //     print('ERRROR +> ${error}');
  //   }
  // }

  // /// get user fcm token
  // static Locale getCurrentLocale() {
  //   try {
  //     String? langCode = _prefsInstance!.getString(CURRENT_LOCAL);
  //     if (langCode != null) {
  //       if (langCode == 'ar') {
  //         return Locale('ar', 'AR');
  //       } else {
  //         return Locale('en', 'US');
  //       }
  //     }
  //   } catch (error) {}
  //   //return Get.deviceLocale ?? Locale('en', 'US');
  //   return Locale('ar', 'AR');
  // }

  ///save fcm token
  static void setFcmToken(String token) {
    try {
      _prefsInstance!.setString(FCM_TOKEN, token);
    } catch (error) {
      print('ERRROR +> $error');
    }
  }

  /// get user fcm token
  static String? getFcmToken() {
    try {
      return _prefsInstance!.getString(FCM_TOKEN);
    } catch (error) {}
    return null;
  }

  ///set user as logged to show home screen in begin of app
  static void setUserAsLogged(bool isLogged, {Owner? user}) {
    try {

      if(user!=null) {
        _prefsInstance!.setString(USER_DATA, json.encode(user.toJson()));
      }

      _prefsInstance!.setBool(USER_IS_LOGGED, isLogged);
    } catch (error) {
      Logger().e('ERRROR +> $error');
    }
  }


  /// get user renaining times to convert
  static bool getUserIsLogged() {
    try {
      bool? value = _prefsInstance!.getBool(USER_IS_LOGGED);
      return value ?? false;
    } catch (error) {}
    return false;
  }

  /// get user phone number
  static String? getPhoneNumber() {
    try {
      String? value = _prefsInstance!.getString(USER_PHONE_NUM);
      return value ;
    } catch (error) {}
    return null;
  }

  /// get user data
  static Owner? getUserData() {
    try {
      String? value = _prefsInstance!.getString(USER_DATA);
      return value != null ? Owner.fromJson(json.decode(value)) : null;
    } catch (error) {
      Logger().e('Shared Pref Error => $error');
    }
    return null;
  }

  // /// this will keep listen to user data (when user is logged or not)
  // static void listenToUserData(Function(dynamic value) callback){
  //   _storage.listenKey(USER_IS_LOGGED, (value){
  //     Logger().e('Value => ${value}');
  //     callback(value);
  //   });
  // }

}
