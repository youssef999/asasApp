import 'package:get/get.dart';

import '../controllers/owner_org_data_controller.dart';

class OwnerOrgDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerOrgDataController>(
      () => OwnerOrgDataController(),
    );
  }
}
