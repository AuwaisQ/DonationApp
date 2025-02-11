// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:wecare/app/modules/bottomBar/views/bottom_bar_view.dart';
import 'package:wecare/const.dart';
import '../../appMenu/views/app_menu_view.dart';
import '../controllers/app_drawer_controller.dart';

class AppDrawerView extends GetView<AppDrawerController> {
  AppDrawerController drawerController = Get.put(AppDrawerController());
  AppDrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: primColor,
      body: ZoomDrawer(
        clipMainScreen: false,
        controller: drawerController.zoomDrawerController,
        showShadow: true,
        slideWidth: MediaQuery.of(context).size.width * 0.6,
        angle: 0,
        mainScreen: BottomBarView(),
        menuScreen: AppMenuView(),
      ),
    );
  }
}
