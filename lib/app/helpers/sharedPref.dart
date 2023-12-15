import 'dart:convert';

import 'package:asas/app/data/model/my_location.dart';
import 'package:asas/app/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceUtils {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;


  static final String CITY_ID = 'city_id';
  static final String COUNTRY_ID = 'country_id';
  static final String FCM_TOKEN = 'fcm_token';
  static final String USER_IS_LOGGED = 'user_is_logged';
  static final String USER_PHONE_NUM = 'user_phone_num';
  static final String USER_DATA = 'user_data';
  static final String CURRENT_LOCAL = 'current_local';
  static final String MY_LOCATION = 'my_location';




  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<void> setCityCountry(cityId, countryId) async{
    try {
      await _prefsInstance!.setString(CITY_ID,  cityId.toString());
      await _prefsInstance!.setString(COUNTRY_ID,  countryId.toString());
    } catch (error) {
      Logger().e(error);
    }
  }


  static Map<String, int>? getCityCountry()  {
    try {
      final cityId =  _prefsInstance!.getString(CITY_ID);
      final countryId =  _prefsInstance!.getString(COUNTRY_ID);
      return {"cityId":int.parse(cityId!),"countryId":int.parse(countryId!)};
    } catch (error) {
      Logger().e(error);
    }
    return null;
  }


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
    } catch (error) {
      print('ERRROR +> $error');
    }
    return null;
  }

  ///set user as logged to show home screen in begin of app
  static void setUserAsLogged(bool isLogged, {User? user}) {
    try {

      if(user!=null) {
        if(getUserData()?.accessToken != null){
          user.accessToken = getUserData()?.accessToken;
        }
        _prefsInstance!.setString(USER_DATA, json.encode(user.toJson()));
      }else{
        _prefsInstance!.remove(USER_DATA);
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
    } catch (error) {
      Logger().e('getUserIsLogged => $error');
    }
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
  static User? getUserData() {
    try {
      String? value = _prefsInstance!.getString(USER_DATA);
      return value != null ? User.fromJson(json.decode(value)) : null;
    } catch (error) {
      Logger().e('Shared Pref Error => $error');
    }
    return null;
  }

  ///save fcm token
  static void setCurrentLocale(Locale locale) {
    try {
      Logger().e(locale.languageCode);
      _prefsInstance!.setString(CURRENT_LOCAL, locale.languageCode);
    } catch (error) {
      print('ERRROR +> $error');
    }
  }

  /// get user fcm token
  static Locale getCurrentLocale() {
    try {
      String? langCode = _prefsInstance!.getString(CURRENT_LOCAL);
      if (langCode != null) {
        if (langCode == 'ar') {
          return Locale('ar', 'AR');
        } else {
          return Locale('en', 'US');
        }
      }
    } catch (error) {
      Logger().e(error);
    }
    //return Get.deviceLocale ?? Locale('en', 'US');
    return Locale('ar', 'AR');
  }


  static void saveListWithGetStorage(String storageKey, List<dynamic> storageValue) async => await _prefsInstance!.setString(storageKey, jsonEncode(storageValue));


  static void setMyLocation(MyLocation listNeedToSave) {
    try{
      /// getting all saved data
      String? oldSavedData = _prefsInstance!.getString(MY_LOCATION);

      /// in case there is saved data
      if(oldSavedData != null){
        /// create a holder list for the old data
        List<dynamic> oldSavedList = json.decode(oldSavedData);

        if(oldSavedList.isNotEmpty){
          listNeedToSave.id = oldSavedList.last["id"] + 1 ;
        }
        /// append the new list to saved one

        oldSavedList.add(listNeedToSave.toJson());
        /// save the new collection
        return saveListWithGetStorage(MY_LOCATION, oldSavedList);
      } else{
        /// in case of there is no saved data -- add the new list to storage
        return saveListWithGetStorage(MY_LOCATION, [listNeedToSave]);
      }
    }catch(e){
      Logger().w(e);
    }

  }

  static void setMyLocationList(List<MyLocation> listNeedToSave) {
    return saveListWithGetStorage(MY_LOCATION, listNeedToSave);
  }


  static List<MyLocation>? getMyLocations() {
    try {
      String? value = _prefsInstance!.getString(MY_LOCATION);
      final mJson = json.decode(value!);
      final List<MyLocation>? list = [];
      for(var item in mJson){
        list!.add(MyLocation.fromJson(item));
      }
      return list;
    } catch (error) {
      Logger().e('Shared Pref Error => $error');
      return null;
    }
  }

  static  deleteLocations(int id) {
    Logger().w(id);
    try{
      /// getting all saved data
      String? oldSavedData = _prefsInstance!.getString(MY_LOCATION);

      /// in case there is saved data
      if(oldSavedData != null){
        /// create a holder list for the old data
        List<dynamic> oldSavedList = json.decode(oldSavedData);
        Logger().w(oldSavedList.toString());
        /// append the new list to saved one
        oldSavedList.removeWhere((element) => element["id"] == id);
        /// save the new collection
        return saveListWithGetStorage(MY_LOCATION, oldSavedList);
      }
    }catch(e){
      Logger().w(e);
    }

  }

}
