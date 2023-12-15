import 'package:get/get.dart';

import '../controllers/user_category_controller.dart';

class UserCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserCategoryController>(
      () => UserCategoryController(),
    );
  }
}
