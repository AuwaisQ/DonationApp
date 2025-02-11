import 'dart:convert';

import 'package:get/get.dart';
import '../../../resources/apiService.dart';
import '../model/selectIntersetModel.dart';

class SelectInterestController extends GetxController {
  //TODO: Implement SelectInterestController

  var childCare = false.obs;
  var education = false.obs;
  var environment = false.obs;
  var food = false.obs;
  var handicap = false.obs;
  var humanity = false.obs;
  var medicine = false.obs;
  var others = false.obs;
  var interestList = <GetCategories>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    getBanners();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //Getting Categories form api
  getBanners() async {
    var response = await ApiService().getCategory();
    print('\nSelect Category - $response\n');
    interestList.value = getCategoriesFromJson(jsonEncode(response['data']));
  }
  void increment() => count.value++;
}
