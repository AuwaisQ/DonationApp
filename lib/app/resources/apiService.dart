// ignore_for_file: unnecessary_string_interpolations, avoid_print, prefer_interpolation_to_compose_strings, depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService
{
  static const String baseUrl = 'https://wecare.developerzone.in/';//Main URL
  final String profile = '${baseUrl}profile';//Profile Info Collect
  final String bloodDonation = "${baseUrl}bloodenquiry";//Blood Donation
  final String bannerList = "${baseUrl}home";//Home Page Banners
  final String getContact = "${baseUrl}getContactUs";//Get Contact List
  final String profileUpdate = "${baseUrl}updateProfilePhoto";//Profile Update
  final String appCategory = "${baseUrl}getCategory";//Select Interest Category
  final String requestList = "${baseUrl}getAllPendingEnquiries";//Pending Request's
  final String checkLogin = "${baseUrl}checkMobile";//Check User Mobile Number if it's registered or not.
  final String upcomingEvent = "${baseUrl}get_upcoming_event";//Upcoming event
  final String deleteAccountURL = "${baseUrl}delRecord";//Delete Account
  final String completedEvent = "${baseUrl}get_completed_event";//Complete Events
  final String fetchProfile = "${baseUrl}get_profile";//Fetch profile
  final String completedList = "${baseUrl}getAllCompletedEnquiries";//Request History
  final String foodDonation = "${baseUrl}donatedfood";//food Donation
  final String aboutUsImages = "${baseUrl}getAboutImages";//aboutUs Images
  final String aboutUsDescription = "${baseUrl}getAbout";//AboutUs Description Detail's
  final String stationaryDonation = "${baseUrl}stationery_request";//Stationary Donation
  final String clothDonation = "${baseUrl}clothes_request";//cloth Donation
  final String medicalDonation = "${baseUrl}medical_request";//Medical Donation
  final String fetchBannerImages= "${baseUrl}public/banner_images/";//Complete Events Banners
  final String eventImages = "${baseUrl}public/img/";//All Image Path
  final String bannerImages = "${baseUrl}public/banner_images/";//All Image Path
  final String completeEventImages = "${baseUrl}get_images";//Complete Event Images

  //User Profile registration data posting method
  Future userProfile(String userImage,String userName, String email, String mobileNumber, String gender) async {
    final response = await http.post(Uri.parse(profile),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "profile_image":"$userImage",
          "FullName": "$userName",
          "Email": "$email",
          "MobileNumber": "$mobileNumber",
          "Gender": "$gender"
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Blood Enquiry Post Api
  Future bloodEnquiry(String userId,String bloodGroup, String bloodUnits, String userName,String mobileNumber,String location) async {
    final response = await http.post(Uri.parse(bloodDonation),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "userid": "$userId",
          "bloodGroup": "$bloodGroup",
          "unit": "$bloodUnits",
          "name": "$userName",
          "mobile": "$mobileNumber",
          "location": "$location"
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Books Post Api
  Future booksEnquiry(String userId,String bookType, String description,String quantity,String contactName,String contactNumber) async {
    final response = await http.post(Uri.parse(stationaryDonation),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "userId":"$userId",
          "bookType":"$bookType",
          "description":"$description",
          "quantity":"$quantity",
          "contactName":"$contactName",
          "contactNumber":"$contactNumber"
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Blood Enquiry Post Api
  Future foodEnquiry(String userId,String foodDescription, String foodType, String pickUpDate,String contactName,String contactNumber, String location) async {
    final response = await http.post(Uri.parse(foodDonation),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "userId": "$userId",
          "foodDescription": "$foodDescription",
          "type": "$foodType",
          "pickupDate": "$pickUpDate",
          "contactName": "$contactName",
          "contactNumber": "$contactNumber",
          "pickupAddress": "$location"
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Blood Enquiry Post Api
  Future medicalEnquiry(String userId,String description, String categoryType,String contactName,String contactNumber, String location) async {
    final response = await http.post(Uri.parse(medicalDonation),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "userid": "$userId",
          "category_type": "$categoryType",
          "description": "$description",
          "pickup_address": "$location",
          "contact_name": "$contactName",
          "contact_number": "$contactNumber"
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Blood Enquiry Post Api
  Future cothEnquiry(String userId, String clothQuantity, String contactName,String contactNumber,String address) async {
    final response = await http.post(Uri.parse(clothDonation),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "userid": "$userId",
          "clothes_quantity": "$clothQuantity",
          "contact_name": "$contactName",
          "contact_number": "$contactNumber",
          "address": "$address"
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Geting banners list
  Future getCategory() async {
    final response = await http.get(Uri.parse(appCategory));
    print(response);
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Geting contact list
  Future getContactList() async {
    final response = await http.get(Uri.parse(getContact));
    print(response);
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Check Login Post Api
  Future checkMobile(String userMobile) async {
    final response = await http.post(Uri.parse(checkLogin),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "MobileNumber": "$userMobile",
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Pending Request Post Api
  Future pendingRequest(String userId) async {
    final response = await http.post(Uri.parse(requestList),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "userid": "$userId",
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Pending Request Post Api
  Future completeReques(String userId) async {
    final response = await http.post(Uri.parse(completedList),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "userid": "$userId",
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Geting banners list
  Future getBanners() async {
    final response = await http.get(Uri.parse(bannerList));
    print(response);
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Geting about us image list
  Future getAboutUsImages() async {
    final response = await http.get(Uri.parse(aboutUsImages));
    print(response);
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Geting anout us description list
  Future getAboutUsDescription() async {
    final response = await http.get(Uri.parse(aboutUsDescription));
    print(response);
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Upcoming list
  Future getUpcomingList() async {
    final response = await http.get(Uri.parse(upcomingEvent));
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Copmpleted list
  Future getCompletedList() async {
    final response = await http.get(Uri.parse(completedEvent));
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Geting User Profile
  Future getProfile(String userId) async {
    final response = await http.post(Uri.parse(fetchProfile),
        headers: <String, String>{'Content-Type':'application/json; charset=UTF-8'},
        body: json.encode({
          "userid": "$userId"
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Geting User Profile
  Future getcompleteEventImages(int userId) async {
    final response = await http.post(Uri.parse(completeEventImages),
        headers: <String, String>{'Content-Type':'application/json; charset=UTF-8'},
        body: json.encode({
          "eventId": "$userId"
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Update User Profile photo
  Future updateprofilePhoto(int userId, String image) async {
    final response = await http.post(Uri.parse(profileUpdate),
        headers: <String, String>{'Content-Type':'application/json; charset=UTF-8'},
        body: json.encode({
          "userId": "$userId",
          "profileImage": "$image",
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Delete Account
  Future deleteAccount(String userId) async {
    print(deleteAccountURL);
    final response = await http.post(Uri.parse(deleteAccountURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "id": "$userId",
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

}