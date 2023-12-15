import 'package:get/get.dart';

import '../controllers/owner_booking_details_controller.dart';

class OwnerBookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerBookingDetailsController>(
      () => OwnerBookingDetailsController(),
    );
  }
}
