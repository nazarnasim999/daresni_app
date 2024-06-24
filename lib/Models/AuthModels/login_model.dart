import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool status;
  String? message;
  String? token;
  User? user;
  List<String> errors;

  LoginModel({
    this.status = false,
    this.message,
    this.token,
    this.user,
    this.errors = const [],
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: json["data"] != null ? User.fromJson(json["data"]) : null,
        errors: json["errors"] != null ? List<String>.from(json["errors"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "data": user?.toJson(),
      };
}

class User {
  int? id;
  int? pricing;
  String? howToTeach;
  String? offerServices;
  String? workExperience;
  String? certification;
  String? cpr;
  String? passportPic;
  Expertise? expertise;
  int? tutorId;
  int? rating;
  List<Subject>? subjects;
  Expertise? primaryLanguage;
  List<Language>? languages;
  String? name;
  String? email;
  int? status;
  int? certified;
  String? description;
  Nationality? nationality;
  String? gender;
  DateTime? dob;
  DateTime? createAt;
  DateTime? updateAt;
  String? contactNo;
  String? passportNo;
  String? nationalId;
  int? countryId;
  String? bio;
  String? profilePicture;
  String? verificationCode;
  HasAddress? hasAddress;
  String? role;

  User({
    this.id,
    this.pricing,
    this.howToTeach,
    this.offerServices,
    this.workExperience,
    this.certification,
    this.cpr,
    this.passportPic,
    this.expertise,
    this.tutorId,
    this.rating,
    this.subjects,
    this.primaryLanguage,
    this.languages,
    this.name,
    this.email,
    this.status,
    this.certified,
    this.description,
    this.nationality,
    this.gender,
    this.dob,
    this.contactNo,
    this.passportNo,
    this.nationalId,
    this.countryId,
    this.bio,
    this.profilePicture,
    this.verificationCode,
    this.hasAddress,
    this.role,
    this.createAt,
    this.updateAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        pricing: json["pricing"],
        howToTeach: json["how_to_teach"],
        offerServices: json["Offer_services"],
        workExperience: json["work_experience"],
        certification: json["certification"],
        cpr: json["cpr"],
        passportPic: json["passport_pic"],
        expertise: json["expertise"] != null ? Expertise.fromJson(json["expertise"]) : null,
        tutorId: json["tutor_id"],
        rating: json["rating"],
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
        description: json["description"],
        nationality: (json["nationality"] != null && json["nationality"] is Map<String, String>)
            ? Nationality.fromJson(json["nationality"])
            : null,
        gender: json["gender"],
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
        createAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updateAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        contactNo: json["contact_no"],
        passportNo: json["passport_no"],
        nationalId: json["national_id"],
        countryId: json["country_id"],
        bio: json["bio"],
        profilePicture: json["profile_picture"],
        verificationCode: json["verification_code"],
        hasAddress: json["has_address"] != null ? HasAddress.fromJson(json["has_address"]) : null,
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "pricing": pricing,
        "id": id,
        "how_to_teach": howToTeach,
        "Offer_services": offerServices,
        "work_experience": workExperience,
        "certification": certification,
        "cpr": cpr,
        "passport_pic": passportPic,
        "expertise": expertise?.toJson(),
        "tutor_id": tutorId,
        "rating": rating,
        "subjects": subjects != null ? List<dynamic>.from(subjects!.map((x) => x.toJson())) : null,
        "primary_language": primaryLanguage?.toJson(),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "name": name,
        "email": email,
        "status": status,
        "certified": certified,
        "description": description,
        "nationality": nationality?.toJson(),
        "gender": gender,
        "dob":
            "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "contact_no": contactNo,
        "passport_no": passportNo,
        "national_id": nationalId,
        "country_id": countryId,
        "bio": bio,
        "profile_picture": profilePicture,
        "verification_code": verificationCode,
        "role": role,
      };
}

class Expertise {
  int? id;
  Name? name;
  String? isParent;

  String? symbol;

  Expertise({
    this.id,
    this.name,
    this.isParent,
    this.symbol,
  });

  factory Expertise.fromJson(Map<String, dynamic> json) => Expertise(
        id: json["id"],
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
        isParent: json["is_parent"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name?.toJson(),
        "is_parent": isParent,
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

class HasAddress {
  int? id;
  int? userId;
  String? flatNo;
  String? buildingNo;
  String? roadNo;
  String? blockNo;
  Area? area;

  Country? country;

  HasAddress({
    this.id,
    this.userId,
    this.flatNo,
    this.buildingNo,
    this.roadNo,
    this.blockNo,
    this.area,
    this.country,
  });

  factory HasAddress.fromJson(Map<String, dynamic> json) => HasAddress(
      id: json["id"],
      userId: json["user_id"],
      flatNo: json["flat_no"],
      buildingNo: json["building_no"],
      roadNo: json["road_no"],
      blockNo: json["block_no"],
      area: json["area"] != null ? Area.fromJson(json["area"]) : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "flat_no": flatNo,
        "building_no": buildingNo,
        "road_no": roadNo,
        "block_no": blockNo,
        "area": area?.toJson(),
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
  int? languageId;
  Name? name;

  Language({
    this.languageId,
    this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        languageId: json["language_id"],
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "language_id": languageId,
        "name": name?.toJson(),
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
