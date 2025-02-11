import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../const.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  HistoryController historyController = Get.put(HistoryController());
  HistoryView({Key? key}) : super(key: key);
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
      onRefresh: () async{
        await Future.delayed(const Duration(milliseconds: 300));
        historyController.fetchPendingRequest(historyController.userId.toString());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primColor,
          title: const Text('Request\'s'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Obx(() {
            return historyController.completedRequestList.isEmpty
                ? Center(child: Lottie.asset('lottiefiles/noData.json',height: 300,width:size.width,))
                : ListView.builder(
              itemCount: historyController.completedRequestList.length,
              itemBuilder: (ctx, index) {
                return Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: primColor, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          //Contact Name
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Text(
                                  'Contact Name: ',
                                  style: headline1,
                                ),
                                Text(
                                  historyController.completedRequestList[index]
                                      .contact_name.toString(),
                                  style: subTitle,
                                ),
                              ],
                            ),
                          ),
                          //Request Type
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Text(
                                  'Request Type: ',
                                  style: headline1,
                                ),
                                Text(
                                  historyController.completedRequestList[index]
                                      .donation_type.toString(),
                                  style: subTitle,
                                ),
                              ],
                            ),
                          ),
                          //Request Type
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Text(
                                  'Request Date: ',
                                  style: headline1,
                                ),
                                Text(
                                  historyController.completedRequestList[index]
                                      .date.toString(),
                                  style: subTitle,
                                ),
                              ],
                            ),
                          ),
                          //Request Type
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Text(
                                  'Request Status: ',
                                  style: headline1,
                                ),
                                Text(
                                  historyController.rMsg.value,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red.shade800,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      height: 1.5,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            );
          }),
        ),
      ),
    );
  }
}
