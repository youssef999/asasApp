import 'dart:convert';

import 'package:asas/app/data/model/curriculum_type.dart';
import 'package:asas/app/data/model/discount.dart';
import 'package:asas/app/data/model/media.dart';
import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/model/program_type.dart';
import 'package:asas/app/data/model/service.dart';
import 'package:asas/app/data/model/time_type.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../data/model/currency.dart';
import '../../../../translations/strings_enum.dart';

class OwnerEditProgramController extends GetxController {
  final token = OwnerSharedPref.getUserData()?.token ?? '';
  static const String BEARER = "Bearer ";
  final form = FormGroup({
    'name_en': FormControl<String>(validators: [Validators.required]),
    'name_ar': FormControl<String>(
      validators: [Validators.required],
    ),
    'description_en': FormControl<String>(
      validators: [Validators.required],
    ),
    'description_ar': FormControl<String>(
      validators: [Validators.required],
    ),
    'id_timeType': FormControl<String>(
      validators: [Validators.required],
    ),
    'id_typeProgram': FormControl<String>(validators: [Validators.required]),
    'price_main': FormControl<String>(
      validators: [Validators.required],
    ),
    'age_conditions_en': FormControl<String>(),
    'age_conditions_ar': FormControl<String>(),
    'other_conditions_en': FormControl<String>(),
    'other_conditions_ar': FormControl<String>(),
    'price_note_ar': FormControl<String>(),
    'price_note_en': FormControl<String>(),
    'sort': FormControl<String>(),
    'other_fute': FormControl<String>(),
    'url_viedo': FormControl<String>(),
    'id_curriculum_type': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  late int programId;
  Program? program;

  List<Discount> discountList = [];
  List<Service> serviceList = [];

  List<Media> mediaList = [];

  List<TimeType> timeTypeList = [];
  List<ProgramType> programTypeList = [];
  List<CurriculumType> curriculumTypeList = [];

  updateProgram() async {
    if (!form.valid) {
      CustomLoading.showWrongToast(msg: Strings.All_fields_entered.tr);
      return;
    }

    Map<String, String> body = {};
    form.rawValue.forEach((key, value) => body[key] = (value ?? '').toString());
    CustomLoading.showLoading(msg: Strings.Data_being_updated.tr);
    try {
      var res = await http.post(
          Uri.parse(
              'http://admin.asas-app.com/api/programs/update/id/${programId}}'),
          //  headers:
          headers: {
            'Authorization': BEARER + token,
            'Host': "admin.asas-app.com",
          },
          body: {
            'name_en': body['name_en'],
            'name_ar': body['name_ar'],
            'description_en': body['description_en'],
            'description_ar': body['description_ar'],
            'id_timeType': body['id_timeType'],
            'id_typeProgram': body['id_typeProgram'],
            'price_main': body['price_main'],
            'age_conditions_en': body['age_conditions_en'],
            'age_conditions_ar': body['age_conditions_ar'],
            'other_conditions_en': body['other_conditions_en'],
            'other_conditions_ar': body['other_conditions_ar'],
            'price_note_ar': body['price_note_ar'],
            'price_note_en': body['price_note_en'],
            'other_fute': body['other_fute'],
            'sort': body['sort'],
            'url_viedo': body['url_viedo'],
            'id_curriculum_type': body['id_curriculum_type']
          });

      if (res.statusCode == 200) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? res.body.replaceAll('_ar', '_').replaceAll("_en", '_ar')
            : res.body);

        if (responseData != null && responseData['status']) {
          Logger().e(responseData['data']);
          final Program programResponse =
              Program.fromJson(responseData['data']);

          CustomLoading.cancelLoading();
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return programResponse;
        }

        Get.back(result: res);
      } else if (res.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (res.statusCode >= 400 && res.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? res.body.replaceAll('_ar', '_').replaceAll("_en", '_ar')
            : res.body);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      print(" ERROR ::=====$e");
    }
    print("backyo ${body.toString()}");
    CustomLoading.cancelLoading();
  }

  setProgramType(int id) {
    form.controls['id_typeProgram']!.value = id.toString();
    update(['types']);
  }

  getProgramInitialIndex() {
    int id = int.parse(program?.idTypeProgram ?? '0');
    return programTypeList.indexWhere((element) => element.id == id);
  }

  setTimeType(int id) {
    form.controls['id_timeType']!.value = id.toString();
    update(['types']);
  }

  getTimeInitialIndex() {
    int id = int.parse(program?.idTimeType ?? '0');
    return timeTypeList.indexWhere((element) => element.id == id);
  }

  setCurriculumType(int id) {
    form.controls['id_curriculum_type']!.value = id.toString();
    update(['types']);
  }

  getCurriculumInitialIndex() {
    try {
      int id = int.parse(program?.idCurriculumType ?? '0');
      return curriculumTypeList.indexWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }

  addImages() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      CustomLoading.showLoading();
      final result = await PortalRepository().addMedia({
        "table_name": 'programs',
        "media": image.path,
      }, programId);
      CustomLoading.cancelLoading();

      if (result) {
        mediaList.add(Media(
          name: image.name,
          path: image.path,
        ));
        update(['images']);
      }
    }
  }

