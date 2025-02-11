// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare/app/modules/bottomBar/views/bottom_bar_view.dart';
import '../../../../const.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String demoImage =
        'https://i.pinimg.com/originals/61/f7/5e/61f75ea9a680def2ed1c6929fe75aeee.jpg';
    return Scaffold(
      bottomNavigationBar: navAnimation(Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () async {
            if (profileController.profileFormKey.currentState!.validate()) {
              profileController.sendUserProfile();
            } else {
              Get.snackbar(
                'Empty field\'s',
                'Check the field\'s which are empty',
                margin: const EdgeInsets.all(20),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withOpacity(0.6),
              );
            }
          },
          child: Obx(() {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: size.width * 0.14,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primColor,
                borderRadius: BorderRadius.circular(150),
              ),
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    profileController.isApiLoading == true
                        ? 'Saving'
                        : 'Continue',
                    style: buttonTitleStyleW,
                  )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: profileController.isApiLoading == true
                        ? LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.white, size: 25)
                        : const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                ],
              ),
            );
          }),
        ),
      )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Fill Your Profile',
          style: titleStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Profile View
                Obx(() {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      //Profile Photo
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: CircleAvatar(
                          backgroundColor: primColor,
                          radius: 100,
                          child: CircleAvatar(
                            radius: 95,
                            backgroundImage: profileController.profilePicture != ''
                                ? FileImage(File(
                                        profileController.profilePicture.value)) as ImageProvider
                                : const NetworkImage(demoImage),
                          ),
                        ),
                      ),
                      //Profile Edit Button
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              middleText: 'Select Image',
                              title: 'Update Profile Photo',
                              barrierDismissible: true,
                              radius: 5.0,
                              confirm: InkWell(
                                onTap: () {
                                  Get.back();
                                  profileController
                                      .getImage(ImageSource.gallery);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                      height: size.width * 0.25,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        color: primColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            CupertinoIcons.photo_on_rectangle,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              cancel: InkWell(
                                onTap: () {
                                  Get.back();
                                  profileController
                                      .getImage(ImageSource.camera);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                      height: size.width * 0.25,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        color: primColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            CupertinoIcons.camera_on_rectangle,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Camera",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )
                                        ],
                                      )),
                                ),
                              ));
                        },
                        child: Container(
                            height: size.width / 12,
                            width: size.width / 5,
                            decoration: BoxDecoration(
                                color: primColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Center(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            )),
                      ),
                    ],
                  );
                }),
                SizedBox(height: size.width * 0.05),
                Form(
                  key: profileController.profileFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      SizedBox(height: size.width * 0.05),
                      //Name TextField
                      TextFormField(
                        controller: profileController.userNameController,
                        validator: (value) {
                          if (value!.length < 5) {
                            return 'Add At least 5 letters';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Full Name',
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
                      SizedBox(height: size.width * 0.05),
                      //Email
                      TextFormField(
                        controller: profileController.emailIdController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.grey.shade400),
                          suffixIcon: Icon(
                            CupertinoIcons.mail,
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
                      SizedBox(height: size.width * 0.05),
                      //Mobile Number
                      Container(
                        height: size.width * 0.14,
                        width: size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(700),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Here the mobile number is coming from shared preferences
                              Text(
                                profileController.userMobileNumber.value != ''
                                    ? '+91-${profileController.userMobileNumber}'
                                    : '+91-000 000 0000',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Icon(
                                Icons.phone_android,
                                color: Colors.grey.shade400,
                              )
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.width * 0.05),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Obx(() {
                          return DropdownButton2(
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            isExpanded: true,
                            isDense: true,
                            value: profileController.genderSelect.value,
                            hint: Text(
                              'Select Gender',
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 16),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            onChanged: (value) {
                              profileController.genderSelect.value =
                                  value.toString();
                            },
                            items: <String>['Male', 'Female', 'Select Gender']
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
