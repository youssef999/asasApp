import 'package:get/get.dart';

import '../controllers/user_program_details_controller.dart';

class UserProgramDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProgramDetailsController>(
      () => UserProgramDetailsController(),
    );
  }
}
