import 'dart:convert';

StudentProfile studentProfileFromJson(String str) => StudentProfile.fromJson(json.decode(str));

class StudentProfile {
  bool status;
  String message;
  Data? data;
  List<String> errors;

  StudentProfile({
    this.status = false,
    this.message = '',
    this.data,
    this.errors = const [],
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        errors: json["errors"] != null ? List<String>.from(json["errors"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "errors": List<String>.from(errors.map((x) => x)),
      };
}

class Data {
  String? lookingForTutor;
  int? howManyStudents;
  String? ageOfStudents;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? studentId;
  String? name;
  String? email;
  int? status;
  int? certified;
  DateTime? emailVerifiedAt;
  Nationality? nationality;
  String? gender;
  DateTime? dob;

  String? bio;
  String? profilePicture;
  String? verificationCode;
  Contact? contact;
  HasAddress? hasAddress;

  Data({
    this.lookingForTutor,
    this.howManyStudents,
    this.ageOfStudents,
    this.createdAt,
    this.updatedAt,
    this.studentId,
    this.name,
    this.email,
    this.status,
    this.certified,
    this.emailVerifiedAt,
    this.nationality,
    this.gender,
    this.dob,
    this.bio,
    this.profilePicture,
    this.verificationCode,
    this.contact,
    this.hasAddress,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        lookingForTutor: json["looking_for_tutor"],
        howManyStudents: json["how_many_students"],
        ageOfStudents: json["age_of_students"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        studentId: json["student_id"],
        name: json["name"],
        email: json["email"],
        status: json["status"],
        certified: json["certified"],
        emailVerifiedAt:
            json["email_verified_at"] != null ? DateTime.parse(json["email_verified_at"]) : null,
        nationality: json["nationality"] != null ? Nationality.fromJson(json["nationality"]) : null,
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        bio: json["bio"],
        profilePicture: json["profile_picture"],
        verificationCode: json["verification_code"],
        contact: json["contact"] != null ? Contact.fromJson(json["contact"]) : null,
        hasAddress: json["has_address"] != null ? HasAddress.fromJson(json["has_address"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "looking_for_tutor": lookingForTutor,
        "how_many_students": howManyStudents,
        "age_of_students": ageOfStudents,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "student_id": studentId,
        "name": name,
        "email": email,
        "status": status,
        "certified": certified,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "nationality": nationality?.toJson(),
        "gender": gender,
        "dob":
            "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
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
        area: json["area"] != null ? Area.fromJson(json["area"]) : null,
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
        "country": country?.toJson(),
      };
}

class Area {
  int? id;
  String? name;
  int? stateId;
  int? countryId;

  Area({
    this.id,
    this.name,
    this.stateId,
    this.countryId,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "country_id": countryId,
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
