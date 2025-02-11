// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/apiService.dart';
import 'dart:io' as Io;
import '../../bottomBar/views/bottom_bar_view.dart';

class ProfileController extends GetxController {
  var profilePicture=''.obs;
  var base64Image = ''.obs;
  final GlobalKey<FormState>profileFormKey=GlobalKey<FormState>();
  late TextEditingController userNameController = TextEditingController();
  late TextEditingController emailIdController = TextEditingController();
  var userMobileNumber = ''.obs;
  var demoEmail = 'user@gmail.com';
  var genderSelect = 'Select Gender'.obs;
  int? userId;
  var isApiLoading = false.obs;
  var isImageLoading = false.obs;

  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userMobileNumber.value = prefs.getString('userMobileNumber')!;
    super.onInit();
  }

  @override
  void onReady() async{
    super.onReady();
  }

  @override
  void onClose() {
    userNameController.clear();
    emailIdController.clear();
    super.onClose();
  }



  //Profile Image Picker
  void getImage(ImageSource imageSource) async {
    isImageLoading.value = true;
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      profilePicture.value = pickedFile.path;
      final bytes = await Io.File(profilePicture.value).readAsBytes();
      base64Image.value = base64Encode(bytes);
      print(base64Image.value);
    } else {
      Get.snackbar(
        'Error',
        'No Image Selected',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isImageLoading.value = false;
  }

  void sendUserProfile()async {
    isApiLoading.value = true;
    //Sending data from api
    final response = await ApiService().userProfile(
      base64Image.value,
      userNameController!.text,
      emailIdController!.text.isEmpty ? demoEmail : emailIdController!.text,
      userMobileNumber.value,
      genderSelect.value,
    );
    //after geting response
    if(response['status'] == true){
      print('Profile Response - $response');
      userId = response['profile_id'];
      //Setting Login True & Saving profile id
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      prefs.setInt('UserId',userId!);
      Get.off(() => BottomBarView(), transition: Transition.downToUp);
      isApiLoading.value = false;
    }else{
      print('Something went wrong');
    }
  }

}
