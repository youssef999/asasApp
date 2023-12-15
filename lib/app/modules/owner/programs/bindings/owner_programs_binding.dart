import 'package:get/get.dart';

import '../controllers/owner_programs_controller.dart';

class OwnerProgramsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerProgramsController>(
      () => OwnerProgramsController(),
    );
  }
}
