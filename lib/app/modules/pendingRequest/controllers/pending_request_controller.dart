// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/apiService.dart';
import '../model/pendingRequestModel.dart';

class PendingRequestController extends GetxController {
  //TODO: Implement PendingRequestController
  int? userId;
  var rMsg = ''.obs;
  var pendingRequestList = <PendingRequest>[].obs;
  final count = 0.obs;

  @override
  void onInit()async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('UserId');
    print(userId.toString());
    fetchPendingRequest(userId.toString());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchPendingRequest(String userId) async {
    //Giving response to api after getting userId
    var response = await ApiService().pendingRequest(userId);
    print('In App Profile Responce - $response');
    //fetching response and assigning value
    pendingRequestList.value = pendingRequestListModelFromJson(jsonEncode(response['Data']));
    rMsg.value = response['msg'];
  }

  void increment() => count.value++;
}
