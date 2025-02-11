import 'package:get/get.dart';

import '../modules/aboutUs/bindings/about_us_binding.dart';
import '../modules/aboutUs/views/about_us_view.dart';
import '../modules/accountSettings/bindings/account_settings_binding.dart';
import '../modules/accountSettings/views/account_settings_view.dart';
import '../modules/appDrawer/bindings/app_drawer_binding.dart';
import '../modules/appDrawer/views/app_drawer_view.dart';
import '../modules/appMenu/bindings/app_menu_binding.dart';
import '../modules/appMenu/views/app_menu_view.dart';
import '../modules/bloodDonation/bindings/blood_donation_binding.dart';
import '../modules/bloodDonation/views/blood_donation_view.dart';
import '../modules/booksDonation/bindings/books_donation_binding.dart';
import '../modules/booksDonation/views/books_donation_view.dart';
import '../modules/bottomBar/bindings/bottom_bar_binding.dart';
import '../modules/bottomBar/views/bottom_bar_view.dart';
import '../modules/clotheDonation/bindings/clothe_donation_binding.dart';
import '../modules/clotheDonation/views/clothe_donation_view.dart';
import '../modules/foodDonation/bindings/food_donation_binding.dart';
import '../modules/foodDonation/views/food_donation_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/medicalDonation/bindings/medical_donation_binding.dart';
import '../modules/medicalDonation/views/medical_donation_view.dart';
import '../modules/onBoarding/bindings/on_boarding_binding.dart';
import '../modules/onBoarding/views/on_boarding_view.dart';
import '../modules/pendingRequest/bindings/pending_request_binding.dart';
import '../modules/pendingRequest/views/pending_request_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profilePage/bindings/profile_page_binding.dart';
import '../modules/profilePage/views/profile_page_view.dart';
import '../modules/selectInterest/bindings/select_interest_binding.dart';
import '../modules/selectInterest/views/select_interest_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ON_BOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_INTEREST,
      page: () => SelectInterestView(),
      binding: SelectInterestBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.FOOD_DONATION,
      page: () => FoodDonationView(),
      binding: FoodDonationBinding(),
    ),
    GetPage(
      name: _Paths.BLOOD_DONATION,
      page: () => BloodDonationView(),
      binding: BloodDonationBinding(),
    ),
    GetPage(
      name: _Paths.CLOTHE_DONATION,
      page: () => ClotheDonationView(),
      binding: ClotheDonationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.APP_DRAWER,
      page: () => AppDrawerView(),
      binding: AppDrawerBinding(),
    ),
    GetPage(
      name: _Paths.APP_MENU,
      page: () => AppMenuView(),
      binding: AppMenuBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_DONATION,
      page: () => MedicalDonationView(),
      binding: MedicalDonationBinding(),
    ),
    GetPage(
      name: _Paths.PENDING_REQUEST,
      page: () => PendingRequestView(),
      binding: PendingRequestBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.BOOKS_DONATION,
      page: () => BooksDonationView(),
      binding: BooksDonationBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SETTINGS,
      page: () => AccountSettingsView(),
      binding: AccountSettingsBinding(),
    ),
  ];
}
