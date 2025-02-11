import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:wecare/app/modules/bloodDonation/views/blood_donation_view.dart';
import 'package:wecare/app/modules/booksDonation/views/books_donation_view.dart';
import 'package:wecare/app/modules/clotheDonation/views/clothe_donation_view.dart';
import 'package:wecare/app/modules/foodDonation/views/food_donation_view.dart';
import 'package:wecare/app/modules/medicalDonation/views/medical_donation_view.dart';
import 'package:wecare/app/resources/apiService.dart';
import '../../../../const.dart';
import '../controllers/select_interest_controller.dart';

class SelectInterestView extends GetView<SelectInterestController> {
  SelectInterestController interestController = Get.put(SelectInterestController());
  SelectInterestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final List pageList = [
      BloodDonationView(),
      BooksDonationView(),
      ClotheDonationView(),
      FoodDonationView(),
      MedicalDonationView(),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: InkWell(
            onTap: (){
              print('drawer Tapped');
              ZoomDrawer.of(context)?.toggle();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset('images/list.png',color: primColor),
            ),
          ),
          title: const Text(
            'Select Your Interest',
            style: headline,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: navAnimation(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 0,
                    child: Text(
                      'Choose your interest in which way you want to help people.',
                      style: headline1,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Obx(() {
                    return Expanded(
                      flex: 1,
                      child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                          ),
                          itemCount: interestController.interestList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () {
                                print(interestController.interestList[index].category);
                                Get.to(pageList[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        flex: 2,
                                        child: Image.network(
                                          ApiService().eventImages + interestController.interestList[index].image, color: primColor,)),
                                    SizedBox(height: size.width * 0.03,),
                                    Flexible(flex: 2,
                                        child: Text(interestController.interestList[index].category,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)))
                                  ],),
                              ),
                            );
                          }
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ));
  }
}
