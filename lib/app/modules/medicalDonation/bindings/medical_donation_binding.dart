import 'package:get/get.dart';

import '../controllers/medical_donation_controller.dart';

class MedicalDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalDonationController>(
      () => MedicalDonationController(),
    );
  }
}
