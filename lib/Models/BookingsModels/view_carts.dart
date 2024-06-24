import 'dart:convert';

ViewCartsModel viewCartsModelFromJson(String str) => ViewCartsModel.fromJson(json.decode(str));

class ViewCartsModel {
  bool status;
  String message;
  List<Carts>? data;
  List<String> errors;

  ViewCartsModel({
    this.status = false,
    this.message = '',
    this.data,
    this.errors = const [],
  });

  factory ViewCartsModel.fromJson(Map<String, dynamic> json) => ViewCartsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<Carts>.from(json["data"].map((x) => Carts.fromJson(x)))
            : null,
        errors: List<String>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class Carts {
  int? id;
  int? studentId;
  int? tutorId;
  String? sessionType;
  int? scheduleId;
  String? bookingDate;
  String? standard;
  String? startTime;
  String? endTime;
  String? pricing;
  String? tutorName;
  String? priceSymbol;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? subjectName;
  Subject? subject;
  bool? hasInstitute;

  Carts({
    this.id,
    this.studentId,
    this.tutorId,
    this.tutorName,
    this.sessionType,
    this.scheduleId,
    this.bookingDate,
    this.standard,
    this.startTime,
    this.endTime,
    this.pricing,
    this.priceSymbol,
    this.createdAt,
    this.updatedAt,
    this.subjectName,
    this.subject,
    this.hasInstitute,
  });

  factory Carts.fromJson(Map<String, dynamic> json) => Carts(
        id: json["id"],
        studentId: json["student_id"],
        tutorId: json["tutor_id"],
    tutorName: json["tutor_name"],
        sessionType: json["session_type"],
        scheduleId: json["schedule_id"],
        bookingDate: json["booking_date"],
        standard: json["standard"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        pricing: json["pricing"],
        priceSymbol: json["price_symbol"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subjectName: json["subject_name"],
        subject: json["subject"] != null ? Subject.fromJson(json["subject"]) : null,
        hasInstitute: json["has_institute"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "tutor_name": tutorName,
        "tutor_id": tutorId,
        "session_type": sessionType,
        "schedule_id": scheduleId,
        "booking_date": bookingDate,
        "standard": standard,
        "start_time": startTime,
        "end_time": endTime,
        "pricing": pricing,
        "price_symbol": priceSymbol,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "subject_name": subjectName,
        "subject": subject?.toJson(),
        "has_institute": hasInstitute,
      };
}

class Subject {
  int? id;
  Name? name;
  String? isParent;
  DateTime? createdAt;
  DateTime? updatedAt;

  Subject({
    this.id,
    this.name,
    this.isParent,
    this.createdAt,
    this.updatedAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: Name.fromJson(json["name"]),
        isParent: json["is_parent"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
