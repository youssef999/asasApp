import 'package:get/get.dart';

import '../controllers/owner_edit_program_controller.dart';

class OwnerEditProgramBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerEditProgramController>(
      () => OwnerEditProgramController(),
    );
  }
}
