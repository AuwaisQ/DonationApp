// ignore_for_file: use_key_in_widget_constructors
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wecare/app/modules/profilePage/views/profile_page_view.dart';
import 'package:wecare/app/modules/selectInterest/views/select_interest_view.dart';
import 'package:wecare/const.dart';
import '../../home/views/home_view.dart';
import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  BottomBarController barController = Get.put(BottomBarController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //Exit Dialog
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              content: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  //Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white.withOpacity(1.0),
                        backgroundImage: const AssetImage('images/hamdam.jpeg'),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 115, left: 70),
                    child: Text(
                      'Exit HAMDAM ?',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 150,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text(
                              'Cancel',
                              style: buttonTitleStyleG,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              'Exit App',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ) ??
          false; //if showDialog had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: PageView(
            controller: barController.pageController,
            children: [HomeView(), SelectInterestView(), ProfilePageView()],
          ),
          floatingActionButton: SpeedDial(
            closedForegroundColor: Colors.white,
            openForegroundColor: Colors.white,
            closedBackgroundColor: Colors.white,
            openBackgroundColor: Colors.white,
            labelsStyle: headline1,
            labelsBackgroundColor: Colors.white,
            speedDialChildren: <SpeedDialChild>[
              SpeedDialChild(
                child: const Icon(Icons.health_and_safety_outlined),
                foregroundColor: Colors.white,
                backgroundColor: primColor,
                label: 'Ambulance',
                onPressed: () {
                    launchUrlString('tel:108');
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.local_police_outlined),
                foregroundColor: Colors.white,
                backgroundColor: primColor,
                label: 'Air Ambulance',
                onPressed: () {
                  launchUrlString('tel:9540161344');
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.local_police_outlined),
                foregroundColor: Colors.white,
                backgroundColor: primColor,
                label: 'Police',
                onPressed: () {
                  launchUrlString('tel:100');
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.fire_truck),
                foregroundColor: Colors.white,
                backgroundColor: primColor,
                label: 'Fire Brigade',
                onPressed: () {
                  launchUrlString('tel:101');
                },
              ),
              //  Your other SpeedDialChildren go here.
            ],
            child: Lottie.asset(
              'lottiefiles/sos.json',
              fit: BoxFit.cover,
            ),
          ),
          // InkWell(
            // onTap: () {
            //   print('SOS Pressed');
            //   launchUrlString('tel:108');
            // },
          // ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: Obx(() {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  border: Border.all(color: primColor, width: 2)),
              child: BubbleBottomBar(
                elevation: 15.0,
                backgroundColor: Colors.white,
                fabLocation: BubbleBottomBarFabLocation.end,
                opacity: 0.2,
                currentIndex: barController.currentIndex.value,
                onTap: (index) {
                  barController.currentIndex.value = index!;
                  barController.pageController.jumpToPage(index);
                },
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                items: <BubbleBottomBarItem>[
                  BubbleBottomBarItem(
                      backgroundColor: primColor,
                      icon: Icon(
                        CupertinoIcons.house_alt_fill,
                        color: primColor.withOpacity(0.4),
                      ),
                      activeIcon: const Icon(
                        CupertinoIcons.house_alt_fill,
                        color: primColor,
                      ),
                      title: const Text(
                        "Home",
                        style: TextStyle(fontSize: 12),
                      )),
                  BubbleBottomBarItem(
                      backgroundColor: primColor,
                      icon: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: primColor.withOpacity(0.4),
                      ),
                      activeIcon: const Icon(
                        CupertinoIcons.add_circled_solid,
                        color: primColor,
                      ),
                      title: const Text("My Interest",
                          style: TextStyle(fontSize: 12))),
                  BubbleBottomBarItem(
                      backgroundColor: primColor,
                      icon: Icon(
                        CupertinoIcons.person_alt,
                        color: primColor.withOpacity(0.4),
                      ),
                      activeIcon: const Icon(
                        CupertinoIcons.person_alt,
                        color: primColor,
                      ),
                      title: const Text("Profile",
                          style: TextStyle(fontSize: 12))),
                ],
              ),
            );
          }),
        ));
  }
}
