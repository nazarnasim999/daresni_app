import 'package:darasni/Controllers/Schedule/schedule_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewScheduleList extends StatefulWidget {
  const ViewScheduleList({super.key});

  @override
  State<ViewScheduleList> createState() => _ViewScheduleListState();
}

class _ViewScheduleListState extends State<ViewScheduleList> {
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GetBuilder(
              initState: (GetBuilderState<ScheduleController> ctrl) {
                return scheduleController.getSchedule();
              },
              builder: (ScheduleController controller) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: controller.getAllScheduleModel?.scheduleList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final data = controller.getAllScheduleModel?.scheduleList?[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppTheme.appGreyColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Time Zone : ",
                                    style: AppTStyle.secondaryStyle12
                                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data?.timezone ?? "",
                                    style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                                  ),
                                  const Expanded(child: SizedBox.shrink()),
                                  GestureDetector(
                                    onTap: () {
                                      controller.setValues(data!);
                                      Get.back(result: data.id);
                                    },
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Selected Date : ",
                                    style: AppTStyle.secondaryStyle12
                                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data?.startTime ?? "",
                                    style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                                  ),
                                  const Expanded(child: SizedBox.shrink()),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Selected Day : ",
                                    style: AppTStyle.secondaryStyle12
                                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    controller.getDay(data?.day),
                                    style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Time Schedule : ",
                                    style: AppTStyle.secondaryStyle12
                                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${data?.startTime ?? ""} to ${data?.endTime ?? ""}",
                                    style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                                  ),
                                  const Expanded(child: SizedBox.shrink()),
                                  GestureDetector(
                                    onTap: () async {
                                      await showAlertDialog().then((value) {
                                        if (value) {
                                          return controller.deleteSchedule(data!.id!);
                                        }

                                        return;
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppTheme.secondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showAlertDialog() async {
    bool res = false;

    await showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AlertDialog(
              title: Row(
                children: [
                  Text("Are you sure you want to ",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16)),
                  const SizedBox(height: 5),
                  Text("Delete?",
                      style: AppTStyle.primaryStyle12
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'No',
                    style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16),
                  ),
                  onPressed: () {
                    res = false;
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Yes',
                    style: AppTStyle.primaryStyle12.copyWith(fontSize: 16),
                  ),
                  onPressed: () {
                    res = true;

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    return res;
  }
}
