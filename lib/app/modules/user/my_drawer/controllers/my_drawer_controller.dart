import 'dart:ui';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/modules/user/home/controllers/home_controller.dart';
import 'package:asas/app/translations/langs_controller.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class MyDrawerController extends GetxController {

  void changeLang(){
    if(PreferenceUtils.getCurrentLocale() == Locale("ar", "AR")){
      LangsController().updateLanguage(Locale("en", "UA"));
    }else{
      LangsController().updateLanguage(Locale("ar", "AR"));
    }
  }


  void logout(){
    PreferenceUtils.setUserAsLogged(false);
    CustomLoading.showSuccessToast(msg: Strings.Signed_out_success.tr);
    Get.find<HomeController>().closeDrawer();
    update(["login&register", "logout"]);
  }


  void updateDrawer(){
    update(["login&register", "logout"]);
  }

  @override
  void onInit() {
    super.onInit();
  }

}
