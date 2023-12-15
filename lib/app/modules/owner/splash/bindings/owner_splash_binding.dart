import 'package:get/get.dart';

import '../controllers/owner_splash_controller.dart';

class OwnerSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerSplashController>(
      () => OwnerSplashController(),
    );
  }
}
