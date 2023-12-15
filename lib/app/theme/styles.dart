import 'package:flutter/material.dart';
import 'darkColors.dart';
import 'fonts.dart';
import 'lightColors.dart';

class Styles {
  ///icons theme
  static IconThemeData getIconTheme({required bool isLightTheme}) => IconThemeData(
        color: isLightTheme ? LightColors.ICON_COLOR : DarkColors.ICON_COLOR,
      );

  ///app bar theme
  static AppBarTheme getAppBarTheme({required bool isLightTheme}) => AppBarTheme(
        elevation: 0,
        titleTextStyle: getTextTheme(isLightTheme: isLightTheme).bodyLarge!.copyWith(
              color: Colors.black,
              fontSize: 18,
          fontWeight: FontWeight.bold
            ),
        iconTheme: IconThemeData(color: isLightTheme ? LightColors.APPBAR_ICONS_COLOR : DarkColors.APPBAR_ICONS_COLOR),
        backgroundColor: isLightTheme ? LightColors.APPBAR_COLOR : DarkColors.APPBAR_COLOR,
        centerTitle: true,
      );

  ///text theme
  static TextTheme getTextTheme({required bool isLightTheme,TextStyle? textStyle}) => TextTheme(
        labelLarge: MyFonts.BUTTON_TEXT_STYLE.copyWith(fontSize: MyFonts.BUTTON_TEXT_SIZE),
        bodyLarge: (textStyle ?? MyFonts.BODY_TEXT_STYLE).copyWith(fontWeight: FontWeight.w100, fontSize: MyFonts.BODY1_TEXT_SIZE, color: isLightTheme ? LightColors.TEXT_PRIMARY_COLOR : DarkColors.TEXT_PRIMARY_COLOR),
        bodyMedium: (textStyle ?? MyFonts.BODY_TEXT_STYLE).copyWith(fontSize: MyFonts.BODY2_TEXT_SIZE, color: isLightTheme ? LightColors.TEXT_PRIMARY_COLOR : DarkColors.TEXT_PRIMARY_COLOR),
        displayLarge: (textStyle ??  MyFonts.HEADLINE_TEXT_STYLE).copyWith(fontSize: MyFonts.HEADLINE1_TEXT_SIZE, fontWeight: FontWeight.bold, color: isLightTheme ? LightColors.TEXT_PRIMARY_COLOR : DarkColors.TEXT_PRIMARY_COLOR),
        displayMedium: (textStyle ?? MyFonts.HEADLINE_TEXT_STYLE).copyWith(fontSize: MyFonts.HEADLINE2_TEXT_SIZE, fontWeight: FontWeight.bold, color: isLightTheme ? LightColors.TEXT_PRIMARY_COLOR : DarkColors.TEXT_PRIMARY_COLOR),
        displaySmall: (textStyle ?? MyFonts.HEADLINE_TEXT_STYLE).copyWith(fontSize: MyFonts.HEADLINE3_TEXT_SIZE, fontWeight: FontWeight.bold, color: isLightTheme ? LightColors.TEXT_PRIMARY_COLOR : DarkColors.TEXT_PRIMARY_COLOR),
        headlineMedium: (textStyle ?? MyFonts.HEADLINE_TEXT_STYLE).copyWith(fontSize: MyFonts.HEADLINE4_TEXT_SIZE, fontWeight: FontWeight.bold, color: isLightTheme ? LightColors.TEXT_PRIMARY_COLOR : DarkColors.TEXT_PRIMARY_COLOR),
        headlineSmall: (textStyle ?? MyFonts.HEADLINE_TEXT_STYLE).copyWith(fontSize: MyFonts.HEADLINE5_TEXT_SIZE, fontWeight: FontWeight.bold, color: isLightTheme ? LightColors.TEXT_PRIMARY_COLOR : DarkColors.TEXT_PRIMARY_COLOR),
        titleLarge: (textStyle ?? MyFonts.HEADLINE_TEXT_STYLE).copyWith(fontSize: MyFonts.HEADLINE6_TEXT_SIZE, fontWeight: FontWeight.bold, color: isLightTheme ? LightColors.TEXT_WHITE_COLOR : DarkColors.TEXT_PRIMARY_COLOR),
        bodySmall: TextStyle(color: LightColors.TEXT_SECONDARY_COLOR , fontSize: MyFonts.CAPTION_TEXT_SIZE),
      );

