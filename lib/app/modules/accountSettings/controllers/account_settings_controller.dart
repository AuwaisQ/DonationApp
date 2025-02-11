import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../resources/apiService.dart';

class AccountSettingsController extends GetxController {
  //TODO: Implement AccountSettingsController

  final count = 0.obs;
  int? userId;
  final apiLoading = false.obs;
  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('UserId');
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

  void terminateAccount()async{
    apiLoading.value = true;
    final responce = await ApiService().deleteAccount(userId.toString());
    print(responce);
    if(responce['status'] == true){
      apiLoading.value = false;
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs.setBool("isLogin", false);
      SystemNavigator.pop();
      exit(0);
    }
    apiLoading.value = false;
  }

  void increment() => count.value++;
}
