import 'dart:convert';

GetAllScheduleModel getAllScheduleModelFromJson(String str) =>
    GetAllScheduleModel.fromJson(json.decode(str));

String getAllScheduleModelToJson(GetAllScheduleModel data) => json.encode(data.toJson());

class GetAllScheduleModel {
  int? code;
  bool? status;
  List<Schedule>? scheduleList;

  GetAllScheduleModel({
    this.code,
    this.status,
    this.scheduleList,
  });

  factory GetAllScheduleModel.fromJson(Map<String, dynamic> json) => GetAllScheduleModel(
        code: json["code"],
        status: json["status"],
        scheduleList: json["data"] != null
            ? List<Schedule>.from(json["data"].map((x) => Schedule.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data":
            scheduleList != null ? List<dynamic>.from(scheduleList!.map((x) => x.toJson())) : null,
      };
}

class Schedule {
  int? id;
  int? tutorId;
  String? timezone;
  String? breakTime;
  String? durationTimeSlot;
  String? day;
  String? startTime;
  String? endTime;

  Schedule({
    this.id,
    this.tutorId,
    this.timezone,
    this.breakTime,
    this.durationTimeSlot,
    this.day,
    this.startTime,
    this.endTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        tutorId: json["tutor_id"],
        timezone: json["timezone"],
        breakTime: json["break"],
        durationTimeSlot: json["duration_time_slot"],
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor_id": tutorId,
        "timezone": timezone,
        "break": breakTime,
        "duration_time_slot": durationTimeSlot,
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
      };
}
