import 'package:asas/app/data/model/curriculum_type.dart';
import 'package:asas/app/data/model/image.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';

class UserAddStudentController extends GetxController  with GetSingleTickerProviderStateMixin{
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'name_father': FormControl<String>(validators: [Validators.required],),
    'date_of_birth': FormControl<String>(validators: [Validators.required],),
    'gender': FormControl<String>(validators: [Validators.required],),
    'nationality': FormControl<String>(),
    'country_of_residence': FormControl<String>(),
    'id_curriculum_type': FormControl<String>(),
    'current_academic_certificates': FormControl<String>(),
    'sports_of_interest': FormControl<String>(),
    'artistic_activities_of_interest': FormControl<String>(),
    'religious_activities_of_interest': FormControl<String>(),
  });

  late TabController tabBarController;

  List<CurriculumType> curriculumTypeList = [];

  String? get dateOfBirth => form.controls['date_of_birth']!.value as String?;
  String? get gender => form.controls['gender']!.value as String?;


  List<ImageModel> imageModelList = [];


  addStudent() async {

    if(!form.valid){
      CustomLoading.showWrongToast(msg: Strings.Basic_data_must_be_entered.tr);
      return;
    }



    final List<String> images = [];

    if(imageModelList.isNotEmpty){
      for(var item in imageModelList){
        images.add(item.path!);
      }
    }


    Map<String, String> body = {};
    form.rawValue.forEach((key, value) => body[key] = value.toString());

    CustomLoading.showLoading(msg: Strings.Adding_a_student.tr);
    final data = await UserRepository().addStudents(body, images);
    CustomLoading.cancelLoading();


    if(data != null){
      Get.back(result: data);
    }

  }

  setDate(date){
    //2022/04/01
    String from = DateFormat('yyyy/MM/dd').format(date);
    form.controls['date_of_birth']!.value = from;
    update(['date_of_birth']);
  }

  setGender(value){
    //2022/04/01
    form.controls['gender']!.value = value;
    update(['gender']);
  }

  setCurriculumType(int id){
    form.controls['id_curriculum_type']!.value = id.toString();
    update(['types']);
  }


  getTypesData() async {
    CustomLoading.showLoading();
    final curriculums = await PortalRepository().getCurriculum();
    CustomLoading.cancelLoading();
    if(curriculums != null){
      curriculumTypeList = curriculums;
    }
    update(['types']);
  }


  tabBarToIndex(int index){
    tabBarController.index = index;
    update(['TabBarView']);
  }

  addImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 50);
    if(images != null){
      for(var item in images){
        imageModelList.add(ImageModel(name: item.name, path: item.path, size: "0"));
      }
      update(['images']);
    }
  }

  deleteImages(int index) async {
    imageModelList.removeAt(index);
    update(['images']);
  }

  @override
  void onInit() {
    getTypesData();
    super.onInit();
    tabBarController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    form.dispose();
    tabBarController.dispose();
  }
}
