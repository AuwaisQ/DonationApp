// ignore_for_file: unrelated_type_equality_checks

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wecare/const.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    final size = MediaQuery.of(context).size;

    //Login Widget
    Widget loginScreen() {
      return Obx(() {
        return DelayedDisplay(
          slidingBeginOffset: const Offset(0, -0.4),
          delay: const Duration(milliseconds: 300),
          child: Form(
            key: loginController.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login Now',
                  style: titleStyle,
                ),
                SizedBox(height: size.width / 30),
                const Text(
                  'Please enter mobile number to login',
                  textAlign: TextAlign.center,
                  style: subTitle,
                ),
                SizedBox(height: size.width / 30),
                ///Mobile Number TextField
                SizedBox(
                  width: size.width,
                  height: size.width / 7,
                  child: TextFormField(
                    maxLength: 10,
                    controller: loginController.phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      counterText: '',
                      alignLabelWithHint: true,
                      labelText: 'Enter Mobile Number',
                      suffixIcon: const Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(150),
                        borderSide: const BorderSide(
                          color: primColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(150),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      print(
                          'Phone Number :- ${loginController.phoneNumber.text}');
                      await loginController.signInPhoneNumber(
                          myPhoneNumber: loginController.phoneNumber.text);
                      // loginController.isLoading.value = true;
                    },
                    child: DelayedDisplay(
                      slidingBeginOffset: const Offset(0, -0.4),
                      delay: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: size.width / 7,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primColor,
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: loginController.isLoading.value == true
                            ? Stack(
                                children: [
                                  const Center(
                                      child: Text(
                                    'Please Wait',
                                    style: buttonTitleStyleW,
                                  )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: LoadingAnimationWidget
                                        .threeArchedCircle(
                                            color: Colors.white, size: 30),
                                  )
                                ],
                              )
                            : Stack(
                                children: const[
                                  Center(
                                      child: Text(
                                              'Request OTP',
                                              style: buttonTitleStyleW,
                                            )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
    //Otp Widget
    Widget otpScreen() {
      return DelayedDisplay(
        slidingBeginOffset: const Offset(0, -0.4),
        delay: const Duration(milliseconds: 300),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verification Code',
                style: titleStyle,
              ),
            ),
            SizedBox(height: size.width / 25),
            Text.rich(
              TextSpan(
                  text: 'The confirmation code is sent to ',
                  style: subTitle,
                  children: [
                    TextSpan(
                        text:
                            'Mobile Number +91-${loginController.phoneNumber.text}. ',
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    const TextSpan(
                      text: 'Please enter it below.',
                      style: subTitle,
                    )
                  ]),
            ),
            SizedBox(height: size.width / 20),
            //OTP TextField
            PinCodeTextField(
              controller: loginController.codeController,
              appContext: context,
              length: 6,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: size.width * 0.15,
                fieldWidth: size.width * 0.12,
                selectedFillColor: Colors.white,
                selectedColor: primColor,
                inactiveColor: Colors.grey.shade400,
                inactiveFillColor: Colors.white,
                activeColor: primColor,
                activeFillColor: Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              onCompleted: (_) {
                loginController.codeController.value;
              },
              beforeTextPaste: (text) {
                debugPrint("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
            SizedBox(height: size.width / 20),
            //OTP Verification Button
            DelayedDisplay(
              slidingBeginOffset: const Offset(0, -0.4),
              delay: const Duration(milliseconds: 300),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton.extended(
                    backgroundColor: primColor,
                    onPressed: (){
                      String userInput = loginController.codeController.text;
                      loginController.myCredentials(loginController.verifyResult, userInput);
                    },
                    label: Row(children: [
                      Text(
                        loginController.isLoading == true? 'Verifying': 'Verify',
                        style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400,letterSpacing: 1),
                      ),
                      SizedBox(width: size.width * 0.05,),
                        loginController.isLoading == true ? LoadingAnimationWidget
                            .threeArchedCircle(
                            color: Colors.white, size: 20): const Icon(Icons.arrow_forward,color: Colors.white,size: 20,),
                    ],),

                  )
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Obx(() {
        return SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                //Background Image
                Image.asset(
                  'images/loginBack.png',
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      //Logo Image
                      DelayedDisplay(
                        slidingBeginOffset: const Offset(0, -0.4),
                        delay: const Duration(milliseconds: 300),
                        child: Column(
                          children: [
                            const DelayedDisplay(
                              slidingBeginOffset: Offset(0, -0.4),
                              delay: Duration(milliseconds: 300),
                              child: AnimatedImage(),
                            ),
                            SizedBox(height: size.width / 7),
                            loginController.codeSent.value == 'yes'
                                ? AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: otpScreen())
                                : loginScreen()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({Key? key}) : super(key: key);

  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: const Offset(0, 0.10),
  ).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.asset(
        'images/loginImage.png',
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
