
import 'dart:convert';
import 'package:flutter/material.dart';

//getBanner from api
List<GetBanner> bannerListModelFromJson(String str) => List<GetBanner>.from(json.decode(str).map((x) => GetBanner.fromJson(x)));
String bannerListModelToJson(List<GetBanner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class GetBanner {
  GetBanner({
    required this.id,
    required this.files,
  });
  int id;
  String files;
  factory GetBanner.fromJson(Map<String, dynamic> json) => GetBanner(
    id: json["id"],
    files: json["files"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "files": files,
  };
}


//getCompletedEvents from api
List<GetCompletedList> completedListModelFromJson(String str) => List<GetCompletedList>.from(json.decode(str).map((x) => GetCompletedList.fromJson(x)));
String completedListModelToJson(List<GetCompletedList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class GetCompletedList {
  GetCompletedList({
    required this.title,
    required this.date,
    required this.contact_person,
    required this.venue,
    required this.file,
    required this.contact,
    required this.description,
    required this.id,
  });
  int id;
  String title;
  String date;
  String contact_person;
  String venue;
  String file;
  String contact;
  String description;
  factory GetCompletedList.fromJson(Map<String, dynamic> json) => GetCompletedList(
    title: json["title"],
    id: json["id"],
    date: json["date"],
    contact_person: json["contact_person"],
    venue: json["venue"],
    file: json["file"],
    contact: json["contact"],
    description: json["description"],
  );
  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "date": date,
    "contact_person": contact_person,
    "venue": venue,
    "file": file,//Event Poster
    "contact": contact,
    "description": description,
  };
}



//getCompletedEvents from api
List<GetUpcomingList> upcomingListModelFromJson(String str) => List<GetUpcomingList>.from(json.decode(str).map((x) => GetUpcomingList.fromJson(x)));
String upcomingListModelToJson(List<GetUpcomingList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class GetUpcomingList {
  GetUpcomingList({
    required this.title,
    required this.date,
    required this.contact_person,
    required this.venue,
    required this.file,//Images of the event
    required this.contact,
    required this.description,
  });
  String title;
  String date;
  String contact_person;
  String venue;
  String file;
  String contact;
  String description;
  factory GetUpcomingList.fromJson(Map<String, dynamic> json) => GetUpcomingList(
    title: json["title"],
    date: json["date"],
    contact_person: json["contact_person"],
    venue: json["venue"],
    file: json["file"],
    contact: json["contact"],
    description: json["description"],
  );
  Map<String, dynamic> toJson() => {
    "id": title,
    "date": date,
    "contact_person": contact_person,
    "venue": venue,
    "image": file,
    "contact": contact,
    "description": description,
  };
}


//getBanner from api
List<GetCompleteEventImages> completedEeventsImageFromJson(String str) => List<GetCompleteEventImages>.from(json.decode(str).map((x) => GetCompleteEventImages.fromJson(x)));
String completedEeventsImageModelToJson(List<GetCompleteEventImages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class GetCompleteEventImages {
  GetCompleteEventImages({
    required this.eventId,
    required this.image,
  });
  int eventId;
  String image;
  factory GetCompleteEventImages.fromJson(Map<String, dynamic> json) => GetCompleteEventImages(
    eventId: json["id"],
    image: json["image"],
  );
  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "image": image,
  };
}

//Fund raise list api
class FundRaise{
  FundRaise({
    required this.fundImage,
    required this.fundLabel,
  });
  String fundImage;
  String fundLabel;
}