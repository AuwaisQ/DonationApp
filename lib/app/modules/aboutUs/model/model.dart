
import 'dart:convert';

//get About Us Images from api
List<GetAboutUsImages> aboutUsImagesFromJson(String str) => List<GetAboutUsImages>.from(json.decode(str).map((x) => GetAboutUsImages.fromJson(x)));
String aboutUsImagesToJson(List<GetAboutUsImages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class GetAboutUsImages {
  GetAboutUsImages({
    required this.image,
  });
  String image;
  factory GetAboutUsImages.fromJson(Map<String, dynamic> json) => GetAboutUsImages(
    image: json["image"],
  );
  Map<String, dynamic> toJson() => {
    "files": image,
  };
}


//get About Us Images from api
List<GetAboutUsDescription> aboutUsDescriptionFromJson(String str) => List<GetAboutUsDescription>.from(json.decode(str).map((x) => GetAboutUsDescription.fromJson(x)));
String aboutUsDescriptionToJson(List<GetAboutUsDescription> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class GetAboutUsDescription {
  GetAboutUsDescription({
    required this.description,
  });
  String description;
  factory GetAboutUsDescription.fromJson(Map<String, dynamic> json) => GetAboutUsDescription(
    description: json["description"],
  );
  Map<String, dynamic> toJson() => {
    "files": description,
  };
}