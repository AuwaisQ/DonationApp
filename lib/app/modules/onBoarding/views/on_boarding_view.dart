import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding_animation/onboarding_animation.dart';
import '../../../../const.dart';
import '../../login/views/login_view.dart';
import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: OnBoardingAnimation(
          pages: [
            OnBoarding(image: 'images/ob1.png', title: 'Donate easily, quickly, right on target with very few steps', buttonText: 'Skip',),
            OnBoarding(image: 'images/ob2.png', title: 'Create your own fundraising and publish it to the Application', buttonText: 'Skip'),
            OnBoarding(image: 'images/ob3.png', title: 'Trusted, transparent, and effective in sharing kindness', buttonText: 'Continue'),
          ],
          indicatorDotHeight: 10.0,
          indicatorDotWidth: 10.0,
          indicatorActiveDotColor: primColor,
          indicatorInActiveDotColor: primColor,
          indicatorType: IndicatorType.expandingDots,
          indicatorPosition: IndicatorPosition.bottomCenter,
        ),
      ),
    );
  }
}

class OnBoarding extends StatelessWidget {
  String image;
  String title;
  String buttonText;
  OnBoarding({
  required this.image,
  required this.title,
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          //Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 50),
            child: Image.asset(image),
          ),
          SizedBox(height: width * 0.1),
          Column(children: [
            //Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: primColor,fontWeight: FontWeight.bold,fontSize: 25,letterSpacing: 0.5),
              ),
            ),
          ],),
          const Spacer(),
          InkWell(
            onTap: ()=> Get.to(const LoginView(),transition: Transition.downToUp),
            child: Container(
              margin: const EdgeInsets.only(bottom: 25,left: 20,right: 20),
              height: width* 0.12,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: primColor,
              ),
              child: Center(child: Text(buttonText,style: buttonTitleStyleW,),),
            ),
          ),
        ],
      ),
    );
  }
}
