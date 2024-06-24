import 'dart:convert';

GetAvailabilityModel getAvailabilityModelFromJson(String str) =>
    GetAvailabilityModel.fromJson(json.decode(str));

class GetAvailabilityModel {
  bool status;
  String message;
  List<AvaiableDays> data;
  List<dynamic> error;

  GetAvailabilityModel({
    this.status = false,
    this.message = '',
    this.data=const [],
    this.error = const [],
  });

  factory GetAvailabilityModel.fromJson(Map<String, dynamic> json) => GetAvailabilityModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<AvaiableDays>.from(json["data"].map((x) => AvaiableDays.fromJson(x)))
            : [],
        error: json["error"] != null ? List<dynamic>.from(json["error"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": List<dynamic>.from(error.map((x) => x)),
      };
}

class AvaiableDays {
  int? scheduleId;
  String? timezone;
  String? datumBreak;
  String? durationTimeSlot;
  String? day;
  String? startTime;
  String? endTime;

  AvaiableDays({
    this.scheduleId,
    this.timezone,
    this.datumBreak,
    this.durationTimeSlot,
    this.day,
    this.startTime,
    this.endTime,
  });

  factory AvaiableDays.fromJson(Map<String, dynamic> json) => AvaiableDays(
        scheduleId: json["schedule_id"],
        timezone: json["timezone"],
        datumBreak: json["break"],
        durationTimeSlot: json["duration_time_slot"],
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "schedule_id": scheduleId,
        "timezone": timezone,
        "break": datumBreak,
        "duration_time_slot": durationTimeSlot,
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
      };
}
