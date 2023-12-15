import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/model/company_type.dart';
import 'package:asas/app/data/model/country.dart';
import 'package:asas/app/data/model/media.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../data/model/currency.dart';
import '../../../../translations/strings_enum.dart';

class OwnerOrgDataController extends GetxController {
  final form = FormGroup(
    {
      'name_corporation':
          FormControl<String>(validators: [Validators.required]),
      'name_corporation_ar':
          FormControl<String>(validators: [Validators.required]),
      'desception_ar': FormControl<String>(validators: [Validators.required]),
      'desception_en': FormControl<String>(validators: [Validators.required]),
      'lat': FormControl<String>(validators: [Validators.required]),
      'lng': FormControl<String>(validators: [Validators.required]),
      'logo': FormControl<String>(validators: [Validators.required]),
      'id_country': FormControl<String>(validators: [Validators.required]),
      'id_city': FormControl<String>(validators: [Validators.required]),
      'id_district': FormControl<String>(validators: [Validators.required]),
      'id_coins': FormControl<int>(validators: [Validators.required]),
      'id_company_type': FormControl<String>(validators: [Validators.required]),
    },
  );

  String? get logo => form.controls['logo']!.value == ""
      ? null
      : (form.controls['logo']!.value as String?);

  String? get lat => form.controls['lng']!.value as String?;
  String? get lng => form.controls['lat']!.value as String?;

  String? path;

  Company? company;

  List<CompanyType> companyTypeList = [];
  final token = OwnerSharedPref.getUserData()?.token ?? '';
  static const String BEARER = "Bearer ";
  List<Country> countryList = [];
  List<Country> cityList = [];
  List<Country> districtList = [];

  List<Currency> currencyList = [];

  getCurrency() async {
    CustomLoading.showLoading();
    final result = await PortalRepository().getCurrency();
    CustomLoading.cancelLoading();
    if (result != null) {
      currencyList = result;
    }
    update(['types']);
  }

  setCurrency(int id) {
    form.controls['id_coins']!.value = id;
    update(['types']);
  }

