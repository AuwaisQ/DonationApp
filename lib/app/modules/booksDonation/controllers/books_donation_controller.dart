import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../const.dart';
import '../../../resources/apiService.dart';

class BooksDonationController extends GetxController {
  //TODO: Implement BooksDonationController
  int? userId;
  final GlobalKey<FormState>medicalDonationFormKey=GlobalKey<FormState>();
  late TextEditingController description = TextEditingController();
  late TextEditingController contactName = TextEditingController();
  late TextEditingController contactNumber = TextEditingController();
  late TextEditingController booksQuantity = TextEditingController();
  var selectCategory = 'Select Type'.obs;
  var isApiLoading = false.obs;
  final count = 0.obs;
  var category = Get.arguments;
  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('UserId');
    print("Category type${category.value}");
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

  void getBooksEnquiry() async {
    isApiLoading.value = true;
    final response = await ApiService().booksEnquiry(
      userId.toString(),
      selectCategory.value,
      description.text,
      booksQuantity.text,
      contactName.text,
      contactNumber.text,
    );
    print('Medical Response - $response');
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
                            description.clear();
                            booksQuantity.clear();
                            contactName.clear();
                            contactNumber.clear();
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
  void increment() => count.value++;
}
