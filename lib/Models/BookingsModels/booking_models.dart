import 'dart:convert';

GetBookingModel getBookingModelFromJson(String str) => GetBookingModel.fromJson(json.decode(str));

class GetBookingModel {
  int? code;
  bool? status;
  Data? data;
  String? message;

  GetBookingModel({
    this.code,
    this.status,
    this.data,
    this.message,
  });

  factory GetBookingModel.fromJson(Map<String, dynamic> json) => GetBookingModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? currentPage;
  List<BookingData>? bookingData;
  String? nextPageUrl;
  int? prevPageUrl;
  int? total;
  int? lastPage;

  Data({
    this.currentPage,
    this.bookingData,
    this.nextPageUrl,
    this.prevPageUrl,
    this.total,
    this.lastPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        bookingData: json["data"] != null
            ? List<BookingData>.from(json["data"].map((x) => BookingData.fromJson(x)))
            : null,
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
        total: json["total"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(bookingData!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
        "total": total,
        "last_page": lastPage,
      };
}

class BookingData {
  int? id;
  String? studentName;
  String? studentProfile;
  StudentAddress? studentAddress;
  String? sessionType;
  Subject? subject;
  String? meetingStatus;
  String? bookingDate;
  String? bookingTime;
  String? startTime;
  String? endTime;
  String? zoomData;
  int? price;

  BookingData({
    this.id,
    this.studentName,
    this.studentProfile,
    this.studentAddress,
    this.sessionType,
    this.subject,
    this.meetingStatus,
    this.bookingDate,
    this.bookingTime,
    this.startTime,
    this.endTime,
    this.zoomData,
    this.price,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        id: json["id"],
        studentName: json["student_name"],
        studentProfile: json["student_profile"],
        studentAddress: json["student_address"] != null
            ? StudentAddress.fromJson(json["student_address"])
            : null,
        sessionType: json["session_type"],
        subject: Subject.fromJson(json["subject"]),
        meetingStatus: json["meeting_status"],
        bookingDate: json["booking_date"],
        bookingTime: json["booking_time"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        zoomData: json["zoom_data"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_name": studentName,
        "student_profile": studentProfile,
        "student_address": studentAddress?.toJson(),
        "session_type": sessionType,
        "subject": subject?.toJson(),
        "meeting_status": meetingStatus,
        "booking_date": bookingDate,
        "booking_time": bookingTime,
        "start_time": startTime,
        "end_time": endTime,
        "zoom_data": zoomData,
        "price": price,
      };
}

class StudentAddress {
  int? id;
  int? userId;
  String? flatNo;
  String? buildingNo;
  String? roadNo;
  String? blockNo;
  String? area;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? countryId;

  StudentAddress({
    this.id,
    this.userId,
    this.flatNo,
    this.buildingNo,
    this.roadNo,
    this.blockNo,
    this.area,
    this.createdAt,
    this.updatedAt,
    this.countryId,
  });

  factory StudentAddress.fromJson(Map<String, dynamic> json) => StudentAddress(
        id: json["id"],
        userId: json["user_id"],
        flatNo: json["flat_no"],
        buildingNo: json["building_no"],
        roadNo: json["road_no"],
        blockNo: json["block_no"],
        area: json["area"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        countryId: json["country_id"],
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
        "country_id": countryId,
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
