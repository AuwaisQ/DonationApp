import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../resources/apiService.dart';

class AppDrawerController extends GetxController {
  //TODO: Implement AppDrawerController
  late ZoomDrawerController zoomDrawerController;
  int? userId;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userMobile = ''.obs;
  var userGender = ''.obs;
  var userImage = ''.obs;

  final count = 0.obs;
  @override
  void onInit() async{
    zoomDrawerController = ZoomDrawerController();
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('UserId');
    fetchProfile(userId.toString());
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
  fetchProfile(String userId) async {
    //Giving response to api after getting userId
    var response = await ApiService().getProfile(userId);
    print('In App Profile Responce - ${response}');
    //fetching response and assigning value
    userImage.value = response['data']['image'];
    userName.value = response['data']['name'];
    userEmail.value = response['data']['email'];
    userMobile.value = response['data']['mobile'];
    userGender.value = response['data']['gender'];
    final prefs = await SharedPreferences.getInstance();
    //saving userImage from api response
    prefs.setString('userImage',userImage.value.toString());
    prefs.setString('userName',userName.value.toString());
    prefs.setString('userEmail',userEmail.value.toString());
  }
}
