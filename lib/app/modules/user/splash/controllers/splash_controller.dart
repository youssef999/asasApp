import 'dart:async';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  loadApp() async {


    final result = PreferenceUtils.getUserIsLogged();


    Future.delayed(Duration(seconds: 3), () {
      if(result){
        //SharedPref.removeCityCountry();
        Get.offAllNamed(Routes.BASE_DRAWER,);
      }else{
        Map<String, int>? data =  PreferenceUtils.getCityCountry();
        if(data != null && data.containsKey("cityId")){
          Get.offAllNamed(Routes.BASE_DRAWER,);
          // Get.offNamed(Routes.BASE_DRAWER,);
          // return Future.value(null);
          // await getCity(data['countryId']!);
          // form.controls['id_city']!.value = data['cityId'] ;
          // form.controls['id_country']!.value = data['countryId'] ;
        }else{
          Get.offNamed(Routes.USER_INTRO);
        }
      }
    });
  }

  @override
  void onClose() {}
}
