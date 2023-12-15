import 'package:get/get.dart';

import '../controllers/user_edit_address_controller.dart';

class UserEditAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserEditAddressController>(
      () => UserEditAddressController(),
    );
  }
}
