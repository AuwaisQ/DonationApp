import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare/app/resources/apiService.dart';
import '../../../../const.dart';

class FoodDonationController extends GetxController {
  var donationDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  var selectedTime = TimeOfDay.now().obs;
  int? userId;
  Contact? contactPicked;
  var food = "".obs;
  var foodtype = "Veg".obs;
  final GlobalKey<FormState> foodDonationFormKey = GlobalKey<FormState>();
  late TextEditingController foodDescription = TextEditingController();
  late TextEditingController contactName = TextEditingController();
  late TextEditingController contactNumber = TextEditingController();
  late TextEditingController location = TextEditingController();
  late FlutterContactPicker contactPicker;
  var isApiLoading = false.obs;
  @override
  void onInit() async{
    contactPicker = FlutterContactPicker();
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
    foodDescription.dispose();
    foodDescription.clear();
    contactName.dispose();
    contactName.clear();
    contactNumber.dispose();
    contactNumber.clear();
    location.dispose();
    location.clear();
    super.onClose();
  }

  //region Date of Birth Picker
  selectDateOfBirth() async {
    print("Date Picker Called");
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      currentDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primColor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: primColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    donationDate.value = DateFormat('dd-MM-yyyy').format(pickedDate!);
  }
  //endregion

  void postFoodEnquiry() async {
    isApiLoading.value = true;
    final response = await ApiService().foodEnquiry(
        userId.toString(),
        foodDescription.text,
        food.value,
        donationDate.value,
        contactName.text,
        contactNumber.text,
        location.text
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
                            foodDescription.clear();
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

  void setGender(var type) {
    food.value = type;
    foodtype.value = type;
    print(food.value);
  }

  void selectContact() async{
    Contact? pickedContact = await contactPicker.selectContact();
    contactPicked = pickedContact;
  }
}
