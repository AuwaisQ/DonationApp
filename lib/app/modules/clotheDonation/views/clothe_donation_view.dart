// ignore_for_file: unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../const.dart';
import '../controllers/clothe_donation_controller.dart';

class ClotheDonationView extends GetView<ClotheDonationController> {
  ClotheDonationController clotheController  = Get.put(ClotheDonationController());
  ClotheDonationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: primColor,
            ),
          ),
          title: const Text(
            'Cloth Donation',
            style: titleStyle,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: SingleChildScrollView(
              child: Form(
                key: clotheController.foodDonationFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/clothDonation.jpg',
                        height: size.width * 0.6,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    const Text(
                      'Clothes Quantity',
                      style: headline1,
                    ),
                    SizedBox(
                      height: size.width * 0.02,
                    ),
                    //No. of clothes
                    TextFormField(
                      controller: clotheController.clothQuantity,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Add At least 1 digit';
                        }else if(int.parse(value) < 1 || int.parse(value) > 100) {
                          return 'Maximum 100 Quantity accepted';
                        }
                        return null;
                      },
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Clothes Quantity',
                        labelStyle: TextStyle(color: Colors.grey.shade400),
                        suffixIcon: const Icon(
                          Icons.checkroom,
                          color: primColor,
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
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    const Text(
                      'Contact Detail\'s',
                      style: headline1,
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    //Contact Name
                    TextFormField(
                      controller: clotheController.contactName,
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
                      controller: clotheController.contactNumber,
                      validator: (value) {
                        if (value!.length < 10) {
                          return 'Add At least 10 Number';
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
                      controller: clotheController.contactAddress,
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
                    //Continue Button
                    InkWell(
                      onTap: (){
                        if(clotheController.foodDonationFormKey.currentState!.validate()){
                          clotheController.postClothEnquiry();
                        }else{
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
                                    clotheController.isApiLoading == true
                                        ? 'Sending'
                                        : 'Send Request',
                                    style: buttonTitleStyleW,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: clotheController.isApiLoading == true
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
