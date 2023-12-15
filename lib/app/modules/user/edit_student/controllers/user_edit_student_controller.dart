import 'package:asas/app/data/model/curriculum_type.dart';
import 'package:asas/app/data/model/image.dart';
import 'package:asas/app/data/model/media.dart';
import 'package:asas/app/data/model/student.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';

class UserEditStudentController extends GetxController {

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

  String? get dateOfBirth => form.controls['date_of_birth']!.value as String?;
  String? get gender => form.controls['gender']!.value as String?;


  List<Media> mediaList = [];
  List<CurriculumType> curriculumTypeList = [];



  int studentId = 0;
  Student? student ;

  updateStudent() async {

    if(!form.valid){
      CustomLoading.showWrongToast(msg: Strings.All_fields_entered.tr );
      return;
    }

    Map<String, String> body = {};
    form.rawValue.forEach((key, value) => body[key] = value.toString());

    CustomLoading.showLoading(msg: Strings.Data_being_updated.tr);
    final data = await UserRepository().updateStudents(body, studentId);
    CustomLoading.cancelLoading();

    if(data != null){
      Get.back();
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

  getCurriculumInitialIndex(){
    if(student?.idCurriculumType == '-' || student?.idCurriculumType == null){
      return null;
    }

    int id = int.parse(student?.idCurriculumType ?? '0');
    return curriculumTypeList.indexWhere((element) => element.id == id);
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

  addImages() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(image != null){
      CustomLoading.showLoading();
      final result = await UserRepository().addMedia({
        "table_name": 'children',
        "media": image.path,
      }, studentId);
      CustomLoading.cancelLoading();

      if(result){
        mediaList.add(Media(name: image.name, path: image.path,));
        update(['images']);
      }
    }
  }

  deleteImages(int index, int id) async {
    Get.back();
    CustomLoading.showLoading();
    final result = await UserRepository().deleteMedia(id);
    CustomLoading.cancelLoading();
    if(result){
      mediaList.removeAt(index);
      update(['images']);
    }
  }


  setDataToView(Student student){
    Logger().i(student.toJson());
    form.controls['name']!.value = student.name ;
    form.controls['name_father']!.value = student.nameFather ;
    form.controls['date_of_birth']!.value = student.dateOfBirth ;
    form.controls['gender']!.value = student.gender ;

    if(student.nationality != "-" && student.nationality != null && student.nationality != "null"){
      form.controls['nationality']!.value = student.nationality ;
    }

    if(student.countryOfResidence != "-" && student.countryOfResidence != null && student.countryOfResidence != "null"){
      form.controls['country_of_residence']!.value = student.countryOfResidence ;
    }
    if(student.idCurriculumType != "-" && student.idCurriculumType != null && student.idCurriculumType != "null"){
      form.controls['id_curriculum_type']!.value = student.idCurriculumType ;
    }
    if(student.currentAcademicCertificates != "-" && student.currentAcademicCertificates != null && student.currentAcademicCertificates != "null"){
      form.controls['current_academic_certificates']!.value = student.currentAcademicCertificates ;

    }
    if(student.sportsOfInterest != "-" && student.sportsOfInterest != null && student.sportsOfInterest != "null"){
      form.controls['sports_of_interest']!.value = student.sportsOfInterest ;
    }
    if(student.artisticActivitiesOfInterest != "-" && student.artisticActivitiesOfInterest != null && student.artisticActivitiesOfInterest != "null"){
      form.controls['artistic_activities_of_interest']!.value = student.artisticActivitiesOfInterest ;
    }
    if(student.religiousActivitiesOfInterest != "-" && student.religiousActivitiesOfInterest != null && student.religiousActivitiesOfInterest != "null") {
      form.controls['religious_activities_of_interest']!.value = student.religiousActivitiesOfInterest ;
    }

    update(['main']);
  }


  getStudentById(int id) async {
    CustomLoading.showLoading();
    final data = await UserRepository().getStudentById(id);
    if(data != null){
      student = data;

      mediaList = student!.media!;
      // update(['image']);

      setDataToView(student!);

      await getTypesData();
    }
    CustomLoading.cancelLoading();
  }

  @override
  void onInit() {
    super.onInit();

    studentId = Get.arguments[0];
    getStudentById(studentId);

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
