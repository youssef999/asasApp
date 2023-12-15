import 'package:get/get.dart';

import '../controllers/owner_login_controller.dart';

class OwnerLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerLoginController>(
      () => OwnerLoginController(),
    );
  }
}
