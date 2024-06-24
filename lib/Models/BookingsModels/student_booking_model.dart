import 'dart:convert';

StudentBookingsModels? studentBookingsModelsFromJson(String? str) {
  if (str == null) return null;

  return StudentBookingsModels.fromJson(json.decode(str));
}

class StudentBookingsModels {
  bool? status;
  String? message;
  StudentBooking? data;
  List<dynamic>? errors;

  StudentBookingsModels({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory StudentBookingsModels.fromJson(Map<String, dynamic> json) => StudentBookingsModels(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? StudentBooking.fromJson(json["data"]) : null,
        errors: json["errors"] != null ? List<dynamic>.from(json["errors"].map((x) => x)) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "errors": List<dynamic>.from(errors!.map((x) => x)),
      };
}

class StudentBooking {
  int? currentPage;
  List<BookTutor>? data;
  String? nextPageUrl;
  String? prevPageUrl;
  int? total;
  int? lastPage;

  StudentBooking({
    this.currentPage,
    this.data,
    this.nextPageUrl,
    this.prevPageUrl,
    this.total,
    this.lastPage,
  });

  factory StudentBooking.fromJson(Map<String, dynamic> json) => StudentBooking(
        currentPage: json["current_page"],
        data: json["data"] != null
            ? List<BookTutor>.from(json["data"].map((x) => BookTutor.fromJson(x)))
            : null,
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
        total: json["total"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
        "total": total,
        "last_page": lastPage,
      };
}

class BookTutor {
  int? id;
  String? tutorName;
  String? tutorProfile;
  String? tutorExpertise;
  String? bookingDate;

  BookTutor({
    this.id,
    this.tutorName,
    this.tutorProfile,
    this.tutorExpertise,
    this.bookingDate,
  });

  factory BookTutor.fromJson(Map<String, dynamic> json) => BookTutor(
        id: json["id"],
        tutorName: json["tutor_name"],
        tutorProfile: json["tutor_profile"],
        tutorExpertise: json["tutor_expertise"],
        bookingDate: json["booking_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor_name": tutorName,
        "tutor_profile": tutorProfile,
        "tutor_expertise": tutorExpertise,
        "booking_date": bookingDate,
      };
}
