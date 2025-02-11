import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wecare/const.dart';
import '../controllers/account_settings_controller.dart';

class AccountSettingsView extends GetView<AccountSettingsController> {
  AccountSettingsController accountSettingsController = Get.put(
      AccountSettingsController());

  AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    Widget buttonWidget(
        {required IconData icon, required String title, required GestureTapCallback onTap}) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: size.width * 0.13,
          width: size.width,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF24C066).withOpacity(0.4)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(icon, size: 20, color: primColor),
                SizedBox(width: size.width * 0.05),
                Text(title, style: subTitle)
              ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: primColor,
                size: 17,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primColor,
          title: const Text('Account Settings'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                //Privacy Policy
                buttonWidget(
                  icon: Icons.document_scanner_outlined,
                  title: 'Privacy policy',
                  onTap: () {
                    launchUrlString(
                        'https://wecare.developerzone.in/privacy_policy');
                  },
                ),
                SizedBox(height: size.width * 0.05,),
                //Account Settings
                buttonWidget(
                  icon: Icons.account_balance,
                  title: 'Terminate Account',
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        height: size.height,
                        width: size.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.width * 0.02,
                                ),
                                const Text(
                                  'Terminate Account',
                                  style: titleStyle,
                                ),
                                SizedBox(
                                  height: size.width * 0.02,
                                ),
                                const Text(
                                  '1. We collect your personal information so that we can provide you the service of our Application.',
                                  textAlign: TextAlign.center,
                                  style: headline1,
                                ),
                                SizedBox(
                                  height: size.width * 0.05,
                                ),
                                const Text(
                                  '2. We support account deletion in this app so that user can have full control over his personal information.',
                                  textAlign: TextAlign.center,
                                  style: headline1,
                                ),
                                SizedBox(
                                  height: size.width * 0.05,
                                ),
                                const Text(
                                  '3. Deleting an account removes the account from the developer’s records, along with any data associated with the account that the developer isn’t legally required to maintain.',
                                  textAlign: TextAlign.center,
                                  style: headline1,
                                ),
                                SizedBox(
                                  height: size.width * 0.05,
                                ),
                                const Text(
                                  '4. If you wish to terminate, we cannot reactivate your account, Your account data will be completely erased.',
                                  textAlign: TextAlign.center,
                                  style: headline1,
                                ),
                                SizedBox(
                                  height: size.width * 0.02,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          accountSettingsController.terminateAccount();
                                        },
                                        child: Obx(() {
                                          return Container(
                                            margin: const EdgeInsets.all(10),
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: primColor,
                                              borderRadius:
                                              BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                              child: accountSettingsController
                                                  .apiLoading.value == true
                                                  ? LoadingAnimationWidget
                                                  .threeArchedCircle(
                                                  color: Colors.white, size: 20)
                                                  : const Text(
                                                'Terminate',
                                                style: buttonTitleStyleW,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () async {
                                          Get.back();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: primColor,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Cancel',
                                              style: buttonTitleStyleW,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.width * 0.05,),
                //Developer Contact
                buttonWidget(
                  icon: Icons.groups_outlined,
                  title: 'Developer Contact',
                  onTap: () {
                    launchUrlString('https://manalsoftech.com');
                  },
                ),
                SizedBox(height: size.width * 0.05,),
                //Logout
                buttonWidget(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onTap: () {
                    Get.dialog(
                      barrierDismissible: true,
                      AlertDialog(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        content: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 75, left: 10),
                              child: Container(
                                height: 250,
                                width: 270,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding:
                                      EdgeInsets.only(top: 55, right: 5),
                                      child: Text(
                                        'Sure you want to\nLogOut',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () async {
                                                final prefs = await SharedPreferences.getInstance();
                                                prefs.clear();
                                                prefs.setBool("isLogin", false);
                                                SystemNavigator.pop();
                                                exit(0);
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(
                                                    10),
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: primColor,
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Logout',
                                                    style: buttonTitleStyleW,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () async {
                                                Get.back();
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(10),
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: primColor,
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Cancel',
                                                    style: buttonTitleStyleW,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //Logo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('lottiefiles/submited.json',
                                    height: 150, width: 150, fit: BoxFit.cover),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
