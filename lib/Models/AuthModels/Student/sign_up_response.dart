import 'dart:convert';

StudentRegistration studentRegistrationFromJson(String str) =>
    StudentRegistration.fromJson(json.decode(str));

class StudentRegistration {
  bool status;
  String message;
  Data? data;
  List<String> errors;

  StudentRegistration({
    this.status = false,
    this.message = "",
    this.data,
    this.errors = const [],
  });

  factory StudentRegistration.fromJson(Map<String, dynamic> json) => StudentRegistration(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        // data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        errors: json["errors"] != null ? List<String>.from(json["errors"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class Data {
  String? name;
  String? email;
  String? gender;
  DateTime? dob;
  String? nationality;
  String? contactNo;
  dynamic nationalId;

  int? id;

  Data({
    this.name,
    this.email,
    this.gender,
    this.dob,
    this.nationality,
    this.contactNo,
    this.nationalId,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        nationality: json["nationality"],
        contactNo: json["contact_no"],
        nationalId: json["national_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "gender": gender,
        "nationality": nationality,
        "contact_no": contactNo,
        "national_id": nationalId,
        "id": id,
      };
}
