import 'package:asas/app/data/model/student.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:get/get.dart';

class UserStudentController extends GetxController {


  List<Student> studentList = [];
  ApiCallStatus studentStatus = ApiCallStatus.loading;


  getStudents() async {
    studentStatus = ApiCallStatus.loading;
    update();
    final result = await UserRepository().getStudents();
    if(result == null){
      studentStatus = ApiCallStatus.failed;
    }else if(result.isNotEmpty){
      studentStatus = ApiCallStatus.success;
      studentList = result;
    }else{
      studentStatus = ApiCallStatus.empty;
    }
    update();
  }

  deleteStudents(int id) async {
    Get.back();
    CustomLoading.showLoading();
    final data = await UserRepository().deleteStudents(id);
    CustomLoading.cancelLoading();
    if(data){
      studentList.removeWhere((element) => element.id == id);
      update();
    }
  }

  addStudent() async{
    final student = await Get.toNamed(Routes.USER_ADD_STUDENT);
    if(student!=null){
      studentStatus = ApiCallStatus.success;
      studentList.add(student);
      update();
    }
  }

  onRefresh() async {
    await getStudents();
  }


  @override
  void onInit() {
    super.onInit();
    getStudents();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
