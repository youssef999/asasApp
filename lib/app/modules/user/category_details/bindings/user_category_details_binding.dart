import 'package:get/get.dart';

import '../controllers/user_category_details_controller.dart';

class UserCategoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserCategoryDetailsController>(
      () => UserCategoryDetailsController(),
    );
  }
}
