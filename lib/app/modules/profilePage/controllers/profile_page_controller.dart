// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../const.dart';
import '../../../resources/apiService.dart';
import 'dart:io' as Io;

class ProfilePageController extends GetxController {

  final count = 0.obs;
  var profilePicture=''.obs;
  var base64Image = ''.obs;
  int? userId;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userMobile = ''.obs;
  var userGender = ''.obs;
  var userImage = ''.obs;
var   isApiLoading = false.obs;
  var isImageLoading = false.obs;
  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('UserId');
    print('User Id - $userId');
    print('User Image url - ${userImage}');
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

  //Profile Image Picker
  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      profilePicture.value = pickedFile.path;
      final bytes = await Io.File(profilePicture.value).readAsBytes();
      base64Image.value = base64Encode(bytes);
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
    isImageLoading.value = true;
  }

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

  void updateProfile() async {
    isApiLoading.value = true;
    //Sending data from api.
    final response = await ApiService().updateprofilePhoto(
      userId!,
      base64Image.value,
    );
    //after getting response
    if(response['status'] == true){
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          content: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75,left: 10),
                child: Container(
                  height: 200,
                  width: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.9),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 55, left: 20),
                        child: Text(
                          'Profile Updated Successfully 👍🏻',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: InkWell(
                          onTap: (){
                            isImageLoading.value = false;
                            Get.back();
                          },
                          child: Container(
                            height: 45,width: 200,
                            decoration: BoxDecoration(
                              color: primColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Center(child: Text('Done',style: buttonTitleStyleW,),),
                          ),
                        ),
                      )
                    ],),
                ),
              ),
              //Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('lottiefiles/submited.json',height: 150,width:150,fit: BoxFit.cover),
                ],
              ),
            ],
          ),
        ),
      );
      isApiLoading.value = false;
    }else{
      print('Something went wrong');
    }
  }

  void increment() => count.value++;
}
