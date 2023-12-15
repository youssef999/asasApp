import 'package:get/get.dart';

import '../controllers/owner_signup_controller.dart';

class OwnerSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerSignupController>(
      () => OwnerSignupController(),
    );
  }
}
