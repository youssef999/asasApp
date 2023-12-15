import 'dart:async';

import 'package:asas/app/data/model/country.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';

class UserIntroController extends GetxController {

  final form = FormGroup({
    'id_city': FormControl<int>(validators: [Validators.required]),
    'id_country': FormControl<int>(validators: [Validators.required])
  });

  List<Country> countryList = [];
  List<Country> cityList = [];


  setCityType(int id){
    form.controls['id_city']!.value = id;
    update();
  }

  setCountryType(int id) {
    form.controls['id_country']!.value = id;
    update();
    getCity(id);
  }

  showCity(){
    return form.controls['id_country']!.value != null;
  }


  getCountryIndex(){
    if(form.controls['id_country']!.value == null){
      return null;
    }
    int id = form.controls['id_country']!.value as int;
    return countryList.indexWhere((element) => element.id == id);
  }

  getCityIndex(){
    if(form.controls['id_city']!.value == null){
      return null;
    }
    int id = form.controls['id_city']!.value as int;
    final index = cityList.indexWhere((element) => element.id == id);
    return index > -1 ? index : 0;
  }

  getCounty() async {
    //final userLogged = PreferenceUtils.getUserIsLogged();

    // Map<String, int>? data;
    //
    // if(userLogged){
    //   final _data = PreferenceUtils.getUserData();
    //   data = {"cityId": int.parse(_data!.idCity!),"countryId": int.parse(_data.idCountry!)};
    // }else{
    //   data = await PreferenceUtils.getCityCountry();
    // }
    // Logger().e(data);



    CustomLoading.showLoading();
    final countries = await UserRepository().getCountries();
    CustomLoading.cancelLoading();

    if(countries != null){
      countryList = countries;
      update();
    }else{
      Future.delayed(Duration(seconds: 5), () => getCounty(),);
    }

  }


  getCity(int id) async {
    Future.delayed(Duration(milliseconds: 250), () async {
      CustomLoading.showLoading();
      final city = await UserRepository().getCity(id);
      CustomLoading.cancelLoading();

      if(city != null){
        cityList = city;
      }
      update();
    },);

  }

  login() async {
    if(!form.valid){
      CustomLoading.showWrongToast(msg: Strings.Enter_your_country_and_city.tr);
      return ;
    }
    // await PreferenceUtils.setCityCountry(
    //     (form.controls['id_city']!.value as int), (form.controls['id_country']!.value as int)
    // );

    await PreferenceUtils.setCityCountry(
        (form.controls['id_city']!.value as int), (form.controls['id_country']!.value as int)
    );
    Get.offAllNamed(Routes.BASE_DRAWER,);
  }


  @override
  void onInit() {
    getCounty();
    super.onInit();
  }



  @override
  void onClose() {
    form.dispose();
  }

}
