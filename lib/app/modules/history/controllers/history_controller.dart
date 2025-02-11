import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/apiService.dart';
import '../model/historyList.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController
  int? userId;
  var rMsg = ''.obs;
  var completedRequestList = <CompledtedRequest>[].obs;
  final count = 0.obs;
  @override
  void onInit() async{
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
    var response = await ApiService().completeReques(userId);
    print('In App Profile Responce - $response');
    //fetching response and assigning value
    completedRequestList.value = compledtedRequestListModelFromJson(jsonEncode(response['Data']));
    rMsg.value = response['msg'];
  }

  void increment() => count.value++;
}
