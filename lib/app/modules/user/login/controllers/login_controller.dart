import 'package:asas/app/data/repository/auth_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/modules/user/home/controllers/home_controller.dart';
import 'package:asas/app/modules/user/my_drawer/controllers/my_drawer_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reactive_forms/reactive_forms.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../../translations/strings_enum.dart';


class LoginController extends GetxController {
  final form = FormGroup({
  'name': FormControl<String>(validators: [Validators.required]),
  'password': FormControl<String>(validators: [Validators.required, Validators.minLength(8)])
  });


  login() async {
    if(!form.valid){
      CustomLoading.showWrongToast(msg: Strings.Fill_all_fields.tr);
      return;
    }

    final isLogged = await AuthRepository().userLogin(form.rawValue['name']!.toString().trim(), form.rawValue['password']!.toString());

    if(isLogged){
      Get.find<HomeController>().closeDrawer();
      Get.find<MyDrawerController>().updateDrawer();
      Get.back();
    }
  }


  // onFacebookClicked() async{
  //    await signInWithFacebook();
  // }

  // Future<String> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   if (loginResult.status == LoginStatus.success) {
  //     // you are logged
  //
  //     Logger().e(loginResult.accessToken!.token);
  //
  //     // Map<String, int>? data = await PreferenceUtils.getCityCountry();
  //     Map<String, int>? data = PreferenceUtils.getCityCountry();
  //
  //     final isLogged = await AuthRepository().userLoginWithFacebookUrl(
  //         loginResult.accessToken!.token,
  //         'facebook',
  //         (data?['countryId'] ?? 0).toString(),
  //         (data?['cityId'] ?? 0).toString()
  //     );
  //
  //     if(isLogged){
  //       Get.find<HomeController>().closeDrawer();
  //       Get.find<MyDrawerController>().updateDrawer();
  //       Get.back();
  //     }
  //
  //
  //     // final AccessToken accessToken = loginResult.accessToken!;
  //     //
  //     // final userData = await FacebookAuth.instance.getUserData();
  //     //
  //     // Logger().e(userData);
  //
  //   } else {
  //     Logger().e(loginResult.status);
  //     Logger().e(loginResult.message);
  //   }
  //   return loginResult.accessToken!.token;
  // }

  @override
  void onInit() {
    super.onInit();
  }


  @override
  void onClose() {
    form.dispose();
  }
}
