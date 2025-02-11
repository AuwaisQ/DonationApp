import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wecare/const.dart';

import '../controllers/pending_request_controller.dart';

class PendingRequestView extends GetView<PendingRequestController> {
  PendingRequestController pendingRequestController = Get.put(
      PendingRequestController());

  PendingRequestView({Key? key}) : super(key: key);

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
        pendingRequestController.fetchPendingRequest(pendingRequestController.userId.toString());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primColor,
          title: const Text('Request\'s'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Obx(() {
            return pendingRequestController.pendingRequestList.isEmpty
            ? Center(child: Lottie.asset('lottiefiles/noData.json',height: 300,width:size.width,))
            : ListView.builder(
              itemCount: pendingRequestController.pendingRequestList.length,
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
                                  pendingRequestController.pendingRequestList[index]
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
                                  pendingRequestController.pendingRequestList[index]
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
                                  pendingRequestController.pendingRequestList[index]
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
                                  pendingRequestController.rMsg.value,
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
