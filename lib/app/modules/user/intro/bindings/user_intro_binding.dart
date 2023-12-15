import 'package:get/get.dart';

import '../controllers/user_intro_controller.dart';

class UserIntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserIntroController>(
      () => UserIntroController(),
    );
  }
}
