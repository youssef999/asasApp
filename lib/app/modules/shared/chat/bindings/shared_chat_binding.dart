import 'package:get/get.dart';

import '../controllers/shared_chat_controller.dart';

class SharedChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedChatController>(
      () => SharedChatController(),
    );
  }
}
