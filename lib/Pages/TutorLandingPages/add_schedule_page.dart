import 'package:darasni/Controllers/Schedule/schedule_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Plugins/DropDownSearch/dropdown_search.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/custom_form_field.dart';
import 'package:darasni/Widgets/form_loading.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_zone_list/time_zone_list.dart';

import 'view_schedule_list.dart';

class AddSchedulePage extends StatefulWidget {
  AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final formKey = GlobalKey<FormState>();

  int? scheduleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.secondaryColor,
        title: Text(
          "Add Schedule",
          style: AppTStyle.primaryStyle12.copyWith(fontSize: 16, color: Colors.white),
        ),
        actions: [
          GestureDetector(
              onTap: () async {
                final result = await Get.to(() => const ViewScheduleList());
                if (result != null) {
                  scheduleId = result;

                  setState(() {});
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 20.0, right: 10),
                child: Text(
                  "Schedule List",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: AppButton(
          "${scheduleId != null ? "Update" : "Add"} Schedule",
          onTap: () {
            if (formKey.currentState!.validate()) {
              logger.wtf(scheduleId);
              if (scheduleId != null) {
                scheduleController.updateSchedule(scheduleId!);
                return;
              }

              scheduleController.addSchedule();
            }
          },
          prefix: const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder(
          builder: (ScheduleController controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Schedule Detail",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    GetBuilder(
                      initState: (GetBuilderState get) {
                        return scheduleController.getTimeZoneList();
                      },
                      builder: (ScheduleController ctrl) {
                        return ctrl.timeZoneList != null
                            ? DropdownSearch<TimeZoneInfo>(
                                validator: (TimeZoneInfo? ar) {
                                  if (ar?.tag == null) return "Required";
                                  if (ar!.tag!.isEmpty) return "Required";
                                  return null;
                                },
                                selectedItem: controller.timeZOne == null
                                    ? null
                                    : TimeZoneInfo(
                                        tag: controller.timeZOne, rawDstOffset: 0, rawOffset: 0),
                                isRequiredField: true,
                                title: "Your GMT",
                                items: ctrl.timeZoneList ?? [],
                                onChanged: (TimeZoneInfo? ar) {
                                  controller.setGMT(ar?.toString());
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                      hintText: "Not Selected",
                                      hintStyle: AppTStyle.secondaryStyle12),
                                ),
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      label: Text(
                                        "Search",
                                        style: TextStyle(
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const FormLoading();
                      },
                    ),
                    AppFormField(
                      forTutor: true,
                      title: "Add Breaks Between Bookings",
                      controller: controller.breakCtrl,
                      validator: (String? v) {
                        if (v!.isEmpty) return "Required";
                        return null;
                      },
                    ),
                    AppFormField(
                      forTutor: true,
                      title: "Duration",
                      controller: controller.timeSlotCtrl,
                      validator: (String? v) {
                        if (v!.isEmpty) return "Required";
                        return null;
                      },
                    ),
                    DropdownSearch<String>(
                      title: "Select Day",
                      items: controller.daysList,
                      onChanged: (String? days) {
                        controller.daysCtrl.text = days.toString();
                      },
                      validator: (String? v) {
                        if (v == null) return "Required";
                        if (v.isEmpty) return "Required";
                        return null;
                      },
                      itemAsString: (String? day) {
                        return day ?? "";
                      },
                      selectedItem:
                          controller.daysCtrl.text.isEmpty ? null : controller.daysCtrl.text,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                            hintText: "Not Selected", hintStyle: AppTStyle.secondaryStyle12),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: AppFormField(
                          forTutor: true,
                          title: "Start Time",
                          controller: controller.startTimeCtrl,
                          readOnly: true,
                          validator: (String? v) {
                            if (v!.isEmpty) return "Required";
                            return null;
                          },
                          onTap: () async {
                            TimeOfDay? time = await controller.getTime();
                            if (time == null) return;
                            controller.startTimeCtrl.text =
                                "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
                          },
                        )),
                        getTime("AM"),
                        getTime("PM"),
                        Expanded(
                            child: AppFormField(
                          forTutor: true,
                          title: "End Time",
                          controller: controller.endTimeCtrl,
                          validator: (String? v) {
                            if (v!.isEmpty) return "Required";
                            return null;
                          },
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? time = await controller.getTime();
                            if (time == null) return;
                            controller.endTimeCtrl.text =
                                "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
                          },
                        )),
                        getTime("AM"),
                        getTime("PM"),
                      ],
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getTime(txt) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.appGreyColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            txt,
            style: AppTStyle.primaryStyle12.copyWith(color: AppTheme.greyColor, fontSize: 8),
          ),
        ),
      ),
    );
  }
}
