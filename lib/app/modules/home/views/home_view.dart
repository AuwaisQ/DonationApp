import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:light_carousel/light_carousel.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare/app/modules/aboutUs/views/about_us_view.dart';
import 'package:wecare/app/resources/apiService.dart';
import 'package:wecare/const.dart';
import '../../appMenu/controllers/app_menu_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController homeController = Get.put(HomeController());
  AppMenuController menuController = Get.put(AppMenuController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return RefreshIndicator(
      displacement: 100,
      backgroundColor: primColor,
      color: Colors.white,
      strokeWidth: 3,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        await homeController.getBanners();
        await homeController.getUpcomingEvent();
        await homeController.getCompletedEvent();
        final prefs = await SharedPreferences.getInstance();
        homeController.userImage.value = prefs.getString('userImage')!;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                print('drawer Tapped');
                ZoomDrawer.of(context)?.toggle();
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Image.asset('images/list.png', color: primColor),
              ),),
            title: const Text(
              'HAMDAM FOUNDATION',
              style: headline,
            ),
            actions:[
              InkWell(
                onTap: (){
                  Get.to(AboutUsView());
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('images/hamdam.jpeg'),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 3, right: 3, top: 10),
              child: Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: size.width * 0.5,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Obx(() {
                        return CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            enableInfiniteScroll: true,
                          ),
                          items: List.generate(homeController.bannerList.length,
                                  (index) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: ApiService().bannerImages +
                                          homeController.bannerList[index].files,
                                      placeholder: (context, url) =>
                                          Lottie.asset(
                                            'lottiefiles/shimmer.json',
                                            width: size.width,
                                            fit: BoxFit.cover,
                                          ),
                                    ));
                              }),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: size.width * 0.03),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            '• Upcoming Event\'s',
                            style: titleStyle,
                          ),
                          SizedBox(height: size.width * 0.02),
                          //Upcoming Events
                          Obx(() {
                            return SizedBox(
                              height: size.width * 0.6,
                              width: size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.upcomingEvents.length,
                                itemBuilder: (BuildContext ctx, i) {
                                  return InkWell(
                                    onTap: () {
                                      Get.bottomSheet(
                                        Container(
                                          height: size.height,
                                          width: size.width,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 0,
                                                  child: Stack(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: Text(
                                                          'Event Overview',
                                                          style: titleStyle,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                        Alignment.topRight,
                                                        child: InkWell(
                                                            onTap: () =>
                                                                Get.back(),
                                                            child: const Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                              child: Icon(
                                                                Icons
                                                                    .close_rounded,
                                                                color: primColor,
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            SizedBox(
                                                                height: size
                                                                    .width *
                                                                    0.05),
                                                            Container(
                                                              height:
                                                              size.width * 0.5,
                                                              width: size.width,
                                                              decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      10),
                                                                  image:
                                                                  DecorationImage(
                                                                      image:
                                                                      NetworkImage(
                                                                        ApiService()
                                                                            .eventImages +
                                                                            homeController
                                                                                .upcomingEvents[i]
                                                                                .file,
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover)),
                                                            ),
                                                            SizedBox(
                                                                height: size
                                                                    .width *
                                                                    0.03),
                                                            //Title
                                                            const Text(
                                                              '• Title',
                                                              style: headline,
                                                            ),
                                                            Text(
                                                              '   ${homeController
                                                                  .completedEvents[i]
                                                                  .title}',
                                                              style: subTitle,
                                                            ),
                                                            SizedBox(
                                                                height: size
                                                                    .width *
                                                                    0.03),
                                                            //Description
                                                            const Text(
                                                              '• Description',
                                                              style: headline,
                                                            ),
                                                            Text(
                                                              '   ${homeController
                                                                  .completedEvents[i]
                                                                  .description}',
                                                              style: subTitle,
                                                            ),
                                                            SizedBox(
                                                                height: size
                                                                    .width *
                                                                    0.03),
                                                            //Contact Person
                                                            const Text(
                                                              '• Contact Person',
                                                              style: headline,
                                                            ),
                                                            Text(
                                                              '   ${homeController
                                                                  .completedEvents[i]
                                                                  .contact_person}',
                                                              style: subTitle,
                                                            ),
                                                            SizedBox(
                                                                height: size
                                                                    .width *
                                                                    0.03),
                                                            //Contact
                                                            const Text(
                                                              '• Contact',
                                                              style: headline,
                                                            ),
                                                            Text(
                                                              '   ${homeController
                                                                  .completedEvents[i]
                                                                  .contact}',
                                                              style: subTitle,
                                                            ),
                                                            SizedBox(
                                                                height: size
                                                                    .width *
                                                                    0.03),
                                                            //Date
                                                            const Text(
                                                              '• Date',
                                                              style: headline,
                                                            ),
                                                            Text(
                                                              '   ${homeController
                                                                  .completedEvents[i]
                                                                  .date}',
                                                              style: subTitle,
                                                            ),
                                                            SizedBox(
                                                                height: size
                                                                    .width *
                                                                    0.03),
                                                            //Address
                                                            const Text(
                                                              '• Address',
                                                              style: headline,
                                                            ),
                                                            Text(
                                                              '   ${homeController
                                                                  .completedEvents[i]
                                                                  .venue}',
                                                              style: subTitle,
                                                            ),
                                                            SizedBox(
                                                                height: size
                                                                    .width *
                                                                    0.03),
                                                          ],
                                                        ))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: ClipRRect(
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    topLeft: Radius.circular(20),
                                                  ),
                                                  child: FadeInImage.assetNetwork(
                                                    fadeInDuration:
                                                    const Duration(
                                                        milliseconds: 200),
                                                    placeholder:
                                                    'images/appLogo.png',
                                                    image:
                                                    ApiService().eventImages +
                                                        homeController
                                                            .upcomingEvents[i]
                                                            .file,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10, bottom: 3),
                                                  child: Text(
                                                    homeController
                                                        .upcomingEvents[i].title,
                                                    style: headline1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.5,
                                                  child: Text(
                                                    homeController
                                                        .upcomingEvents[i]
                                                        .description,
                                                    style: subTitle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                          SizedBox(height: size.width * 0.05),
                          const Text('• Completed Event\'s', style: titleStyle),
                          SizedBox(height: size.width * 0.02),
                          //Completed Events
                          Obx(() {
                            return SizedBox(
                              height: size.width * 0.6,
                              width: size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.completedEvents.length,
                                itemBuilder: (BuildContext ctx, i) {
                                  return InkWell(
                                    onTap: () {
                                      print('Completed Event\'s Id - ${homeController.completedEvents[i].id}');
                                      homeController.getCompletedEventImages(homeController.completedEvents[i].id);
                                      Get.bottomSheet(
                                        Container(
                                          height: size.height / 2,
                                          width: size.width,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: Text(
                                                          homeController
                                                              .completedEvents[i]
                                                              .title,
                                                          style: titleStyle,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                        Alignment.topRight,
                                                        child: InkWell(
                                                            onTap: () =>
                                                                Get.back(),
                                                            child: const Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                              child: Icon(
                                                                Icons
                                                                    .close_rounded,
                                                                color: primColor,
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: size.width * 0.05),
                                                  //Completed Event images
                                                  Obx(() {
                                                    return SizedBox(
                                                      height: size.width * 0.7,
                                                      width: size.width,
                                                      child: LightCarousel(
                                                        boxFit: BoxFit.cover,
                                                        autoPlay: true,
                                                        animationCurve: Curves.linear,
                                                        animationDuration: const Duration(milliseconds: 300),
                                                        dotSize: 7.0,
                                                        dotBgColor: Colors.transparent,
                                                        dotIncreasedColor: primColor,
                                                        dotPosition: DotPosition.bottomCenter,
                                                        images: List.generate(homeController.completeEventImages.length, (index) {
                                                          return ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10),
                                                              child:
                                                              CachedNetworkImage(
                                                                fit: BoxFit.cover,
                                                                imageUrl: ApiService()
                                                                    .eventImages +
                                                                    homeController
                                                                        .completeEventImages[
                                                                    index]
                                                                        .image,
                                                                placeholder:
                                                                    (context,
                                                                    url) =>
                                                                    Lottie
                                                                        .asset(
                                                                      'lottiefiles/shimmer.json',
                                                                      width:
                                                                      size.width,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                              ));
                                                        }),
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: ClipRRect(
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    topLeft: Radius.circular(20),
                                                  ),
                                                  child: FadeInImage.assetNetwork(
                                                    fadeInDuration:
                                                    const Duration(
                                                        milliseconds: 200),
                                                    placeholder:
                                                    'images/appLogo.png',
                                                    image: ApiService().eventImages + homeController.completedEvents[i].file,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  child: Text(
                                                    homeController.completedEvents[i].title,
                                                    style: headline1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.5,
                                                  child: Text(
                                                    homeController.completedEvents[i].description,
                                                    style: subTitle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                          SizedBox(height: size.width * 0.03),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
