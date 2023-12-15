import 'package:asas/app/data/network/auth_service.dart';
import 'package:asas/app/helpers/fcm_helper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'app/data/network/portal_service.dart';
import 'app/data/network/user_service.dart';
import 'app/helpers/sharedPref.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/themes.dart';
import 'app/translations/localization_service.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceUtils.init();

  await FcmHelper.initFcm();
 // await Firebase.initializeApp();

  Logger.root.level = Level.ALL ;
  Logger.root.onRecord.listen((event) {
    print('${event.level.name} ${event.message}');
  });

  runApp(
    GetMaterialApp(
      onInit: () {
        PortalService.create();
        AuthService.create();
        UserService.create();
      },
      onDispose: () {
        PortalService.create().client.dispose();
        AuthService.create().client.dispose();
        UserService.create().client.dispose();
      },
      title: "تطبيق أساس",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, widget) {
        Function botToast = BotToastInit();
        Widget mWidget = botToast(context,widget);
        return MediaQuery(
          //Setting font does not change with system font size
          data: MediaQuery.of(context).copyWith
          (textScaleFactor: 1.0),
          child: mWidget,
        );
      },
      debugShowCheckedModeBanner: false,
      navigatorObservers: [BotToastNavigatorObserver()],
      locale: PreferenceUtils.getCurrentLocale(),
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.light,
    ),
  );
}
