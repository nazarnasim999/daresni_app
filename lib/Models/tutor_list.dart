import 'dart:convert';

TutorListModel tutorListModelFromJson(String str) {
  return TutorListModel.fromJson(json.decode(str));
}

class TutorListModel {
  bool? status;
  Data? data;
  String? message;
  List<String> errors;

  TutorListModel({
    this.status = false,
    this.data,
    this.message = '',
    this.errors = const [],
  });

  factory TutorListModel.fromJson(Map<String, dynamic> json) {

    return TutorListModel(
      status: json["status"],
      data: json["data"] == null ? null: Data.fromJson(json["data"]),
      message: json["message"],
      errors: json["errors"] != null ? List<String>.from(json["errors"].map((x) => x)) : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
        "errors": List<String>.from(errors.map((x) => x)),
      };
}

class Data {
  int currentPage;
  List<Tutors> tutors;
  String nextPageUrl;
  String prevPageUrl;
  int total;
  int lastPage;

  Data({
    this.currentPage = 1,
    this.tutors = const [],
    this.nextPageUrl = '',
    this.prevPageUrl = '',
    this.total = 1,
    this.lastPage = 1,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        tutors: json["data"] != null
            ? List<Tutors>.from(json["data"].map((x) => Tutors.fromJson(x)))
            : [],
        nextPageUrl: json["next_page_url"] ?? "",
        prevPageUrl: json["prev_page_url"] ?? "",
        total: json["total"] ?? 1,
        lastPage: json["last_page"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<String>.from(tutors.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
        "total": total,
        "last_page": lastPage,
      };
}

class Tutors {
  int? pricing;
  String? howToTeach;
  String? offerServices;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? workExperience;
  String? certification;
  String? profileLink;
  String? cpr;
  String? passportPic;
  Expertise? expertise;
  int? tutorId;
  int? rating;
  List<Review>? reviews;
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
  Gender? gender;
  DateTime? dob;
  String? passportNo;
  String? nationalId;
  int? countryId;
  String? bio;
  String? profilePicture;
  String? verificationCode;
  Contact? contact;
  HasAddress? hasAddress;

  Tutors({
    this.pricing,
    this.howToTeach,
    this.offerServices,
    this.createdAt,
    this.updatedAt,
    this.workExperience,
    this.certification,
    this.cpr,
    this.profileLink,
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
    this.verificationCode,
    this.contact,
    this.hasAddress,
  });

  factory Tutors.fromJson(Map<String, dynamic> json) => Tutors(
        pricing: json["pricing"],
        howToTeach: json["how_to_teach"],
        offerServices: json["Offer_services"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        workExperience: json["work_experience"],
        certification: json["certification"],
        profileLink: json["share_profile"],
        cpr: json["cpr"],
        passportPic: json["passport_pic"],
        expertise: json["expertise"] != null ? Expertise.fromJson(json["expertise"]) : null,
        tutorId: json["tutor_id"],
        rating: json["rating"],
        reviews: json["reviews"] != null
            ? List<Review>.from(json["reviews"].map((x) => Review.fromJson(x)))
            : null,
        subjects: json["subjects"] != null
            ? List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x)))
            : null,
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
        gender: genderValues.map[json["gender"]],
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
        passportNo: json["passport_no"],
        nationalId: json["national_id"],
        countryId: json["country_id"],
        bio: json["bio"],
        profilePicture: json["profile_picture"],
        verificationCode: json["verification_code"],
        contact: json["contact"] != null ? Contact.fromJson(json["contact"]) : null,
        hasAddress: json["has_address"] != null ? HasAddress.fromJson(json["has_address"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "pricing": pricing,
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
        "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects!.map((x) => x.toJson())),
        "primary_language": primaryLanguage!.toJson(),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "name": name,
        "email": email,
        "status": status,
        "certified": certified,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "description": description,
        "nationality": nationality?.toJson(),
        "gender": genderValues.reverse[gender],
        "dob":
            "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "passport_no": passportNo,
        "national_id": nationalId,
        "country_id": countryId,
        "bio": bio,
        "profile_picture": profilePicture,
        "verification_code": verificationCode,
        "contact": contact?.toJson(),
        "has_address": hasAddress?.toJson(),
      };
}

class Contact {
  String? countryCode;
  String? contactNo;

  Contact({
    this.countryCode,
    this.contactNo,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        countryCode: json["country_code"],
        contactNo: json["contact_no"],
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
  String? symbol;

  Expertise({
    this.id,
    this.name,
    this.isParent,
    this.createdAt,
    this.updatedAt,
    this.symbol,
  });

  factory Expertise.fromJson(Map<String, dynamic> json) => Expertise(
        id: json["id"],
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
        isParent: json["is_parent"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name?.toJson(),
        "is_parent": isParent,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "symbol": symbol,
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

class ParentName {
  String? en;
  String? ar;

  ParentName({
    this.en,
    this.ar,
  });

  factory ParentName.fromJson(Map<String, dynamic> json) => ParentName(
    en: json["en"],
    ar: json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "ar": ar,
  };
}
enum Gender { MALE, FEMALE }

final genderValues = EnumValues({"female": Gender.FEMALE, "male": Gender.MALE});

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
        area: json["area"] != null ? Area.fromJson(json["area"]) : null,
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
        "area": area?.toJson(),
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
  DateTime? createdAt;
  DateTime? updatedAt;
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
    this.createdAt,
    this.updatedAt,
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

enum HowToTeach { BOTH, EMPTY, PS }

final howToTeachValues =
    EnumValues({"both": HowToTeach.BOTH, "": HowToTeach.EMPTY, "ps": HowToTeach.PS});

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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor_id": tutorId,
        "language_id": languageId,
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

class Review {
  int? id;
  int? bookingId;
  int? tutorId;
  int? studentId;
  int? rating;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  Review({
    this.id,
    this.bookingId,
    this.tutorId,
    this.studentId,
    this.rating,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        bookingId: json["booking_id"],
        tutorId: json["tutor_id"],
        studentId: json["student_id"],
        rating: json["rating"],
        message: json["message"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "tutor_id": tutorId,
        "student_id": studentId,
        "rating": rating,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Subject {
  int? subjectId;
  Name? name;
  ParentName? parentName;

  Subject({
    this.subjectId,
    this.name,
    this.parentName,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectId: json["subject_id"],
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
    parentName: json["parent_name"] != null ? ParentName.fromJson(jsonDecode(json["parent_name"])) : null,
      );

  Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "name": name?.toJson(),
    "parent_name": parentName?.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
