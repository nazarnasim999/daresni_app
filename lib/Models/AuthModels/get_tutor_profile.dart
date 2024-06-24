import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));

class GetProfileModel {
  String? code;
  bool? status;
  String? message;
  ProfileData? profileData;

  GetProfileModel({
    this.code,
    this.status,
    this.message,
    this.profileData,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        profileData: json["data"] != null ? ProfileData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": profileData?.toJson(),
      };
}

class ProfileData {
  int? pricing;
  String? howToTeach;
  String? offerServices;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? workExperience;
  String? certification;
  String? cpr;
  String? passportPic;
  Expertise? expertise;
  int? tutorId;
  int? rating;
  List<dynamic>? reviews;
  List<Subject>? subjects;
  Expertise? primaryLanguage;
  List<Language>? languages;
  String? name;
  String? email;
  int? status;
  int? certified;
  DateTime? emailVerifiedAt;
  String? description;
  Nationality? nationality;
  String? gender;
  DateTime? dob;
  String? passportNo;
  String? nationalId;
  int? countryId;
  String? bio;
  String? profilePicture;
  DateTime? deletedAt;
  Contact? contact;
  HasAddress? hasAddress;

  ProfileData({
    this.pricing,
    this.howToTeach,
    this.offerServices,
    this.createdAt,
    this.updatedAt,
    this.workExperience,
    this.certification,
    this.cpr,
    this.passportPic,
    this.expertise,
    this.tutorId,
    this.rating,
    this.reviews,
    this.subjects,
    this.primaryLanguage,
    this.languages,
    this.name,
    this.email,
    this.status,
    this.certified,
    this.emailVerifiedAt,
    this.description,
    this.nationality,
    this.gender,
    this.dob,
    this.passportNo,
    this.nationalId,
    this.countryId,
    this.bio,
    this.profilePicture,
    this.deletedAt,
    this.contact,
    this.hasAddress,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        pricing: json["pricing"],
        howToTeach: json["how_to_teach"],
        offerServices: json["Offer_services"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        workExperience: json["work_experience"],
        certification: json["certification"],
        cpr: json["cpr"],
        passportPic: json["passport_pic"],
        expertise: json["expertise"] != null ? Expertise.fromJson(json["expertise"]) : null,
        tutorId: json["tutor_id"],
        rating: json["rating"],
        reviews: json["reviews"] != null ? List<dynamic>.from(json["reviews"].map((x) => x)) : null,
        subjects: json["subjects"] != null
            ? List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x)))
            : [],
        primaryLanguage:
            json["primary_language"] != null ? Expertise.fromJson(json["primary_language"]) : null,
        languages: json["languages"] != null
            ? List<Language>.from(json["languages"].map((x) => Language.fromJson(x)))
            : null,
        name: json["name"],
        email: json["email"],
        status: json["status"],
        certified: json["certified"],
        emailVerifiedAt:
            json["email_verified_at"] != null ? DateTime.parse(json["email_verified_at"]) : null,
        description: json["description"],
        nationality: json["nationality"] != null ? Nationality.fromJson(json["nationality"]) : null,
        gender: json["gender"],
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
        passportNo: json["passport_no"],
        nationalId: json["national_id"],
        countryId: json["country_id"],
        bio: json["bio"],
        profilePicture: json["profile_picture"]?.toString() ?? "",
        deletedAt: json["deleted_at"],
        contact: json["contact"] != null ? Contact.fromJson(json["contact"]) : null,
        hasAddress: json["has_address"] != null ? HasAddress.fromJson(json["has_address"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "pricing": pricing,
        "how_to_teach": howToTeach,
        "Offer_services": offerServices,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "work_experience": workExperience,
        "certification": certification,
        "cpr": cpr,
        "passport_pic": passportPic,
        "expertise": expertise?.toJson(),
        "tutor_id": tutorId,
        "rating": rating,
        "reviews": reviews != null ? List<dynamic>.from(reviews!.map((x) => x)) : [],
        "subjects": subjects != null ? List<dynamic>.from(subjects!.map((x) => x.toJson())) : [],
        "primary_language": primaryLanguage,
        "languages":
            languages != null ? List<dynamic>.from(languages!.map((x) => x.toJson())) : null,
        "name": name,
        "email": email,
        "status": status,
        "certified": certified,
        "email_verified_at": emailVerifiedAt,
        "description": description,
        "nationality": nationality?.toJson(),
        "gender": gender,
        "dob":
            "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "passport_no": passportNo,
        "national_id": nationalId,
        "country_id": countryId,
        "bio": bio,
        "profile_picture": profilePicture,
        "deleted_at": deletedAt,
        "contact": contact?.toJson(),
        "has_address": hasAddress?.toJson(),
      };
}

class Contact {
  String countryCode;
  String contactNo;

