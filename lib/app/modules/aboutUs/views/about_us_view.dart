import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wecare/const.dart';
import '../../../resources/apiService.dart';
import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  AboutUsController aboutUsController = Get.put(AboutUsController());

  AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primColor,
          title: const Text('About Hamdam'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Carousel Slider
                  Container(
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
                        items: List.generate(aboutUsController.imageList.length,
                                (index) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: ApiService().eventImages +
                                        aboutUsController.imageList[index].image,
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
                  SizedBox(height: size.width * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Text('Description',style: headline,),
                    ],
                  ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(aboutUsController.aboutUsDescription.value,
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            height: 1.5,
                        )),
                    );
                  }),
                  SizedBox(height: size.width * 0.05),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Registration Certificate',style: headline,),
                    ],
                  ),
                  SizedBox(height: size.width * 0.03),
                  Image.asset('images/humdumCertificate.jpeg'),
                  SizedBox(height: size.width * 0.2),
                ],
              ),
            ),
          ),
        )
    );
  }
}
