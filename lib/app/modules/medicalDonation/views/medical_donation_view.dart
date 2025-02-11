// ignore_for_file: unrelated_type_equality_checks

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../../../../const.dart';
import '../controllers/medical_donation_controller.dart';

class MedicalDonationView extends GetView<MedicalDonationController> {
  MedicalDonationController medicalController = Get.put(
      MedicalDonationController());

  MedicalDonationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: (){
              medicalController.description.clear();
              medicalController.contactName.clear();
              medicalController.contactNumber.clear();
              medicalController.contactAddress.clear();
              medicalController.selectCategory.value = 'Select Category';
              Get.back();
            },
            child: const Icon(Icons.arrow_back, color: Colors.black,),
          ),
          title: const Text(
            'Donate Medical Equipment\'s',
            style: headline,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Blood Donation Image
                  Material(
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    child: Lottie.asset('lottiefiles/medical.json'),
                  ),
                  SizedBox(height: size.width * 0.05,),
                  const Text('Select Category', style: headline1,),
                  SizedBox(height: size.width * 0.02,),
                  //Drop-Down Widget
                  Container(
                    height: size.width / 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(700),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10),
                          child: Obx(() {
                            return DropdownButton2(
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              isExpanded: true,
                              isDense: true,
                              value: medicalController.selectCategory.value,
                              hint: Text(
                                'Select Category',
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 16),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                              onChanged: (value) {
                                medicalController.selectCategory.value =
                                    value.toString();
                              },
                              items: <String>[
                                'Medicines',
                                'Medical Equipment',
                                'Select Category'
                              ]
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.05,),
                  Form(
                    key: medicalController.medicalDonationFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Description', style: headline1,),
                        SizedBox(height: size.width * 0.02,),
                        //Description TextField
                        TextFormField(
                          controller: medicalController.description,
                          validator: (value) {
                            if (value!.length < 3) {
                              return 'Add At least 3 characters';
                            }
                          },
                          maxLength: 30,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Donation Description..',
                            labelStyle: TextStyle(color: Colors.grey.shade400),
                            suffixIcon: const Icon(
                              CupertinoIcons.drop,
                              color: Colors.red,
                            ),
                            counterText: '',
                            alignLabelWithHint: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: primColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.width * 0.05,),
                        const Text('Contact Detail\'s', style: headline1,),
                        SizedBox(height: size.width * 0.02,),
                        //Contact Name
                        TextFormField(
                          controller: medicalController.contactName,
                          validator: (value) {
                            if (value!.length < 5) {
                              return 'Add At least 5 characters';
                            }
                          },
                          maxLength: 20,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Contact Name',
                            labelStyle: TextStyle(color: Colors.grey.shade400),
                            suffixIcon: Icon(
                              CupertinoIcons.person_add,
                              color: Colors.grey.shade400,
                            ),
                            counterText: '',
                            alignLabelWithHint: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: primColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.width * 0.05,),
                        //Contact Number
                        TextFormField(
                          controller: medicalController.contactNumber,
                          validator: (value) {
                            if (value!.length < 10) {
                              return 'Add At least 10 Digit\'s';
                            }
                          },
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Contact Number',
                            labelStyle: TextStyle(color: Colors.grey.shade400),
                            suffixIcon: Icon(
                              CupertinoIcons.device_phone_portrait,
                              color: Colors.grey.shade400,
                            ),
                            counterText: '',
                            alignLabelWithHint: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: primColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.width * 0.05,),
                        //Location TextField
                        TextFormField(
                          controller: medicalController.contactAddress,
                          validator: (value) {
                            if (value!.length < 5) {
                              return 'Add At least 5 characters';
                            }
                          },
                          maxLength: 30,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: TextStyle(color: Colors.grey.shade400),
                            suffixIcon: Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.grey.shade400,
                            ),
                            counterText: '',
                            alignLabelWithHint: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: primColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.width * 0.05,),
                      ],),
                  ),
                  Obx(() {
                    return InkWell(
                      onTap: () {
                        if (medicalController.medicalDonationFormKey.currentState!.validate() && medicalController.selectCategory != 'Select Category') {
                          medicalController.getBloodEnquiry();
                        } else {
                          Get.snackbar(
                            'Incorrect Format',
                            'Please fill the form correctly',
                            margin: const EdgeInsets.all(20),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withOpacity(0.6),
                          );
                        }
                      },
                      child: Container(
                        height: size.width * 0.13,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: primColor,
                        ),
                        child: Stack(
                          children: [
                            Center(
                                child: Text(
                                  medicalController.isApiLoading == true
                                      ? 'Sending'
                                      : 'Send Request',
                                  style: buttonTitleStyleW,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: medicalController.isApiLoading == true
                                    ? LoadingAnimationWidget.threeArchedCircle(
                                    color: Colors
                                        .white, size: 25)
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: size.width * 0.02,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
