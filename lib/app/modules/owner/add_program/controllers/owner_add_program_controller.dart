import 'dart:convert';

import 'package:asas/app/data/model/curriculum_type.dart';
import 'package:asas/app/data/model/discount.dart';
import 'package:asas/app/data/model/image.dart';
import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/model/program_type.dart';
import 'package:asas/app/data/model/service.dart';
import 'package:asas/app/data/model/time_type.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';

class OwnerAddProgramController extends GetxController {
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
    'id_curriculum_type': FormControl<String>(
      validators: [Validators.required],
    ),
    'sort': FormControl<String>(
      validators: [Validators.required],
    ),
    'age_conditions_en': FormControl<String>(),
    'age_conditions_ar': FormControl<String>(),
    'other_conditions_en': FormControl<String>(),
    'other_conditions_ar': FormControl<String>(),
    'price_note_ar': FormControl<String>(),
    'price_note_en': FormControl<String>(),
    'other_fute': FormControl<String>(),
    'url_viedo': FormControl<String>(),
    'discount': FormControl<String>(),
    'service_more': FormControl<String>(),
  });

  bool checkbox = false;

  List<Program> programList = [];

  List<Discount> discountList = [];
  List<Service> serviceList = [];

  List<ImageModel> imageModelList = [];

  List<TimeType> timeTypeList = [];
  List<ProgramType> programTypeList = [];
  List<CurriculumType> curriculumTypeList = [];





  addProgram() async {
    form.controls['discount']!.value = getDiscountListAsStringList();
    form.controls['service_more']!.value = getServiceListAsStringList();

    if (!form.valid) {
      CustomLoading.showWrongToast(msg: Strings.All_fields_entered.tr);
      return;
    }

    Logger().e(form.rawValue);

    Map<String, String> body = {};
    form.rawValue.forEach((key, value) => body[key] = value.toString());
    // Create a multipart request
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://admin.asas-app.com/api/programs/save'));

    // Set headers
    request.headers['Authorization'] = BEARER + token;
    request.headers['Host'] = "admin.asas-app.com";


    // Add form fields
    request.fields["name_en"] = body['name_en']!;
    request.fields["name_ar"] = body['name_ar']!;
    request.fields["description_en"] = body['description_en']!;
    request.fields["description_ar"] = body['description_ar']!;
    request.fields["id_timeType"] = body['id_timeType']!;
    request.fields["id_typeProgram"] = body['id_typeProgram']!;
    request.fields["price_main"] = body['price_main']!;
    request.fields["age_conditions_en"] = body['age_conditions_en']!;
    request.fields["age_conditions_ar"] = body['age_conditions_ar']!;
    request.fields["other_conditions_en"] = body['other_conditions_en']!;
    request.fields["other_conditions_ar"] = body['other_conditions_ar']!;
    request.fields["price_note_ar"] = body['price_note_ar']!;
    request.fields["price_note_en"] = body['price_note_en']!;
    request.fields["other_fute"] = body['other_fute']!;
    request.fields["sort"] = body['sort']!;
    request.fields["url_viedo"] = body['url_viedo']!;
    request.fields["id_curriculum_type"] = body['id_curriculum_type']!;
    request.fields["discount"] = body['discount']!;
    request.fields["service_more"] = body['service_more']!;
    final List<String> images = [];
    if (imageModelList.isNotEmpty) {
      for (var item in imageModelList) {
        images.add(item.path!);
        var file = await http.MultipartFile.fromPath('image', item.path!);
        request.files.add(file);
        print('butt ${file.filename}');
      }
    }
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.body.replaceAll('_ar', '_').replaceAll('_en', '_ar')
            : response.body);

        if (responseData != null && responseData['status']) {
          Logger().e(responseData['data']);
          final Program programResponse =
              Program.fromJson(responseData['data']);

          CustomLoading.cancelLoading();
          CustomLoading.showSuccessToast(msg: responseData['message_ar']);
          return programResponse;
        }
        Get.back(result: response);
      } else if (response.statusCode == 401) {
        CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        final responseData = json.decode(Get.locale.toString() == 'en_US'
            ? response.body.replaceAll('_ar', '_').replaceAll('_en', '_ar')
            : response.body);
        CustomLoading.showWrongToast(msg: responseData['message_ar']);
      } else {
        CustomLoading.showWrongToast(msg: Strings.ERROR_UNKNOWN.tr);
      }
    } catch (e) {
      print(" ERROR ::=====$e");
      Logger().w(e);
    }

    CustomLoading.cancelLoading();
  }

  setProgramType(int id) {
    form.controls['id_typeProgram']!.value = id.toString();
    update(['types']);
  }

  setTimeType(int id) {
    form.controls['id_timeType']!.value = id.toString();
    update(['types']);
  }

  setCurriculumType(int id) {
    form.controls['id_curriculum_type']!.value = id.toString();
    update(['types']);
  }

  String getDiscountListAsStringList() {
    String data = "[";
    int index = 1;
    for (final item in discountList) {
      Map<String, dynamic> map = item.toJson();
      int mapIndex = 1;
      data += '{';
      map.forEach((key, value) {
        data += '"$key":"$value"';
        if (mapIndex != map.entries.length) data += ',';
        mapIndex++;
      });
      data += '}';
      if (index != discountList.length) data += ',';
      index++;
    }
    data += ']';
    print("dis is $data");
    return data;
  }

  String getServiceListAsStringList() {
    String data = "[";
    int index = 1;
    for (final item in serviceList) {
      Map<String, dynamic> map = item.toJson();
      int mapIndex = 1;
      data += '{';
      map.forEach((key, value) {
        data += '"$key":"$value"';
        if (mapIndex != map.entries.length) data += ',';
        mapIndex++;
      });
      data += '}';
      if (index != serviceList.length) data += ',';
      index++;
    }
    data += ']';
    return data;
  }

  addImages() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? images = await _picker.pickMultiImage(imageQuality: 50);
    if (images != null) {
      if (images.length > 10) {
        images = images.sublist(0, 9);
        CustomLoading.showInfoToast(msg: Strings.You_cannot_10_photos.tr);
      }

      for (var item in images) {
        imageModelList
            .add(ImageModel(name: item.name, path: item.path, size: "0"));
      }
      update(['images']);
    }
  }

  deleteImages(int index) async {
    imageModelList.removeAt(index);
    update(['images']);
  }

  deleteDiscount(int index) {
    discountList.removeAt(index);
    update(['discount']);
  }

  addDiscount(Discount discount) {
    discountList.add(discount);
    update(['discount']);
    Get.back();
  }

  addService(Service service) {
    serviceList.add(service);
    update(['service']);
    Get.back();
  }

  deleteService(int index) {
    serviceList.removeAt(index);
    update(['service']);
  }

  Color getColor(Set<MaterialState> states) {
    return LightColors.ACCENT_COLOR;
  }

  void checkboxChange(bool val) {
    checkbox = val;
    if (val) {
      if (programList.isEmpty) {
        CustomLoading.showWrongToast(msg: Strings.There_are_n_programs.tr);
        checkbox = false;
        return;
      }
      DialogUtils.showCopyProgramDialog(Get.context!, programList,
          onDone: (id) async {
        CustomLoading.showLoading();
        final data = await PortalRepository().copyProgram(id);
        CustomLoading.cancelLoading();

        if (data != null) {
          Get.back();
          Get.back(result: data);
        }
      });
    }
    update(['Checkbox']);
  }

  getTypesData() async {
    CustomLoading.showLoading();
    final times = await PortalRepository().getTimeTypes();
    final programs = await PortalRepository().getProgramTypes();
    final curriculums = await PortalRepository().getCurriculum();
    CustomLoading.cancelLoading();
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

  @override
  void onInit() {
    programList = Get.arguments[0];
    getTypesData();
    super.onInit();
  }

  @override
  void onClose() {
    form.dispose();
  }
}
