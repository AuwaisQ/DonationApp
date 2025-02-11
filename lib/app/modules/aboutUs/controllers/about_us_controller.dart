import 'dart:convert';

import 'package:get/get.dart';
import 'package:wecare/app/modules/aboutUs/model/model.dart';

import '../../../resources/apiService.dart';

class AboutUsController extends GetxController {
  //TODO: Implement AboutUsController
  var imageList = <GetAboutUsImages>[].obs;
  // var aboutUsDescription = <GetAboutUsDescription>[].obs;
  var aboutUsDescription = ''.obs;
  var isApiLoading = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    getAboutUsImages();
    getAboutUsDescription();
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

  //Getting about us images
  getAboutUsImages() async {
    isApiLoading.value = true;
    var response = await ApiService().getAboutUsImages();
    print('\n');
    print('About Us Image Response - ${response['status']}');
    print('\n');
    imageList.value = aboutUsImagesFromJson(jsonEncode(response['data']));
    isApiLoading.value = false;
  }

  //Getting about us Description
  getAboutUsDescription() async {
    isApiLoading.value = true;
    var response = await ApiService().getAboutUsDescription();
    print('\n');
    print('About Us Description Response - ${response['status']}');
    print('\n');
    aboutUsDescription.value = response['description'];
    // aboutUsDescription.value = aboutUsDescriptionFromJson(jsonEncode(response['data']));
    isApiLoading.value = false;
  }

  void increment() => count.value++;
}
