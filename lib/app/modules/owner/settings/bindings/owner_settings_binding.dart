import 'package:get/get.dart';

import '../controllers/owner_settings_controller.dart';

class OwnerSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerSettingsController>(
      () => OwnerSettingsController(),
    );
  }
}
