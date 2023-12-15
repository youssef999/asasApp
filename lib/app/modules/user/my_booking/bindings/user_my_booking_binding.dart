import 'package:get/get.dart';

import '../controllers/user_my_booking_controller.dart';

class UserMyBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserMyBookingController>(
      () => UserMyBookingController(),
    );
  }
}