  ///text theme
  static DialogTheme getDialogTheme({required bool isLightTheme,TextStyle? textStyle}) => DialogTheme(
    contentTextStyle: MyFonts.DIALOG_TEXT_STYLE.copyWith(color: isLightTheme ? LightColors.TEXT_PRIMARY_COLOR : DarkColors.TEXT_PRIMARY_COLOR, fontSize: MyFonts.DIALOG_TEXT_SIZE),
    titleTextStyle: MyFonts.DIALOG_TEXT_STYLE.copyWith(color: isLightTheme ? LightColors.PRIMARY_COLOR : DarkColors.PRIMARY_COLOR, fontSize: MyFonts.DIALOG_TEXT_SIZE)
  );

  //elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme({required bool isLightTheme}) => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              //side: BorderSide(color: Colors.teal, width: 2.0),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 13, horizontal: 15)),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return MyFonts.BUTTON_TEXT_STYLE.copyWith(fontWeight: FontWeight.bold, fontSize: MyFonts.BUTTON_TEXT_SIZE, color: isLightTheme ? LightColors.BUTTON_TEXT_COLOR : DarkColors.BUTTON_TEXT_COLOR);
              } else if (states.contains(MaterialState.disabled)) {
                return MyFonts.BUTTON_TEXT_STYLE.copyWith(fontSize: MyFonts.BUTTON_TEXT_SIZE, fontWeight: FontWeight.bold, color: isLightTheme ? LightColors.BUTTON_DISABLED_TEXT_COLOR : DarkColors.BUTTON_DISABLED_TEXT_COLOR);
              }
              return MyFonts.BUTTON_TEXT_STYLE.copyWith(fontSize: MyFonts.BUTTON_TEXT_SIZE, fontWeight: FontWeight.bold, color: isLightTheme ? LightColors.BUTTON_TEXT_COLOR : DarkColors.BUTTON_TEXT_COLOR); // Use the component's default.
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return isLightTheme ? LightColors.BUTTON_COLOR.withOpacity(0.5) : DarkColors.BUTTON_COLOR.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return isLightTheme ? LightColors.BUTTON_DISABLED_COLOR : DarkColors.BUTTON_DISABLED_COLOR;
              }
              return isLightTheme ? LightColors.BUTTON_COLOR : DarkColors.BUTTON_COLOR; // Use the component's default.
            },
          ),
        ),
      );

  // static ChipThemeData getChipTheme({required bool isLightTheme}) {
  //   return ChipThemeData(
  //     backgroundColor: isLightTheme ? LightColors.CHIP_BACKGROUND : DarkColors.CHIP_BACKGROUND,
  //     brightness: Brightness.light,
  //     labelStyle: getChipTextStyle(isLightTheme: isLightTheme),
  //     secondaryLabelStyle: getChipTextStyle(isLightTheme: isLightTheme),
  //     selectedColor: Colors.black,
  //     disabledColor: Colors.green,
  //     padding: EdgeInsets.all(5),
  //     secondarySelectedColor: Colors.purple,
  //   );
  // }

  // ///Chips text style
  // static TextStyle getChipTextStyle({required bool isLightTheme}) {
  //   return MyFonts.CHIP_TEXT_STYLE.copyWith(
  //     fontSize: MyFonts.CHIP_TEXT_SIZE,
  //     color: isLightTheme ? LightColors.CHIP_TEXT_COLOR : DarkColors.CHIP_TEXT_COLOR,
  //   );
  // }

}