  getCurrencyIndex() {
    try {
      if (form.controls['id_coins']!.value == null) {
        return null;
      }
      int id = form.controls['id_coins']!.value as int;
      return currencyList.indexWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  updateData() async {
    Get.put(OwnerOrgDataController());
    if (!form.valid) {
      CustomLoading.showWrongToast(msg: Strings.All_fields_entered.tr);
      return;
    }
    form.controls['logo']!.value = path ?? "";
    CustomLoading.showLoading();
    Map<String, String> body = {};
    form.rawValue.forEach((key, value) => body[key] = value.toString());
    try {
      var res = await http.post(
          Uri.parse(
              'http://admin.asas-app.com/api/companydata_update/id/${company!.id!}'),
          //  headers:
          headers: {
            'Authorization': BEARER + token,
            'Host': "admin.asas-app.com",
          },
          body: {
            "desception_en": body["desception_en"]!,
            "desception_ar": body["desception_ar"]!,
            "id_country": body["id_country"]!,
            "id_city": body["id_city"]!,
            "id_district": body["id_district"]!,
            "id_coins": body["id_coins"]!,
            "lng": body["lng"]!,
            "lat": body["lat"]!,
            "id_company_type": body["id_company_type"]!,
            "name_corporation": body["name_corporation"]!,
            "name_corporation_ar": body["name_corporation_ar"]!
          });

      if (res.statusCode == 200) {
        CustomLoading.cancelLoading();
        CustomLoading.showSuccessToast(msg: Strings.Added_successfully.tr);
      } else {
        CustomLoading.showLoading();
      }
    } catch (e) {
      print(" ERROR ::=====$e");
    }
  }

  // updateData2() async {
  //   if (!form.valid) {
  //     CustomLoading.showWrongToast(msg: Strings.All_fields_entered.tr);
  //     return;
  //   }

  //   form.controls['logo']!.value = path ?? "";

  //   CustomLoading.showLoading();
  //   Map<String, String> body = {};

  //   form.rawValue.forEach((key, value) => body[key] = value.toString());
  //   Logger().i(body);
  //   print("ertt ${body['id_district']}");
  //   final result = await PortalRepository().updateCompany(body, company!.id!);

  //   CustomLoading.cancelLoading();
  //   if (result) {
  //     Get.back();
  //   }
  // }

  getCompanyData() async {
    CustomLoading.showLoading();
    final result = await PortalRepository().getMyCompany();
    
    CustomLoading.cancelLoading();
    company = result;
    update(['images']);
    await getTypes();
    setData();
  }

  setData() async {
    if (company == null) {
      return;
    }

    form.controls['name_corporation']!.value = company!.owner!.nameCorporation;
    form.controls['name_corporation_ar']!.value =
        company!.owner!.nameCorporationAr;

    if (company!.idCoins != "-" && company!.idCoins != null) {
      form.controls['id_coins']!.value = int.parse(company!.idCoins!);
    }

    if (company!.desceptionAr != '-') {
      form.controls['desception_ar']!.value = company!.desceptionAr;
    }

    if (company!.desceptionEn != '-') {
      form.controls['desception_en']!.value = company!.desceptionEn;
    }

    if (company!.logo != '-') {
      form.controls['logo']!.value = company!.logo;
      update(['logo']);
    }

    if (company!.idCompanyType != '-') {
      form.controls['id_company_type']!.value = company!.idCompanyType;
    }

    form.controls['id_country']!.value = company!.idCountry;
    await getCity(int.parse(company!.idCountry!));
    form.controls['id_city']!.value = company!.idCity;
    await getDistrict(int.parse(company!.idDistrict!));
    form.controls['id_district']!.value = company!.idDistrict;
    if (company!.lat != '-') {
      form.controls['lat']!.value = company!.lat;
    }

    if (company!.lng != '-') {
      form.controls['lng']!.value = company!.lng;
    }
  }

  setCompanyType(int id) {
    form.controls['id_company_type']!.value = id.toString();
    update(['types']);
  }

  setCountryType(int id) {
    form.controls['id_country']!.value = id.toString();
    update(['types']);
    getCity(id);
  }

  setCityType(int id) async {
    form.controls['id_city']!.value = id.toString();
    await getDistrict(id);
    update(['types']);
  }

  setDistrictType(int id) {
    form.controls['id_district']!.value = id.toString();
    update(['types']);
  }

  getCountryIndex() {
    if (form.controls['id_country']!.value == null) {
      return null;
    }
    final int id = int.parse(form.controls['id_country']!.value as String);
    final int index = countryList.indexWhere((element) => element.id == id);
    return index > -1 ? index : null;
  }

  getCityIndex() {
    if (form.controls['id_city']!.value == null) {
      return null;
    }
    final int id = int.parse(form.controls['id_city']!.value as String);
    final int index = cityList.indexWhere((element) => element.id == id);
    return index > -1 ? index : null;
  }

  getDistrictIndex() {
    if (form.controls['id_district']!.value == null) {
      return null;
    }
    final int id = int.parse(form.controls['id_district']!.value as String);
    final int index = districtList.indexWhere((element) => element.id == id);
    return index > -1 ? index : null;
  }

  getCompanyIndex() {
    if (form.controls['id_company_type']!.value == null) {
      return null;
    }
    final int id = int.parse(form.controls['id_company_type']!.value as String);
    final int index = companyTypeList.indexWhere((element) => element.id == id);
    return index > -1 ? index : null;
  }

  showCity() {
    return form.controls['id_country']!.value != null;
  }

  showDistrict() {
    return form.controls['id_city']!.value != null;
  }

  addImages() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      CustomLoading.showLoading();
      final result = await PortalRepository().addMedia({
        "table_name": 'company',
        "media": image.path,
      }, company!.id!);
      CustomLoading.cancelLoading();

      if (result) {
        company!.media!.add(Media(
          name: image.name,
          path: image.path,
        ));
        update(['images']);
      }
    }
  }

  addLogo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      path = image.path;
      form.controls['logo']!.value = path;
      update(['logo']);
    }
  }

  deleteImages(int index, int id) async {
    Get.back();
    CustomLoading.showLoading();
    final result = await PortalRepository().deleteMedia(id);
    CustomLoading.cancelLoading();
    if (result) {
      company!.media!.removeAt(index);
      update(['images']);
    }
  }

  getLocationData() async {
    final value =
        await Get.toNamed(Routes.OWNER_ADD_LOCATION, arguments: [lat, lng]);

    if (value != null) {
      form.controls['lat']!.value = value['latitude'];
      form.controls['lng']!.value = value['longitude'];
      CustomLoading.showSuccessToast(msg: "تم تحديد الموقع");
    }
  }

  getTypes() async {
    CustomLoading.showLoading();
    final companyTypes = await PortalRepository().getCompanyTypes();
    final countries = await UserRepository().getCountries();
    CustomLoading.cancelLoading();

    if (companyTypes != null) {
      companyTypeList = companyTypes;
    }

    if (countries != null) {
      countryList = countries;
    }
    update(['types']);
  }

  getCity(int id) async {
    CustomLoading.showLoading();
    final city = await UserRepository().getCity(id);
    CustomLoading.cancelLoading();

    if (city != null) {
      cityList = city;
    }
    update(['types']);
  }

  getDistrict(int id) async {
    CustomLoading.showLoading();
    final district = await UserRepository().getDistrict(id);
    CustomLoading.cancelLoading();

    if (district != null) {
      districtList = district;
    }

    update(['types']);
  }

  getData() async {
    await getCurrency();
    await getCompanyData();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onClose() {
    form.dispose();
  }
}
