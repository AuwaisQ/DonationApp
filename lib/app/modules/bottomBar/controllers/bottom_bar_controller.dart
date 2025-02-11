import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  //TODO: Implement BottomBarController

  late PageController pageController;
  var currentIndex = 0.obs;
  final count = 0.obs;
  @override
  void onInit() {
    pageController = PageController();
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

  void increment() => count.value++;
}
