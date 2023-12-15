import 'package:get/get.dart';

import '../controllers/user_favorite_controller.dart';

class UserFavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserFavoriteController>(
      () => UserFavoriteController(),
    );
  }
}
