import 'dart:convert';

GetTimeSlotModel getTimeSlotModelFromJson(String str) =>
    GetTimeSlotModel.fromJson(json.decode(str));

class GetTimeSlotModel {
  bool status;
  String message;
  List<TimeSlots>? data;
  List<dynamic> errors;

  GetTimeSlotModel({
    this.status = false,
    this.message = '',
    this.data,
    this.errors = const [],
  });

  factory GetTimeSlotModel.fromJson(Map<String, dynamic> json) => GetTimeSlotModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<TimeSlots>.from(json["data"].map((x) => TimeSlots.fromJson(x)))
            : null,
        errors: json["errors"] != null ? List<dynamic>.from(json["errors"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class TimeSlots {
  int? id;
  int? tutorId;
  int? scheduleId;
  String? day;
  String? startTime;
  String? endTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  TimeSlots({
    this.id,
    this.tutorId,
    this.scheduleId,
    this.day,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  factory TimeSlots.fromJson(Map<String, dynamic> json) => TimeSlots(
        id: json["id"],
        tutorId: json["tutor_id"],
        scheduleId: json["schedule_id"],
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor_id": tutorId,
        "schedule_id": scheduleId,
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
