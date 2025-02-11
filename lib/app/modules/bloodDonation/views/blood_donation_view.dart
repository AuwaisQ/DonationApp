// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../../../../const.dart';
import '../controllers/blood_donation_controller.dart';

class BloodDonationView extends GetView<BloodDonationController> {
  BloodDonationController donationController = Get.put(
      BloodDonationController());

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
            donationController.bloodDonation[0].isGroupSelected = false;
            donationController.bloodDonation[1].isGroupSelected = false;
            donationController.bloodDonation[2].isGroupSelected = false;
            donationController.bloodDonation[3].isGroupSelected = false;
            donationController.bloodDonation[4].isGroupSelected = false;
            donationController.bloodDonation[5].isGroupSelected = false;
            donationController.bloodDonation[6].isGroupSelected = false;
            donationController.bloodDonation[7].isGroupSelected = false;
            donationController.bloodUnitsController.clear();
            donationController.contactName.clear();
            donationController.contactNumber.clear();
            donationController.location.clear();
            Get.back();
          },
          child: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: const Text(
          'Need of Blood',
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
                  child: Lottie.asset('lottiefiles/blood.json'),
                ),
                SizedBox(height: size.width * 0.05,),
                const Text('Select Blood Group', style: headline1,),
                SizedBox(height: size.width * 0.05,),
                //Blood Group
                SizedBox(
                  height: size.width * 0.25,
                  width: size.width,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1 / 0.5
                    ),
                    itemCount: donationController.bloodDonation.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Obx(() {
                        return InkWell(
                          onTap: () {
                            donationController.bloodDonation[index].isGroupSelected = !donationController.bloodDonation[index].isGroupSelected;
                            donationController.bloodDonation.refresh();
                            donationController.selectedBloodGroup.value = donationController.bloodDonation[index].bloodGroup.toString();
                            print('Selected Blood Group:- ${donationController.selectedBloodGroup}');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: donationController.selectedBloodGroup.value == donationController.bloodDonation[index].bloodGroup
                                        ? primColor
                                        : Colors.grey
                                ),
                                color: donationController.selectedBloodGroup.value == donationController.bloodDonation[index].bloodGroup
                                    ? primColor
                                    : Colors.white
                            ),
                            child: Center(child: Text(
                                donationController.bloodDonation[index]
                                    .bloodGroup,
                                style: donationController.selectedBloodGroup.value == donationController.bloodDonation[index].bloodGroup
                                    ? buttonTitleStyleW
                                    : buttonTitleStyleG
                            )),
                          ),
                        );
                      });
                    },
                  ),
                ),
                SizedBox(height: size.width * 0.05,),
                Form(
                  key: donationController.bloodDonationFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select No. of Units', style: headline1,),
                      SizedBox(height: size.width * 0.02,),
                      //Unit's TextField
                      TextFormField(
                        controller: donationController.bloodUnitsController,
                        validator: (value) {
                          if (value!.isEmpty || value!.length > 2) {
                            return 'Add At least 1 characters';
                          }else if(int.parse(value) < 1 || int.parse(value) > 10){
                            return 'Maximum 10 units accepted';
                          }
                        },
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Number Of Units',
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
                        controller: donationController.contactName,
                        validator: (value) {
                          if (value!.length < 3) {
                            return 'Add At least 3 characters';
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
                        controller: donationController.contactNumber,
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
                      SizedBox(height: size.width * 0.05,),
                      //Location TextField
                      TextFormField(
                        controller: donationController.location,
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
                InkWell(
                  onTap: () {
                    if (donationController.bloodDonationFormKey.currentState!.validate() && donationController.selectedBloodGroup.value != '') {
                      donationController.getBloodEnquiry();
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
                                donationController.isApiLoading == true
                                    ? 'Sending'
                                    : 'Send Request',
                                style: buttonTitleStyleW,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: donationController.isApiLoading == true
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
                SizedBox(height: size.width * 0.02,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
