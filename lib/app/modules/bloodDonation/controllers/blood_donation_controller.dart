import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare/app/modules/bloodDonation/model/bloodGroup.dart';
import 'package:wecare/app/resources/apiService.dart';

import '../../../../const.dart';

class BloodDonationController extends GetxController {

  var isAP = false.obs;
  var isAN = false.obs;
  var isBP = false.obs;
  var isBN = false.obs;
  var isABP = false.obs;
  var isABN = false.obs;
  var isOP = false.obs;
  var isON = false.obs;
  var bloodDonation = <BloodGroup>[].obs;
  var selectedBloodGroup = ''.obs;
  var bloodGroup = <String>[].obs;
  int? userId;
  final GlobalKey<FormState>bloodDonationFormKey=GlobalKey<FormState>();
  late TextEditingController bloodUnitsController = TextEditingController();
  late TextEditingController contactName = TextEditingController();
  late TextEditingController contactNumber = TextEditingController();
  late TextEditingController location = TextEditingController();
  var isApiLoading = false.obs;

  @override
  void onInit()  async{
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('UserId');
    bloodDonation
        .add(BloodGroup(bloodGroup: 'A+', isGroupSelected: isAP.value));
    bloodDonation
        .add(BloodGroup(bloodGroup: 'A-', isGroupSelected: isAN.value));
    bloodDonation
        .add(BloodGroup(bloodGroup: 'B+', isGroupSelected: isBP.value));
    bloodDonation
        .add(BloodGroup(bloodGroup: 'B-', isGroupSelected: isBN.value));
    bloodDonation
        .add(BloodGroup(bloodGroup: 'AB+', isGroupSelected: isABP.value));
    bloodDonation
        .add(BloodGroup(bloodGroup: 'AB-', isGroupSelected: isABN.value));
    bloodDonation
        .add(BloodGroup(bloodGroup: 'O+', isGroupSelected: isOP.value));
    bloodDonation
        .add(BloodGroup(bloodGroup: 'O-', isGroupSelected: isON.value));
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

  void getBloodEnquiry() async {
    isApiLoading.value = true;
    final response = await ApiService().bloodEnquiry(
      userId.toString(),
      selectedBloodGroup.value,
      bloodUnitsController.text,
      contactName.text,
      contactNumber.text,
      location.text,
    );
    if(response['status'] == true){
      isApiLoading.value = false;
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
                          'Request submitted Succesfully 👍🏻',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: InkWell(
                          onTap: (){
                            Get.back();
                            Get.back();
                            bloodUnitsController.clear();
                            contactName.clear();
                            contactNumber.clear();
                            location.clear();
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
    }
  }
}
