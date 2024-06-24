import 'dart:convert';

import 'package:darasni/Models/tutor_list.dart';

TutorModel tutorModelFromJson(String str) => TutorModel.fromJson(json.decode(str));

class TutorModel {
  bool status;
  String message;
  Tutors? data;
  List<String> errors;

  TutorModel({
    this.status = false,
    this.message = '',
    this.data,
    this.errors = const [],
  });

  factory TutorModel.fromJson(Map<String, dynamic> json) => TutorModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Tutors.fromJson(json["data"]) : null,
        errors: json["errors"] != null ? List<String>.from(json["errors"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

// class Data {
//   int pricing;
//   String howToTeach;
//   String offerServices;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String workExperience;
//   String certification;
//   String cpr;
//   String passportPic;
//   Expertise expertise;
//   int tutorId;
//   int rating;
//   List<dynamic> reviews;
//   List<Subject> subjects;
//   Expertise primaryLanguage;
//   List<Language> languages;
//   String name;
//   String email;
//   int status;
//   int certified;
//   DateTime emailVerifiedAt;
//   dynamic description;
//   Nationality nationality;
//   String gender;
//   DateTime dob;
//   String passportNo;
//   String nationalId;
//   dynamic countryId;
//   String bio;
//   String profilePicture;
//   dynamic verificationCode;
//   dynamic deletedAt;
//   Contact contact;
//   HasAddress hasAddress;
//
//   Data({
//     this.pricing,
//     this.howToTeach,
//     this.offerServices,
//     this.createdAt,
//     this.updatedAt,
//     this.workExperience,
//     this.certification,
//     this.cpr,
//     this.passportPic,
//     this.expertise,
//     this.tutorId,
//     this.rating,
//     this.reviews,
//     this.subjects,
//     this.primaryLanguage,
//     this.languages,
//     this.name,
//     this.email,
//     this.status,
//     this.certified,
//     this.emailVerifiedAt,
//     this.description,
//     this.nationality,
//     this.gender,
//     this.dob,
//     this.passportNo,
//     this.nationalId,
//     this.countryId,
//     this.bio,
//     this.profilePicture,
//     this.verificationCode,
//     this.deletedAt,
//     this.contact,
//     this.hasAddress,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     pricing: json["pricing"],
//     howToTeach: json["how_to_teach"],
//     offerServices: json["Offer_services"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     workExperience: json["work_experience"],
//     certification: json["certification"],
//     cpr: json["cpr"],
//     passportPic: json["passport_pic"],
//     expertise: Expertise.fromJson(json["expertise"]),
//     tutorId: json["tutor_id"],
//     rating: json["rating"],
//     reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
//     subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
//     primaryLanguage: Expertise.fromJson(json["primary_language"]),
//     languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
//     name: json["name"],
//     email: json["email"],
//     status: json["status"],
//     certified: json["certified"],
//     emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
//     description: json["description"],
//     nationality: Nationality.fromJson(json["nationality"]),
//     gender: json["gender"],
//     dob: DateTime.parse(json["dob"]),
//     passportNo: json["passport_no"],
//     nationalId: json["national_id"],
//     countryId: json["country_id"],
//     bio: json["bio"],
//     profilePicture: json["profile_picture"],
//     verificationCode: json["verification_code"],
//     deletedAt: json["deleted_at"],
//     contact: Contact.fromJson(json["contact"]),
//     hasAddress: HasAddress.fromJson(json["has_address"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pricing": pricing,
//     "how_to_teach": howToTeach,
//     "Offer_services": offerServices,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "work_experience": workExperience,
//     "certification": certification,
//     "cpr": cpr,
//     "passport_pic": passportPic,
//     "expertise": expertise.toJson(),
//     "tutor_id": tutorId,
//     "rating": rating,
//     "reviews": List<dynamic>.from(reviews.map((x) => x)),
//     "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
//     "primary_language": primaryLanguage.toJson(),
//     "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
//     "name": name,
//     "email": email,
//     "status": status,
//     "certified": certified,
//     "email_verified_at": emailVerifiedAt.toIso8601String(),
//     "description": description,
//     "nationality": nationality.toJson(),
//     "gender": gender,
//     "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
//     "passport_no": passportNo,
//     "national_id": nationalId,
//     "country_id": countryId,
//     "bio": bio,
//     "profile_picture": profilePicture,
//     "verification_code": verificationCode,
//     "deleted_at": deletedAt,
//     "contact": contact.toJson(),
//     "has_address": hasAddress.toJson(),
//   };
// }
//
// class Contact {
//   String countryCode;
//   String contactNo;
//
//   Contact({
//     this.countryCode,
//     this.contactNo,
//   });
//
//   factory Contact.fromJson(Map<String, dynamic> json) => Contact(
//     countryCode: json["country_code"],
//     contactNo: json["contact_no"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "country_code": countryCode,
//     "contact_no": contactNo,
//   };
// }
//
// class Expertise {
//   int id;
//   Name name;
//   dynamic isParent;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String symbol;
//
//   Expertise({
//     this.id,
//     this.name,
//     this.isParent,
//     this.createdAt,
//     this.updatedAt,
//     this.symbol,
//   });
//
//   factory Expertise.fromJson(Map<String, dynamic> json) => Expertise(
//     id: json["id"],
//     name: Name.fromJson(json["name"]),
//     isParent: json["is_parent"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     symbol: json["symbol"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name.toJson(),
//     "is_parent": isParent,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "symbol": symbol,
//   };
// }
//
// class Name {
//   String en;
//   String ar;
//
//   Name({
//     this.en,
//     this.ar,
//   });
//
//   factory Name.fromJson(Map<String, dynamic> json) => Name(
//     en: json["en"],
//     ar: json["ar"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "en": en,
//     "ar": ar,
//   };
// }
//
// class HasAddress {
//   int id;
//   int userId;
//   String flatNo;
//   String buildingNo;
//   String roadNo;
//   String blockNo;
//   Area area;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Country country;
//
//   HasAddress({
//     this.id,
//     this.userId,
//     this.flatNo,
//     this.buildingNo,
//     this.roadNo,
//     this.blockNo,
//     this.area,
//     this.createdAt,
//     this.updatedAt,
//     this.country,
//   });
//
//   factory HasAddress.fromJson(Map<String, dynamic> json) => HasAddress(
//     id: json["id"],
//     userId: json["user_id"],
//     flatNo: json["flat_no"],
//     buildingNo: json["building_no"],
//     roadNo: json["road_no"],
//     blockNo: json["block_no"],
//     area: Area.fromJson(json["area"]),
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     country: Country.fromJson(json["country"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "flat_no": flatNo,
//     "building_no": buildingNo,
//     "road_no": roadNo,
//     "block_no": blockNo,
//     "area": area.toJson(),
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "country": country.toJson(),
//   };
// }
//
// class Area {
//   int id;
//   String name;
//   int stateId;
//   String stateCode;
//   int countryId;
//   String countryCode;
//   String latitude;
//   String longitude;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int flag;
//   dynamic wikiDataId;
//
//   Area({
//     this.id,
//     this.name,
//     this.stateId,
//     this.stateCode,
//     this.countryId,
//     this.countryCode,
//     this.latitude,
//     this.longitude,
//     this.createdAt,
//     this.updatedAt,
//     this.flag,
//     this.wikiDataId,
//   });
//
//   factory Area.fromJson(Map<String, dynamic> json) => Area(
//     id: json["id"],
//     name: json["name"],
//     stateId: json["state_id"],
//     stateCode: json["state_code"],
//     countryId: json["country_id"],
//     countryCode: json["country_code"],
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     flag: json["flag"],
//     wikiDataId: json["wikiDataId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "state_id": stateId,
//     "state_code": stateCode,
//     "country_id": countryId,
//     "country_code": countryCode,
//     "latitude": latitude,
//     "longitude": longitude,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "flag": flag,
//     "wikiDataId": wikiDataId,
//   };
// }
//
// class Country {
//   int id;
//   String name;
//   String timezones;
//
//   Country({
//     this.id,
//     this.name,
//     this.timezones,
//   });
//
//   factory Country.fromJson(Map<String, dynamic> json) => Country(
//     id: json["id"],
//     name: json["name"],
//     timezones: json["timezones"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "timezones": timezones,
//   };
// }
//
// class Language {
//   int id;
//   int tutorId;
//   int languageId;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   Language({
//     this.id,
//     this.tutorId,
//     this.languageId,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Language.fromJson(Map<String, dynamic> json) => Language(
//     id: json["id"],
//     tutorId: json["tutor_id"],
//     languageId: json["language_id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "tutor_id": tutorId,
//     "language_id": languageId,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class Nationality {
//   int id;
//   String name;
//
//   Nationality({
//     this.id,
//     this.name,
//   });
//
//   factory Nationality.fromJson(Map<String, dynamic> json) => Nationality(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }
//
// class Subject {
//   int subjectId;
//   Name name;
//
//   Subject({
//     this.subjectId,
//     this.name,
//   });
//
//   factory Subject.fromJson(Map<String, dynamic> json) => Subject(
//     subjectId: json["subject_id"],
//     name: Name.fromJson(json["name"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "subject_id": subjectId,
//     "name": name.toJson(),
//   };
// }
