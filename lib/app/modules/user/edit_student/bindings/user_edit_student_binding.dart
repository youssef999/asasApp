import 'package:get/get.dart';

import '../controllers/user_edit_student_controller.dart';

class UserEditStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserEditStudentController>(
      () => UserEditStudentController(),
    );
  }
}
