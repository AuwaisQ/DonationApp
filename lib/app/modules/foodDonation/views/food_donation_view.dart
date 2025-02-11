// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wecare/const.dart';
import '../controllers/food_donation_controller.dart';

class FoodDonationView extends GetView<FoodDonationController> {
  FoodDonationController foodController = Get.put(FoodDonationController());

  FoodDonationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: (){
              foodController.foodDescription.clear();
              foodController.contactName.clear();
              foodController.contactNumber.clear();
              foodController.location.clear();
              Get.back();
            },
            child: const Icon(Icons.arrow_back, color: primColor,),
          ),
          title: const Text('Donate Food', style: titleStyle,),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: SingleChildScrollView(
              child: Form(
                key: foodController.foodDonationFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/foodDonation.jpg',
                        height: size.width * 0.6,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: size.width * 0.05),
                    const Text('Food Description', style: headline1),
                    //Radio Button
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Veg',
                                groupValue: controller.foodtype.value,
                                onChanged: (value) {
                                  controller.setGender(value);
                                  //controller.address_type = valu!;
                                },
                                activeColor: Colors.purple,
                                fillColor: MaterialStateProperty.all(
                                    primColor),
                              ),
                              const Text(
                                'Veg',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Non-Veg',
                                groupValue: controller.foodtype.value,
                                onChanged: (value) {
                                  controller.setGender(value);
                                },
                                activeColor: Colors.purple,
                                fillColor: MaterialStateProperty.all(
                                    primColor),
                              ),
                              const Text(
                                'Non-Veg',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: size.width * 0.02),
                    //Description Field
                    TextFormField(
                      controller: foodController.foodDescription,
                      validator: (value) {
                        if (value!.length < 5) {
                          return 'Add At least 5 characters';
                        }
                      },
                      maxLength: 50,
                      maxLines: 2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Describe you\'r donation...',
                        labelStyle: TextStyle(color: Colors.grey.shade400),
                        suffixIcon: Icon(
                          CupertinoIcons.list_bullet,
                          color: Colors.grey.shade400,
                        ),
                        counterText: '',
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: primColor,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.05),
                    //Date & Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PickUp Date', style: headline1,),
                        SizedBox(height: size.width * 0.02,),
                        Obx(() {
                          return InkWell(
                            onTap: () =>
                                foodController.selectDateOfBirth(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              height: size.width * 0.12,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: primColor),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(foodController.donationDate.value,
                                      style: subTitle),
                                  Icon(CupertinoIcons.calendar,
                                      color: primColor)
                                ],),
                            ),
                          );
                        }),
                      ],),
                    SizedBox(height: size.width * 0.05),
                    const Text('Provide Contact Detail\'s', style: headline1),
                    SizedBox(height: size.width * 0.02),
                    //Contact Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Contact Name
                        TextFormField(
                          controller: foodController.contactName,
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
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                controller: foodController.contactNumber,
                                validator: (value) {
                                  if (value!.length < 10) {
                                    return 'Add At least 10 Digits';
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
                            ),
                            SizedBox(width: size.width * 0.02,),
                            // Expanded(
                            //   flex: 1,
                            //     child: InkWell(
                            //       onTap: (){
                            //         foodController.selectContact();
                            //       },
                            //       child: Container(
                            //         height: size.width * 0.15,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(100),
                            //           color: primColor
                            //         ),
                            //         child: const Center(
                            //           child: Icon(Icons.quick_contacts_dialer_rounded,color: Colors.white,),
                            //         ),
                            //       ),
                            //     ))
                          ],
                        ),
                        SizedBox(height: size.width * 0.05,),
                        //Location TextField
                        TextFormField(
                          controller: foodController.location,
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
                      ],),
                    SizedBox(height: size.width * 0.05),
                    //button
                    InkWell(
                      onTap: () {
                        if (foodController.foodDonationFormKey.currentState!
                            .validate()) {
                          foodController.postFoodEnquiry();
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
                      child: Obx(() {
                        return Container(
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
                                    foodController.isApiLoading == true
                                        ? 'Sending'
                                        : 'Send Request',
                                    style: buttonTitleStyleW,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: foodController.isApiLoading == true
                                      ? LoadingAnimationWidget.threeArchedCircle(
                                      color: Colors
                                          .white, size: 25)
                                      : Container(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: size.width * 0.05),
                  ],),
              ),
            ),
          ),
        )
    );
  }
}
