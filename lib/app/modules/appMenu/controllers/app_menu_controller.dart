import 'dart:convert';

import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/apiService.dart';
import '../model/model.dart';

class AppMenuController extends GetxController {
  //TODO: Implement AppMenuController
  var userImage = ''.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  int? userId;
  var contactDetails = <GetContact>[].obs;

  final count = 0.obs;
  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('UserId');
    fetchProfile(userId.toString());
    print(userImage.value);
    getContactList();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  //Geting user Profile
  fetchProfile(String userId) async {
    //Giving response to api after getting userId
    var response = await ApiService().getProfile(userId);
    //fetching response and assigning value
    userImage.value = response['data']['image'];
    userName.value = response['data']['name'];
    userEmail.value = response['data']['email'];
  }

  //Geting Conatct List
  getContactList() async {
    var response = await ApiService().getContactList();
    print('\n');
    print('Contact Details Response - $response');
    print('\n');
    contactDetails.value = getContactModelFromJson(jsonEncode(response['data']));
  }

  void increment() => count.value++;
}
