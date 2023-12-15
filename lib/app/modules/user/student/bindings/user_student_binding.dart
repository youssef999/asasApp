import 'package:get/get.dart';

import '../controllers/user_student_controller.dart';

class UserStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserStudentController>(
      () => UserStudentController(),
    );
  }
}
