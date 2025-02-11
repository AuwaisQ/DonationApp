import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/modules/appDrawer/views/app_drawer_view.dart';
import 'app/modules/onBoarding/views/on_boarding_view.dart';
import 'app/routes/app_pages.dart';

bool? isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getBool('isLogin');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily:'Poppins'),
      title: "WeCare",
      home: isLogin == true ? AppDrawerView() : const OnBoardingView(),
      getPages: AppPages.routes,
    ),
  );
}
