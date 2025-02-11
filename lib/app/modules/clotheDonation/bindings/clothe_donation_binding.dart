import 'package:get/get.dart';

import '../controllers/clothe_donation_controller.dart';

class ClotheDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClotheDonationController>(
      () => ClotheDonationController(),
    );
  }
}
