import 'package:flutter/material.dart';

class MyFonts {
  //headlines text font
  static TextStyle arabicFont = const TextStyle(fontFamily: "JF"); // for arabic
  // static TextStyle englishFont = TextStyle(fontFamily: "Poppins"); // for english

  //here check the app language from shared pref or whatever to choose the right font
  //static TextStyle fontStyle =  SharedPref.getCurrentLocale().languageCode == 'ar' ? arabicFont : englishFont;
  static TextStyle fontStyle =  arabicFont;

  // headlines text font
  static TextStyle HEADLINE_TEXT_STYLE = fontStyle;

  // body text font
  static TextStyle BODY_TEXT_STYLE = fontStyle;

  // button text font
  static TextStyle BUTTON_TEXT_STYLE = fontStyle;

  // app bar text font
  static TextStyle APPBAR_TEXT_STYLE  = fontStyle;

  // chips text font
  static TextStyle CHIP_TEXT_STYLE  = fontStyle;

  // chips text font
  static TextStyle DIALOG_TEXT_STYLE  = fontStyle;

  // body font size
  static double BODY1_TEXT_SIZE = 13;
  static double BODY2_TEXT_SIZE = 13;

  // headlines font size
  static double HEADLINE1_TEXT_SIZE = 26;
  static double HEADLINE2_TEXT_SIZE = 24;
  static double HEADLINE3_TEXT_SIZE = 22;
  static double HEADLINE4_TEXT_SIZE = 20;
  static double HEADLINE5_TEXT_SIZE = 18;
  static double HEADLINE6_TEXT_SIZE = 16;

  //button font size
  static double BUTTON_TEXT_SIZE = 14;

  //caption font size
  static double CAPTION_TEXT_SIZE = 13;

  //dialog font sized
  static double DIALOG_TEXT_SIZE = 13;

  //chip font size
  static double CHIP_TEXT_SIZE = 10;
}