import 'package:get/get.dart';

import '../controllers/owner_booking_requsets_controller.dart';

class OwnerBookingRequsetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerBookingRequsetsController>(
      () => OwnerBookingRequsetsController(),
    );
  }
}
