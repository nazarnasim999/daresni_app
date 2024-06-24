import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Pages/Booking/booking_summary.dart';
import 'package:darasni/Pages/StudentLandingPages/home_page.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/tutor_list.dart';

class SelectSubjectPage extends StatelessWidget {
  final Tutors? tutors;
  const SelectSubjectPage(this.tutors, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder(
          builder: (BookingController controller) {
            return AppButton(
              "Select & Next",
              onTap: controller.subjectID == null
                  ? null
                  : () {
                      Get.to(() => BookingSummaryPage(tutors: tutors));
                    },
            );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Select Subject",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchForPeople(
              onChange: (String value) {},
            ),
            Text(
              "Subject List",
              style: AppTStyle.primaryStyle12.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // Expanded(child: GetBuilder(
            //   builder: (BookingController controller) {
            //     return ListView.builder(
            //       itemCount: tutors?.subjects?.length ?? 0,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Container(
            //           margin: const EdgeInsets.only(bottom: 5, top: 5),
            //           decoration: BoxDecoration(
            //             border: Border.all(color: AppTheme.appGreyColor, width: 1.0),
            //             borderRadius: BorderRadius.circular(
            //                 5), // Optional: Set a border radius for rounded corners
            //           ),
            //           child: RadioListTile(
            //             dense: true,
            //             toggleable: true,
            //             activeColor: AppTheme.primaryColor,
            //             controlAffinity: ListTileControlAffinity.trailing,
            //             title: Text(tutors?.subjects?[index].name?.en ?? ""),
            //             value: tutors?.subjects?[index].subjectId,
            //             groupValue: controller.subjectID,
            //             onChanged: (v) {
            //               controller.subjectID = v;
            //               controller.update();
            //             },
            //           ),
            //         );
            //       },
            //     );
            //   },
            // ))

            Expanded(
              child: GetBuilder(
                builder: (BookingController controller) {
                  // Group subjects by parentName
                  Map<String?, List<Subject>> groupedSubjects = {};

                  tutors?.subjects?.forEach((subject) {
                    String? parentName = subject.parentName?.en;
                    if (!groupedSubjects.containsKey(parentName)) {
                      groupedSubjects[parentName] = [];
                    }
                    groupedSubjects[parentName]?.add(subject);
                  });

                  return ListView(
                    children: groupedSubjects.entries.map((entry) {
                      String? parentName = entry.key;
                      List<Subject>? subjectsInGroup = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (parentName != null) // Check if parentName is not null
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                parentName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: subjectsInGroup?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 5, top: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppTheme.appGreyColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: RadioListTile(
                                  dense: true,
                                  toggleable: true,
                                  activeColor: AppTheme.primaryColor,
                                  controlAffinity: ListTileControlAffinity.trailing,
                                  title: Text(subjectsInGroup?[index].name?.en ?? ""),
                                  value: subjectsInGroup?[index].subjectId,
                                  groupValue: controller.subjectID,
                                  onChanged: (v) {
                                    controller.subjectID = v;
                                    controller.update();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
