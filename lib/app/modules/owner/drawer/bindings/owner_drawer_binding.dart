import 'package:get/get.dart';

import '../controllers/owner_drawer_controller.dart';

class OwnerDrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerDrawerController>(
      () => OwnerDrawerController(),
    );
  }
}
