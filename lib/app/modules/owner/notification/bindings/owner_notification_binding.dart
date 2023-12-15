import 'package:get/get.dart';

import '../controllers/owner_notification_controller.dart';

class OwnerNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerNotificationController>(
      () => OwnerNotificationController(),
    );
  }
}
