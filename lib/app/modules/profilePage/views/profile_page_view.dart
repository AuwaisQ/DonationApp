// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wecare/app/resources/apiService.dart';
import 'package:wecare/const.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  ProfilePageController profileController = Get.put(ProfilePageController());

  ProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    const String demoImage =
        'https://i.pinimg.com/originals/61/f7/5e/61f75ea9a680def2ed1c6929fe75aeee.jpg';
    return RefreshIndicator(
      displacement: 100,
      backgroundColor: primColor,
      color: Colors.white,
      strokeWidth: 3,
      onRefresh: () async {
        await profileController
            .fetchProfile(profileController.userId.toString());
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: primColor,
            leading: InkWell(
              onTap: () {
                print('drawer Tapped');
                print(profileController.userId.toString());
                ZoomDrawer.of(context)?.toggle();
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Image.asset('images/list.png', color: Colors.white),
              ),
            ),
            title: const Text(
              'Profile Page',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            actions: [
              Obx(() {
                return Stack(children: [
                  profileController.isImageLoading.value == true
                      ? TextButton(
                      onPressed: () {
                        profileController.updateProfile();
                      },
                      child: Stack(
                        children: [
                          Center(
                              child: Text(
                                profileController.isApiLoading == false
                                    ? 'Save'
                                    : 'Saving',
                                style: const TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: profileController.isApiLoading == true
                                  ? LoadingAnimationWidget.threeArchedCircle(
                                  color: Colors
                                      .white, size: 15)
                                  : Container(),
                            ),
                          ),
                        ],
                      ),)
                      : Container()
                ],);
              })
            ],
          ),
          body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: primColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  navAnimation(
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                        backgroundImage:
                                        profileController.profilePicture != ''
                                            ? FileImage(File(profileController
                                            .profilePicture
                                            .value)) as ImageProvider
                                            : NetworkImage(
                                            ApiService().eventImages +
                                                profileController
                                                    .userImage.value),
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
                                                  .getImage(
                                                  ImageSource.gallery);
                                            },
                                            child: Card(
                                              elevation: 5,
                                              child: Container(
                                                  height: size.width * 0.25,
                                                  width: size.width * 0.25,
                                                  decoration: BoxDecoration(
                                                    color: primColor,
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: const [
                                                      Icon(
                                                        CupertinoIcons
                                                            .photo_on_rectangle,
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
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: const [
                                                      Icon(
                                                        CupertinoIcons
                                                            .camera_on_rectangle,
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
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        child: const Center(
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            }),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.width * 0.05),
                                const Text(
                                  '  User Name',
                                  style: headline,
                                ),
                                SizedBox(height: size.width * 0.01),
                                Container(
                                  height: size.width * 0.15,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey.shade300),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() {
                                          return Text(
                                              profileController.userName
                                                  .value != ''
                                                  ? profileController.userName
                                                  .value
                                                  .toString()
                                                  : 'User Name',
                                              style: subTitle);
                                        }),
                                        Image.asset(
                                          'images/user.png',
                                          color: primColor,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.width * 0.05),
                                const Text(
                                  '  Email',
                                  style: headline,
                                ),
                                SizedBox(height: size.width * 0.01),
                                Container(
                                  height: size.width * 0.15,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey.shade300),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() {
                                          return Text(
                                              profileController.userEmail
                                                  .value !=
                                                  ''
                                                  ? profileController
                                                  .userEmail.value
                                                  .toString()
                                                  : 'User Email',
                                              style: subTitle);
                                        }),
                                        Image.asset(
                                          'images/email.png',
                                          color: primColor,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.width * 0.05),
                                const Text(
                                  '  Mobile Number',
                                  style: headline,
                                ),
                                SizedBox(height: size.width * 0.01),
                                Container(
                                  height: size.width * 0.15,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey.shade300),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() {
                                          return Text(
                                              profileController.userMobile
                                                  .value !=
                                                  ''
                                                  ? '+91-${profileController
                                                  .userMobile.value}'
                                                  : '+91-0000 0000 00',
                                              style: subTitle);
                                        }),
                                        Image.asset(
                                          'images/phone.png',
                                          color: primColor,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.width * 0.05),
                                const Text(
                                  '  Gender',
                                  style: headline,
                                ),
                                SizedBox(height: size.width * 0.01),
                                Container(
                                  height: size.width * 0.15,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey.shade300),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() {
                                          return Text(
                                              profileController.userGender
                                                  .value !=
                                                  ''
                                                  ? profileController
                                                  .userGender.value
                                                  .toString()
                                                  : 'Select Gender',
                                              style: subTitle);
                                        }),
                                        Image.asset(
                                          'images/gender.png',
                                          color: primColor,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.width * 0.05),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
