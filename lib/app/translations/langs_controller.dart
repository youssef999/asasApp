import 'package:asas/app/helpers/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';



class LangsController extends GetxController {

  updateLanguage(Locale locale){
    Get.showOverlay(asyncFunction: () async {
      Logger().e(locale.languageCode);
      // // check the language that we wanna change for
      // if(locale.languageCode == 'ar'){ // Arabic
      //   setNewFontForThemes(MyFonts.arabicFont);
      // }else { // English
      //   setNewFontForThemes(MyFonts.englishFont);
      // }
      // update language
      PreferenceUtils.setCurrentLocale(locale);
      Get.updateLocale(locale);
      //updage get builder
      update();
    }, loadingWidget: const Center(child: CircularProgressIndicator()) , opacity: 0.8);

  }


  toggleLanguage(){
    if(PreferenceUtils.getCurrentLocale() ==  Locale('ar', 'AR')){
      updateLanguage(Locale('en', 'US'));
    }else{
      updateLanguage(Locale('ar', 'AR'));
    }
  }

  // /// set the new font for both light/dark themes
  // setNewFontForThemes(TextStyle fontType){
  //   Themes.lightTheme = Themes.lightTheme.copyWith(
  //     textTheme: Styles.getTextTheme(isLightTheme: true,textStyle: fontType),
  //   );
  //   Themes.darkTheme = Themes.lightTheme.copyWith(
  //     textTheme: Styles.getTextTheme(isLightTheme: false,textStyle: fontType),
  //   );
  // }
}