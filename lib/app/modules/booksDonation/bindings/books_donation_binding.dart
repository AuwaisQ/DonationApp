import 'package:get/get.dart';

import '../controllers/books_donation_controller.dart';

class BooksDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BooksDonationController>(
      () => BooksDonationController(),
    );
  }
}
