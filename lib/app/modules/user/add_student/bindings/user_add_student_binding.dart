import 'package:get/get.dart';

import '../controllers/user_add_student_controller.dart';

class UserAddStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAddStudentController>(
      () => UserAddStudentController(),
    );
  }
}
