import 'dart:convert';

SingleStudentBookingsModels singleStudentBookingsModelsFromJson(String str) =>
    SingleStudentBookingsModels.fromJson(json.decode(str));

class SingleStudentBookingsModels {
  bool? status;
  String? message;
  Data? data;
  List<String>? errors;

  SingleStudentBookingsModels({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory SingleStudentBookingsModels.fromJson(Map<String, dynamic> json) =>
      SingleStudentBookingsModels(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        errors: List<String>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "errors": List<String>.from(errors!.map((x) => x)),
      };
}

class Data {
  int? id;
  Tutor? tutor;
  dynamic instituteId;
  dynamic course;
  Subject? subject;
  String? startTime;
  String? endTime;
  String? bookingDate;
  String? bookingTime;
  String? standard;
  String? zoomData;
  int? price;
  String? meetingStatus;

  Data.SingleStudentBooking({
    this.id,
    this.tutor,
    this.instituteId,
    this.course,
    this.subject,
    this.startTime,
    this.endTime,
    this.bookingDate,
    this.bookingTime,
    this.standard,
    this.zoomData,
    this.price,
    this.meetingStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data.SingleStudentBooking(
        id: json["id"],
        tutor: json["tutor"] != null ? Tutor.fromJson(json["tutor"]) : null,
        instituteId: json["institute_id"],
        course: json["course"],
        subject: json["subject"] != null ? Subject.fromJson(json["subject"]) : null,
        startTime: json["start_time"],
        endTime: json["end_time"],
        bookingDate: json["booking_date"],
        bookingTime: json["booking_time"],
        standard: json["standard"],
        zoomData: json["zoom_data"],
        price: json["price"],
        meetingStatus: json["meeting_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor": tutor?.toJson(),
        "institute_id": instituteId,
        "course": course,
        "subject": subject?.toJson(),
        "start_time": startTime,
        "end_time": endTime,
        "booking_date": bookingDate,
        "booking_time": bookingTime,
        "standard": standard,
        "zoom_data": zoomData,
        "price": price,
        "meeting_status": meetingStatus,
      };
}

class Subject {
  int? id;
  String? name;

  Subject({
    this.id,
    this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Tutor {
  int? id;
  User? user;

  Tutor({
    this.id,
    this.user,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) => Tutor(
        id: json["id"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? bio;
  String? profilePicture;

  User({
    this.id,
    this.name,
    this.email,
    this.bio,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        bio: json["bio"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "bio": bio,
        "profile_picture": profilePicture,
      };
}
