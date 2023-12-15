import 'package:get/get.dart';

import '../controllers/shared_map_controller.dart';

class SharedMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedMapController>(
      () => SharedMapController(),
    );
  }
}
