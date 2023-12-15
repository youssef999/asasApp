import 'package:get/get.dart';

import '../controllers/user_my_location_controller.dart';

class UserMyLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserMyLocationController>(
      () => UserMyLocationController(),
    );
  }
}
