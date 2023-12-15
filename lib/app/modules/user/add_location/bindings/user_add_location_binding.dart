import 'package:get/get.dart';

import '../controllers/user_add_location_controller.dart';

class UserAddLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAddLocationController>(
      () => UserAddLocationController(),
    );
  }
}
