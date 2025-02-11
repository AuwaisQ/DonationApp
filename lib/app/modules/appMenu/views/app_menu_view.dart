// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wecare/app/modules/aboutUs/views/about_us_view.dart';
import 'package:wecare/app/modules/history/views/history_view.dart';
import 'package:wecare/app/modules/pendingRequest/views/pending_request_view.dart';
import '../../../../const.dart';
import '../../../resources/apiService.dart';
import '../../accountSettings/views/account_settings_view.dart';
import '../../onBoarding/views/on_boarding_view.dart';
import '../controllers/app_menu_controller.dart';

class AppMenuView extends GetView<AppMenuController> {
  AppMenuController menuController = Get.put(AppMenuController());

  AppMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    //Menu Widget
    Widget menuItem({required String title, required IconData icon}) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: primColor.withOpacity(0.5),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Profile Picture
                        Obx(() {
                          return CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              menuController.userImage.toString() == null
                                  ? 'images/appLogo.png'
                                  : ApiService().eventImages +
                                  menuController.userImage.toString(),
                            ),
                          );
                        }),
                        const SizedBox(height: 5),
                        //User Name
                        Obx(() {
                          return Text(
                            menuController.userName == null
                                ? 'User Name'
                                : menuController.userName.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5),
                          );
                        }),
                        const SizedBox(height: 1),
                        //User Email
                        Obx(() {
                          return Text(
                            menuController.userEmail == null
                                ? 'useremail@email.com'
                                : menuController.userEmail.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,

                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //My Request
                  InkWell(
                    onTap: () {
                      Get.to(PendingRequestView());
                      ZoomDrawer.of(context)?.toggle();
                    },
                    child: menuItem(
                      title: 'My Request\'s',
                      icon: Icons.receipt_long,
                    ),
                  ),
                  //My History
                  InkWell(
                    onTap: () {
                      Get.to(HistoryView());
                      ZoomDrawer.of(context)?.toggle();
                    },
                    child: menuItem(
                      title: 'My History',
                      icon: Icons.history,
                    ),
                  ),
                  //Share App
                  InkWell(
                    onTap: () async {
                      await FlutterShare.share(
                          title: 'HAMDAM',
                          text: 'https://play.google.com/store/apps/details?id=com.manal.hamdam'
                      );
                    },
                    child: menuItem(
                      title: 'Share App',
                      icon: Icons.share,
                    ),
                  ),
                  //Rate App
                  InkWell(
                    onTap: () {
                      print('Hamdam Play Store Link Tapped');
                      launchUrlString('https://play.google.com/store/apps/details?id=com.manal.hamdam');
                    },
                    child: menuItem(
                      title: 'Rate App',
                      icon: Icons.star_rate_outlined,
                    ),
                  ),
                  //Account Settings
                  InkWell(
                    onTap: () {
                      Get.to(AccountSettingsView());
                      ZoomDrawer.of(context)!.toggle();
                    },
                    child: menuItem(
                      title: 'Account\nSettings',
                      icon: Icons.account_balance,
                    ),
                  ),
                  const Divider(color: Colors.white,),
                  //About Us
                  InkWell(
                    onTap: () {
                      Get.to(
                          AboutUsView(), transition: Transition.leftToRight);
                      ZoomDrawer.of(context)?.toggle();
                    },
                    child: menuItem(
                      title: 'About Us',
                      icon: Icons.info_outline,
                    ),
                  ),
                  //Contact Us
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(Container(
                        height: size.width,
                        width: size.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: size.width * 0.02,),
                              const Text('Contact Details', style: titleStyle,),
                              SizedBox(height: size.width * 0.02,),
                              SizedBox(
                                height: size.width,
                                child: Obx(() {
                                  return ListView.builder(
                                    itemCount: menuController.contactDetails
                                        .length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                ApiService().eventImages + menuController
                                                    .contactDetails[index]
                                                    .image),
                                          ),
                                          title: Text(menuController
                                              .contactDetails[index].name,
                                            style: headline1,),
                                          trailing: InkWell(
                                              onTap: () {
                                                launchUrlString(
                                                    'tel:+91${menuController
                                                        .contactDetails[index]
                                                        .contact}');
                                              },
                                              child: const Icon(Icons.phone,
                                                color: primColor,)),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                            ],),
                        ),
                      ),
                      );
                    },
                    child: menuItem(
                      title: 'Contact Us',
                      icon: Icons.phone_android,
                    ),
                  ),
                ],
              ),
              //Promotion Button
              InkWell(
                onTap: () {
                  launchUrlString('https://manalsoftech.com');
                },
                child: Image.asset(
                  'images/poweredByManal.png',
                  height: size.width * 0.1,
                ),
              ),
            ],
          ),
        ));
  }
}
