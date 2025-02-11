import 'package:get/get.dart';

import '../controllers/blood_donation_controller.dart';

class BloodDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodDonationController>(
      () => BloodDonationController(),
    );
  }
}
