import 'package:get/get.dart';

import '../controllers/owner_otp_controller.dart';

class OwnerOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerOtpController>(
      () => OwnerOtpController(),
    );
  }
}
