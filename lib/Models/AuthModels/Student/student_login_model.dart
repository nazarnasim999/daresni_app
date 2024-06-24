import 'dart:convert';

StudentLoginResponse studentLoginResponseFromJson(String str) =>
    StudentLoginResponse.fromJson(json.decode(str));

class StudentLoginResponse {
  bool status;
  String message;
  String token;
  Data? data;
  List<String> errors;

  StudentLoginResponse({
    this.status = false,
    this.message = "",
    this.token = "",
    this.data,
    this.errors = const [],
  });

  factory StudentLoginResponse.fromJson(Map<String, dynamic> json) => StudentLoginResponse(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        errors: List<String>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "data": data?.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  int? status;
  int? certified;
  DateTime? emailVerifiedAt;
  String? nationality;
  String? gender;
  DateTime? dob;
  String? contactNo;
  String? passportNo;
  int? nationalId;
  int? countryId;
  String? bio;
  String? profilePicture;
  String? verificationCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  int? studentId;
  String? role;

  Data({
    this.id,
    this.name = "",
    this.email = "",
    this.status,
    this.certified,
    this.emailVerifiedAt,
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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.studentId,
    this.role,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        status: json["status"],
        certified: json["certified"],
        emailVerifiedAt:
            json["email_verified_at"] != null ? DateTime.parse(json["email_verified_at"]) : null,
        nationality: json["nationality"],
        gender: json["gender"],
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
        contactNo: json["contact_no"],
        passportNo: json["passport_no"],
        nationalId: json["national_id"],
        countryId: json["country_id"],
        bio: json["bio"],
        profilePicture: json["profile_picture"],
        verificationCode: json["verification_code"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        deletedAt: json["deleted_at"],
        studentId: json["student_id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "status": status,
        "certified": certified,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "nationality": nationality,
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "student_id": studentId,
        "role": role,
      };
}
