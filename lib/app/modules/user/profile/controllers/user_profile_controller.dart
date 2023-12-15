import 'package:asas/app/data/model/country.dart';
import 'package:asas/app/data/model/currency.dart';
import 'package:asas/app/data/model/user.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';

class UserProfileController extends GetxController {
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl<String>(validators: [Validators.required]),
    'id_city': FormControl<int>(validators: [Validators.required]),
    'id_country': FormControl<int>(validators: [Validators.required]),
    'id_coins': FormControl<int>(validators: [Validators.required]),
  },);

  List<Country> countryList = [];
  List<Country> cityList = [];
  List<Currency> currencyList = [];

  User? user;

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
    try{
      if(form.controls['id_country']!.value == null){
        return null;
      }
      int id = form.controls['id_country']!.value as int;

      final index = countryList.indexWhere((element) => element.id == id);
      if(index < 0){
        return null;
      }else{
        return index;
      }
    }catch(e){
      return null;
    }

  }

  getCityIndex(){
    try{
      if(form.controls['id_city']!.value == null){
        return null;
      }
      int id = form.controls['id_city']!.value as int;
      final index = cityList.indexWhere((element) => element.id == id);
      return index > -1 ? index : null;
    }catch(e){
      return null;
    }

  }


  getCounty() async {
    CustomLoading.showLoading();
    final countries = await UserRepository().getCountries();
    CustomLoading.cancelLoading();
    if(countries != null){
      countryList = countries;
      if(form.controls['id_country']!.value != null){
        getCity(form.controls['id_country']!.value as int);
      }
      update();
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

  getCurrency() async {
    CustomLoading.showLoading();
    final result = await PortalRepository().getCurrency();
    CustomLoading.cancelLoading();
    if(result != null){
      currencyList = result;
    }
    update();
  }


  setCurrency(int id){
    form.controls['id_coins']!.value = id;
    update();
  }

  getCurrencyIndex(){
    try{
      if(form.controls['id_coins']!.value == null){
        return null;
      }
      int id = form.controls['id_coins']!.value as int;
      return currencyList.indexWhere((element) => element.id == id);
    }catch(e){
      return null;
    }

  }

  getProfile() async {
    final result = await UserRepository().getProfile();
    if(result != null){
      user = result;
      form.controls['name']!.value = user!.name;
      if(user?.phone != "-") {
        form.controls['phone']!.value = user!.phone;
      }
      if(user?.idCity != null) {
        form.controls['id_city']!.value = int.parse(user!.idCity!);
      }
      if(user?.idCountry != null) {
        form.controls['id_country']!.value = int.parse(user!.idCountry!);
      }
      if(user?.id_coins != null) {
        form.controls['id_coins']!.value = user!.id_coins!;
      }
      update();
    }
  }


  updateProfile() async {
    if(form.valid){
      await UserRepository().updateProfile(
          form.controls['name']!.value as String ,
          form.controls['phone']!.value as String ,
          form.controls['id_country']!.value as int,
          form.controls['id_city']!.value as int,
          form.controls['id_coins']!.value as int,
      );
    }else{
      CustomLoading.showWrongToast(msg:Strings.Fill_all_fields.tr);
    }
  }



  getData() async {
    await getProfile();
    await getCounty();
    await getCurrency();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    form.dispose();
  }

}
