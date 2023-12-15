import 'package:asas/app/data/model/country.dart';
import 'package:asas/app/data/repository/auth_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/modules/user/home/controllers/home_controller.dart';
import 'package:asas/app/modules/user/my_drawer/controllers/my_drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../theme/lightColors.dart';
import '../../../../translations/strings_enum.dart';

class SignupController extends GetxController {

  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl<String>(validators: [Validators.required]),
    'id_city': FormControl<int>(validators: [Validators.required]),
    'id_country': FormControl<int>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
    're_password': FormControl<String>()
  },
      validators: [Validators.mustMatch('password', 're_password'),]
  );

  late TextEditingController phoneController ;

  List<Country> countryList = [];
  List<Country> cityList = [];
  bool checkbox = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
    return Colors.blue;
    }
    return LightColors.ACCENT_COLOR;
  }

  void checkboxChange(bool val){
    checkbox = val;
    update(['Checkbox']);
  }

  void launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }



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

  signup() async {
    if(!form.valid){
      CustomLoading.showWrongToast(msg: Strings.Fill_all_fields.tr);
      return;
    }

    if(!checkbox){
      CustomLoading.showWrongToast(msg: "لم توافق على الشروط");
      return;
    }

    final isLogged = await AuthRepository().userSignup(
        form.rawValue['name']!.toString().trim(),
        form.rawValue['phone']!.toString().trim(),
        form.rawValue['password']!.toString().trim(),
        form.rawValue['id_city']!.toString().trim(),
        form.rawValue['id_country']!.toString().trim(),
    );

    if(isLogged){
      Get.find<HomeController>().closeDrawer();
      Get.find<MyDrawerController>().updateDrawer();
      Get.back();
    }

    //Get.toNamed(Routes.OWNER_OTP)
  }



  @override
  void onInit() {
    super.onInit();
    getCounty();

    phoneController = TextEditingController();

    phoneController.addListener(() {
      form.controls['phone']!.value = phoneController.text;
    });

  }

  @override
  void onClose() {
    form.dispose();
  }
}
