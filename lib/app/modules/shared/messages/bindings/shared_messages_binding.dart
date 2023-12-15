import 'package:get/get.dart';

import '../controllers/shared_messages_controller.dart';

class SharedMessagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedMessagesController>(
      () => SharedMessagesController(),
    );
  }
}
