import 'package:get/get.dart';

import '../controllers/food_donation_controller.dart';

class FoodDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodDonationController>(
      () => FoodDonationController(),
    );
  }
}