  deleteImages(int index, int id) async {
    Get.back();
    CustomLoading.showLoading();
    final result = await PortalRepository().deleteMedia(id);
    CustomLoading.cancelLoading();
    if (result) {
      mediaList.removeAt(index);
      update(['images']);
    }
  }

  deleteDiscount(int index, int id) async {
    Get.back();
    CustomLoading.showLoading();
    final result = await PortalRepository().deleteDiscount(id);
    CustomLoading.cancelLoading();
    if (result) {
      discountList.removeAt(index);
      update(['discount']);
    }
  }

  addDiscount(Discount discount) async {
    CustomLoading.showLoading();
    final result = await PortalRepository().addDiscount({
      "price_rate_discount": discount.priceRateDiscount!,
      "start_discount": discount.startDiscount!,
      "end_discount": discount.endDiscount!,
    }, programId);
    CustomLoading.cancelLoading();

    if (result) {
      discountList.add(discount);
      update(['discount']);
    }
    Get.back();
  }

  addService(Service service) async {
    CustomLoading.showLoading();
    final result = await PortalRepository().addService({
      "price": service.price!,
      "service_ar": service.serviceAr!,
      "service_en": service.serviceEn!,
    }, programId);
    CustomLoading.cancelLoading();

    if (result) {
      serviceList.add(service);
      update(['service']);
    }

    Get.back();
  }

  deleteService(int index, int id) async {
    Get.back();
    CustomLoading.showLoading();
    final result = await PortalRepository().deleteService(id);
    CustomLoading.cancelLoading();
    if (result) {
      serviceList.removeAt(index);
      update(['service']);
    }
  }

  setDataToView(Program program) {
    form.controls['price_main']!.value = (program.priceMain!).toString();

    form.controls['sort']!.value = program.sort;
    form.controls['name_en']!.value = program.nameEn;
    form.controls['name_ar']!.value = program.nameAr;
    form.controls['description_en']!.value = program.descriptionEn;
    form.controls['description_ar']!.value = program.descriptionAr;
    form.controls['id_timeType']!.value = program.idTimeType;
    form.controls['id_typeProgram']!.value = program.idTypeProgram;
    form.controls['age_conditions_en']!.value =
        program.ageConditionsEn == "null" ? '' : program.ageConditionsEn;
    form.controls['age_conditions_ar']!.value =
        program.ageConditionsAr == "null" ? '' : program.ageConditionsAr;
    form.controls['other_conditions_en']!.value =
        program.otherConditionsEn == "null" ? '' : program.otherConditionsEn;
    form.controls['other_conditions_ar']!.value =
        program.otherConditionsAr == "null" ? '' : program.otherConditionsAr;
    form.controls['price_note_ar']!.value =
        program.priceNoteAr == "null" ? '' : program.priceNoteAr;
    form.controls['price_note_en']!.value =
        program.priceNoteEn == "null" ? '' : program.priceNoteEn;
    form.controls['other_fute']!.value =
        program.otherFute == "null" ? '' : program.otherFute;
    form.controls['url_viedo']!.value =
        program.urlViedo == "null" ? '' : program.urlViedo;
    form.controls['id_curriculum_type']!.value = program.idCurriculumType;
    update(['main']);
  }

  getTypesData() async {
    final times = await PortalRepository().getTimeTypes();
    final programs = await PortalRepository().getProgramTypes();
    final curriculums = await PortalRepository().getCurriculum();
    print('typee $times');
    print('typee $programs');
    print('typee $curriculums');

    if (times != null) {
      timeTypeList = times;
    }
    if (programs != null) {
      programTypeList = programs;
    }
    if (curriculums != null) {
      curriculumTypeList = curriculums;
    }

    update(['types']);
  }

  getProgramById(int id) async {
    CustomLoading.showLoading();
    try {
      print('prog is pp2 $id');
      final data = await PortalRepository().getProgramComById(id);
      print('prog is pp3 ${data?.toJson()}');
      if (data != null) {
        program = data;
        discountList = program!.discount!;
        // update(['discount']);

        serviceList = program!.service!;
        // update(['service']);
        mediaList = program!.media!;
        // update(['image']);
        setDataToView(program!);

        await getTypesData();
      }
    } catch (e) {
      print('the err2 is $e');
    }
    CustomLoading.cancelLoading();
  }

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

  @override
  void onInit() {
    programId = Get.arguments[0];
    getProgramById(programId);
    getCurrency();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    form.dispose();
  }
}
