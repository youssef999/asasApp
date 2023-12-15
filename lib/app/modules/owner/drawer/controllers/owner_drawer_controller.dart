import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/modules/owner/home/controllers/owner_home_controller.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/translations/langs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class OwnerDrawerController extends GetxController {
  void changeLang(){
    if(PreferenceUtils.getCurrentLocale() == Locale("ar", "AR")){
      LangsController().updateLanguage(Locale("en", "UA"));
    }else{
      LangsController().updateLanguage(Locale("ar", "AR"));
    }
  }

  void logout(){
    OwnerSharedPref.setUserAsLogged(false);
    CustomLoading.showSuccessToast(msg: Strings.Signed_out_success.tr);
    Get.offNamed(Routes.OWNER_LOGIN);
  }


  void updateDrawer(){
    update(["login&register", "logout"]);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}
}
