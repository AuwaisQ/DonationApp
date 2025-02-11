// ignore_for_file: must_be_immutable
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../../../../const.dart';
import '../controllers/books_donation_controller.dart';

class BooksDonationView extends GetView<BooksDonationController> {
  BooksDonationController booksController = Get.put(BooksDonationController());
  BooksDonationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              booksController.description.clear();
              booksController.booksQuantity.clear();
              booksController.contactName.clear();
              booksController.contactNumber.clear();
              booksController.selectCategory.value = 'Select Type';
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Donate Stationery',
            style: headline,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Blood Donation Image
                  Padding(padding: const EdgeInsets.all(20.0), child: Lottie.asset('lottiefiles/books.json',fit: BoxFit.cover),),
                  SizedBox(height: size.width * 0.01,),
                  const Text('Select Category',style: headline1,),
                  SizedBox(height: size.width * 0.02,),
                  //Drop-Down Widget
                  Container(
                    height: size.width / 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(700),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Obx(() {
                            return DropdownButton2(
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              isExpanded: true,
                              isDense: true,
                              value: booksController.selectCategory.value,
                              hint: Text(
                                'Select Category',
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 16),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                              onChanged: (value) {
                                booksController.selectCategory.value =
                                    value.toString();
                              },
                              items: <String>[
                                'ICSE',
                                'CBSE',
                                'MP-Board',
                                'College',
                                'Others',
                                'Select Type'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.05,),
                  Form (
                    key: booksController.medicalDonationFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: headline1,
                        ),
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        //Description TextField
                        TextFormField(
                          controller: booksController.description,
                          validator: (value) {
                            if (value!.length < 5) {
                              return 'Add At least 5 characters';
                            }
                          },
                          maxLength: 50,
                          maxLines: 2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Donation Description..',
                            labelStyle: TextStyle(color: Colors.grey.shade400),
                            suffixIcon: const Icon(
                              CupertinoIcons.decrease_indent,
                              color: primColor,
                            ),
                            counterText: '',
                            alignLabelWithHint: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: primColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        const Text(
                          'Contact Detail\'s',
                          style: headline1,
                        ),
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        //Contact Name
                        TextFormField(
                          controller: booksController.contactName,
                          validator: (value) {
                            if (value!.length < 5) {
                              return 'Add At least 5 characters';
                            }
                          },
                          maxLength: 20,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Contact Name',
                            labelStyle: TextStyle(color: Colors.grey.shade400),
                            suffixIcon: Icon(
                              CupertinoIcons.person_add,
                              color: Colors.grey.shade400,
                            ),
                            counterText: '',
                            alignLabelWithHint: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: primColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        //Contact Number
                        TextFormField(
                          controller: booksController.contactNumber,
                          validator: (value) {
                            if (value!.length < 10) {
                              return 'Add At least 10 Digit\'s';
                            }
                          },
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Contact Number',
                            labelStyle: TextStyle(color: Colors.grey.shade400),
                            suffixIcon: Icon(
                              CupertinoIcons.device_phone_portrait,
                              color: Colors.grey.shade400,
                            ),
                            counterText: '',
                            alignLabelWithHint: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: primColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        //Location TextField
                        TextFormField(
                          controller: booksController.booksQuantity,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Add At least 1 Digit';
                            }
                          },
                          maxLength: 30,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Books Quantity',
                            labelStyle: TextStyle(color: Colors.grey.shade400),
                            suffixIcon: Icon(
                              Icons.scale,
                              color: Colors.grey.shade400,
                            ),
                            counterText: '',
                            alignLabelWithHint: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: primColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return InkWell(
                      onTap: () {
                        if (booksController.medicalDonationFormKey.currentState!.validate() && booksController.selectCategory.value != 'Select Type') {
                          booksController.getBooksEnquiry();
                        } else {
                          Get.snackbar(
                            'Incorrect Format',
                            'Please fill the form correctly',
                            margin: const EdgeInsets.all(20),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withOpacity(0.6),
                          );
                        }
                      },
                      child: Container(
                        height: size.width * 0.13,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: primColor,
                        ),
                        child: Stack(
                          children: [
                            Center(
                                child: Text(
                              booksController.isApiLoading.value == true
                                  ? 'Sending'
                                  : 'Send Request',
                              style: buttonTitleStyleW,
                            )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: booksController.isApiLoading.value == true
                                    ? LoadingAnimationWidget.threeArchedCircle(
                                        color: Colors.white, size: 25)
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: size.width * 0.02,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
