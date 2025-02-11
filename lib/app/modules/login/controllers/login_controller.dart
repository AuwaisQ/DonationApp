// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare/app/modules/profile/views/profile_view.dart';
import '../../../resources/apiService.dart';
import '../../appDrawer/views/app_drawer_view.dart';

class LoginController extends GetxController {

  final GlobalKey<FormState>loginFormKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var statusString = 'welcome'.obs;
  var codeSent = 'no'.obs;
  var myVerificationId = '1'.obs;
  var start = 10.obs;//10 seconds timer variable
  Timer? timer;
  var timerStatus = true.obs;
  var userId = 0.obs;

  String get result => statusString.value;
  String get codeSentResult => codeSent.value;
  String get verifyResult => myVerificationId.value;

  var isLoading = false.obs;

  late TextEditingController phoneNumber;
  late TextEditingController codeController;

  @override
  void onInit() async{
    phoneNumber = TextEditingController();
    codeController = TextEditingController();
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

  //Start Timer
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (timerStatus.value) {
          if (start.value == 0) {
              timer.cancel();
          } else {
            start.value--;
          }
        } else {
          timer!.cancel();
        }
      },
    );
  }

  mobileVerification(String phoneNumber) async {
    final response = await ApiService().checkMobile(phoneNumber);//Getting response from api after giving number.
    print('Mobile Verification Triggered');
    final prefs = await SharedPreferences.getInstance();
    print('\nMobile Verification - $response\n');
    if(response['status'] == 'true'){
      userId.value = response['userId'];//fetching response and assigning value.
      print('\nUser Id- ${userId.value}\n');
      prefs.setInt('UserId',userId.value);//saving userImage from api response.
      Get.off(AppDrawerView());
    }else{
      Get.off(ProfileView());
    }
    isLoading.value = false;
  }

  //region Phone Number Login
  signInPhoneNumber({required String myPhoneNumber}) async {
    if(myPhoneNumber.length != 10){
      Get.snackbar(
        'Incorrect Number',
        'Please Provide 10 digit Phone Number',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.6),
      );
    }else{
      isLoading.value = true;
      await firebaseAuth.verifyPhoneNumber(
        //Pass in the phone number
        phoneNumber: '+91$myPhoneNumber',
        //Triggers if phone number is verified
        verificationCompleted: (_){},
        //Triggers if verification fails
        verificationFailed: (FirebaseException exception){
          statusString.value = 'Error Verifying Your Phone Number';
        },
        //triggered when firebase sends a code
        codeSent: (verificationId,responseToken){
          print('Code Sent triggered');
          codeSent.value = 'yes';
          myVerificationId.value = verificationId;
          isLoading.value = false;
        },
        //get a new code after timeout
        codeAutoRetrievalTimeout: (_){},
        //Time in which the code is valid
        timeout: const Duration(seconds:30),
      );
    }
  }
  //endregion

  //region OTP Verification
  myCredentials(String verId, String userId) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    //Setting Login as true
    prefs.setBool('isLogin',true);
    AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verId, smsCode: userId);
    firebaseAuth.signInWithCredential(authCredential).then((UserCredential){
      //Saving mobile number into shared prefs.
      prefs.setString('userMobileNumber',phoneNumber.text);
      //Checking Mobile
      mobileVerification(phoneNumber.text);
    }).catchError((e){
      print('Ye Hai Error:- ${e}');
      Get.snackbar(
        'Invalid OTP',
        'Please Provide Correct OTP',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.6),
      );
    });
  }
//endregion
}