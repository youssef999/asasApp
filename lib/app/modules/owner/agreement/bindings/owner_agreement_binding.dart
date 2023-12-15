import 'package:get/get.dart';

import '../controllers/owner_agreement_controller.dart';

class OwnerAgreementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerAgreementController>(
      () => OwnerAgreementController(),
    );
  }
}
