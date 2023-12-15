import 'package:get/get.dart';

import '../controllers/owner_add_program_controller.dart';

class OwnerAddProgramBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerAddProgramController>(
      () => OwnerAddProgramController(),
    );
  }
}
