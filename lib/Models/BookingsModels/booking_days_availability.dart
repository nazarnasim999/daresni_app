
import 'dart:convert';

BookingAvailableDays bookingAvailableDaysFromJson(String str) => BookingAvailableDays.fromJson(json.decode(str));


class BookingAvailableDays {
  bool? status;
  String? message;
  List<Datum> data;

  BookingAvailableDays({
     this.status,
     this.message,
     this.data=const [],
  });

  factory BookingAvailableDays.fromJson(Map<String, dynamic> json) => BookingAvailableDays(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int ?tutorId;
  String ?timezone;
  String ?datumBreak;
  String? durationTimeSlot;
  String? day;
  String? startTime;
  String? endTime;
  DateTime ?createdAt;
  DateTime? updatedAt;
  String? dayName;
  String? date;
  int ?totalBookedSlots;
  int ?totalTimeSlots;
  String? status;

  Datum({
     this.id,
     this.tutorId,
     this.timezone,
     this.datumBreak,
     this.durationTimeSlot,
     this.day,
     this.startTime,
     this.endTime,
     this.createdAt,
     this.updatedAt,
     this.dayName,
     this.date,
     this.totalBookedSlots,
     this.totalTimeSlots,
     this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    tutorId: json["tutor_id"],
    timezone: json["timezone"],
    datumBreak: json["break"],
    durationTimeSlot: json["duration_time_slot"],
    day: json["day"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    createdAt:json["created_at"]!=null? DateTime.parse(json["created_at"]):null,
    updatedAt:json["updated_at"]!=null? DateTime.parse(json["updated_at"]):null,
    dayName: json["dayName"],
    date: json["date"],
    totalBookedSlots: json["totalBookedSlots"],
    totalTimeSlots: json["totalTimeSlots"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tutor_id": tutorId,
    "timezone": timezone,
    "break": datumBreak,
    "duration_time_slot": durationTimeSlot,
    "day": day,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "dayName": dayName,
    "date": date,
    "totalBookedSlots": totalBookedSlots,
    "totalTimeSlots": totalTimeSlots,
    "status": status,
  };
}
