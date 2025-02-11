import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare/app/resources/apiService.dart';
import '../model/homePageModel.dart';

class HomeController extends GetxController {

  var bannerList = <GetBanner>[].obs;
  var completedEvents = <GetCompletedList>[].obs;
  var upcomingEvents = <GetUpcomingList>[].obs;
  var completeEventImages = <GetCompleteEventImages>[].obs;
  late PageController carouselController;
  var isApiLoading = false.obs;
  var userImage = ''.obs;
  int? userId;

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    getBanners();
    getUpcomingEvent();
    getCompletedEvent();
    userImage.value = prefs.getString('userImage')!;
    print('\n User Profile Image - $userImage');
    carouselController = PageController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    carouselController.dispose();
    super.onClose();
  }

  //Getting Home Page Banenrs
  getBanners() async {
    isApiLoading.value = true;
    var response = await ApiService().getBanners();
    print('\nHome Banners Response - ${response['status']}\n');
    bannerList.value = bannerListModelFromJson(jsonEncode(response['data']));
    isApiLoading.value = false;
  }

  //Geting Upcoming Event Images
  getUpcomingEvent() async {
    var response = await ApiService().getUpcomingList();
    print('\nUpcoming Event Response - $response\n');
    upcomingEvents.value = upcomingListModelFromJson(jsonEncode(response['data']));
  }

  //Geting Completed Event Images
  getCompletedEvent() async {
    var response = await ApiService().getCompletedList();
    print('\nCompleted Event Response - $response\n');
    completedEvents.value = completedListModelFromJson(jsonEncode(response['data']));
  }

  //Geting completed events images
  getCompletedEventImages(int id) async {
    var response = await ApiService().getcompleteEventImages(id);
    print('\nCompleted Event Response - ${response['data']}\n');
    completeEventImages.value = completedEeventsImageFromJson(jsonEncode(response['data']));
  }

}
