import 'package:darasni/Models/ScheduleModels/all_schedule.dart';
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_zone_list/time_zone_list.dart';

import '../../Utils/utils.dart';

class ScheduleController extends GetxController {
  final TextEditingController breakCtrl = TextEditingController();
  final TextEditingController timeSlotCtrl = TextEditingController();
  final TextEditingController daysCtrl = TextEditingController();
  final TextEditingController startTimeCtrl = TextEditingController();
  final TextEditingController endTimeCtrl = TextEditingController();

  List<TimeZoneInfo>? timeZoneList;
  String? timeZOne;
  final List<String> daysList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  String getDay(String? day) {
    if (day == null || day.isEmpty) return "";

    return daysList.elementAt(int.parse(day));
  }

  void getTimeZoneList() async {
    timeZoneList = await TimeZoneList.getList(
      DateTime(2020, 5, 8, 8, 8, 8),
    );
    update();
  }

  GetAllScheduleModel? getAllScheduleModel;

  void getSchedule() async {
    Future.delayed(Duration.zero, () {
      showProgress();
    });
    final res = await ApiService.getMethod(url: ApiUrls.GET_SCHEDULE);
    stopProgress();
    if (res == null || res.statusCode != 200) {
      return;
    }
    getAllScheduleModel = getAllScheduleModelFromJson(res.body);
    update();
  }

  void addSchedule() async {
    showProgress();
    Map<String, dynamic> body = {
      "timezone": timeZOne ?? "",
      "breaks": breakCtrl.text,
      "duration_time_slot": timeSlotCtrl.text,
      "days": [daysCtrl.text],
      "start_time": [startTimeCtrl.text],
      "end_time": [endTimeCtrl.text]
    };
    print(body);
    final res = await ApiService.postMethod(url: ApiUrls.ADD_SCHEDULE, body: body);
    stopProgress();
    logger.i(res?.body);
    if (res == null || res.statusCode != 200) return;

    clearCtrl();

    update();
  }

  void setValues(Schedule schedule) {
    logger.i(schedule.toJson());
    timeZOne = schedule.timezone;
    breakCtrl.text = schedule.breakTime ?? "";
    timeSlotCtrl.text = schedule.durationTimeSlot ?? "";
    daysCtrl.text = getDay(schedule.day);
    startTimeCtrl.text = schedule.startTime ?? "";
    endTimeCtrl.text = schedule.endTime ?? "";

    update();
  }

  void updateSchedule(int id) async {
    showProgress();
    Map<String, String> body = {
      "schedule_id": id.toString(),
      "timezone": timeZOne ?? "",
      "breaks": breakCtrl.text,
      "duration_time_slot": timeSlotCtrl.text,
      "days": [daysCtrl.text].toString(),
      "start_time": [startTimeCtrl.text].toString(),
      "end_time": [endTimeCtrl.text].toString()
    };
    logger.i(body);
    final res = await ApiService.postMethod(url: ApiUrls.UPDATE_SCHEDULE, body: body);
    stopProgress();
    if (res == null || res.statusCode != 200) return;

    logger.i(res.body);
    clearCtrl();

    update();
  }

  void deleteSchedule(int id) async {
    logger.e(id);
    Future.delayed(Duration.zero, () {
      showProgress();
    });
    final res = await ApiService.postMethod(
        url: ApiUrls.DELETE_SCHEDULE, body: {"schedule_id": id.toString()});
    stopProgress();
    if (res == null || res.statusCode != 200) {
      return;
    }

    getAllScheduleModel?.scheduleList?.removeWhere((element) => element.id == id);
    update();
  }

  Future<TimeOfDay?> getTime() async {
    return await showTimePicker(
      context: Get.context!,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );
  }

  void setGMT(String? timeZone) {
    timeZOne = timeZone;
    update();
  }

  void clearCtrl() {
    timeZOne = null;
    breakCtrl.clear();
    timeSlotCtrl.clear();
    daysCtrl.clear();
    startTimeCtrl.clear();
    endTimeCtrl.clear();
  }
}
