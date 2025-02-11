import 'package:get/get.dart';

import '../controllers/pending_request_controller.dart';

class PendingRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingRequestController>(
      () => PendingRequestController(),
    );
  }
}