  Contact({
    this.countryCode = "",
    this.contactNo = "",
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        countryCode: json["country_code"] ?? "",
        contactNo: json["contact_no"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "contact_no": contactNo,
      };
}

class Expertise {
  int? id;
  Name? name;
  String? isParent;
  DateTime? createdAt;
  DateTime? updatedAt;

  Expertise({
    this.id,
    this.name,
    this.isParent,
    this.createdAt,
    this.updatedAt,
  });

  factory Expertise.fromJson(Map<String, dynamic> json) => Expertise(
        id: json["id"],
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
        isParent: json["is_parent"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name?.toJson(),
        "is_parent": isParent,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Name {
  String? en;
  String? ar;

  Name({
    this.en,
    this.ar,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        en: json["en"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "ar": ar,
      };
}

class HasAddress {
  int? id;
  int? userId;
  String? flatNo;
  String? buildingNo;
  String? roadNo;
  String? blockNo;
  Area? area;
  DateTime? createdAt;
  DateTime? updatedAt;
  Country? country;

  HasAddress({
    this.id,
    this.userId,
    this.flatNo,
    this.buildingNo,
    this.roadNo,
    this.blockNo,
    this.area,
    this.createdAt,
    this.updatedAt,
    this.country,
  });

  factory HasAddress.fromJson(Map<String, dynamic> json) => HasAddress(
        id: json["id"],
        userId: json["user_id"],
        flatNo: json["flat_no"],
        buildingNo: json["building_no"],
        roadNo: json["road_no"],
        blockNo: json["block_no"],
        area: Area.fromJson(json["area"]),
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        country: json["country"] != null ? Country.fromJson(json["country"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "flat_no": flatNo,
        "building_no": buildingNo,
        "road_no": roadNo,
        "block_no": blockNo,
        "area": area,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "country": country?.toJson(),
      };
}

class Area {
  int? id;
  String? name;
  int? stateId;
  String? stateCode;
  int? countryId;
  String? countryCode;
  String? latitude;
  String? longitude;
  int? flag;
  String? wikiDataId;

  Area({
    this.id,
    this.name,
    this.stateId,
    this.stateCode,
    this.countryId,
    this.countryCode,
    this.latitude,
    this.longitude,
    this.flag,
    this.wikiDataId,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        stateCode: json["state_code"],
        countryId: json["country_id"],
        countryCode: json["country_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        flag: json["flag"],
        wikiDataId: json["wikiDataId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "state_code": stateCode,
        "country_id": countryId,
        "country_code": countryCode,
        "latitude": latitude,
        "longitude": longitude,
        "flag": flag,
        "wikiDataId": wikiDataId,
      };
}

class Country {
  int? id;
  String? name;
  String? timezones;

  Country({
    this.id,
    this.name,
    this.timezones,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        timezones: json["timezones"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "timezones": timezones,
      };
}

class Language {
  int? id;
  int? tutorId;
  int? languageId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Language({
    this.id,
    this.tutorId,
    this.languageId,
    this.createdAt,
    this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        tutorId: json["tutor_id"],
        languageId: json["language_id"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor_id": tutorId,
        "language_id": languageId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PrimaryLanguage {
  int? id;
  int? tutorId;
  int? languageId;
  DateTime? createdAt;
  DateTime? updatedAt;

  PrimaryLanguage({
    this.id,
    this.tutorId,
    this.languageId,
    this.createdAt,
    this.updatedAt,
  });

  factory PrimaryLanguage.fromJson(Map<String, dynamic> json) => PrimaryLanguage(
        id: json["id"],
        tutorId: json["tutor_id"],
        languageId: json["language_id"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor_id": tutorId,
        "language_id": languageId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Nationality {
  int? id;
  String? name;

  Nationality({
    this.id,
    this.name,
  });

  factory Nationality.fromJson(Map<String, dynamic> json) => Nationality(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Subject {
  int? subjectId;
  Name? name;

  Subject({
    this.subjectId,
    this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectId: json["subject_id"],
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "name": name?.toJson(),
      };
}
