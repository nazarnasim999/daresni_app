import 'dart:convert';

import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/tutor_list.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/profile_dp.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Booking/select_subject.dart';

class ViewTutorProfilePage extends StatelessWidget {
  final Tutors? tutor;

  const ViewTutorProfilePage({super.key, this.tutor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AppButton(
          "Book Now",
          onTap: () {
            Get.to(() => SelectSubjectPage(bookingController.tutorModel?.data));
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Tutor Profile",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: Get.width,
          child: SingleChildScrollView(
            child: GetBuilder(
              initState: (GetBuilderState<BookingController> state) {
                return bookingController.getTutorDetail(tutor?.tutorId);
              },
              builder: (BookingController controller) {
                Tutors? tutor = bookingController.tutorModel?.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ProfileDP(
                              radius: 50,
                              imageUrl: tutor?.profilePicture ?? "",
                            ),
                            if (tutor?.certified == 0)
                              Positioned(
                                right: 0,
                                child: Image.asset(
                                  ImageRes.assetsVerifiedUser,
                                  height: 30,
                                  width: 30,
                                ),
                              )
                          ],
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    tutor?.name ?? "",

                                    style: AppTStyle.secondaryStyle12
                                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            const SizedBox(height: 7),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: tutor?.rating?.toDouble() ?? 0.0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: AppTheme.primaryColor,
                                  ),
                                  itemSize: 15,
                                  onRatingUpdate: (rating) {
                                    logger.i(rating);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Text(
                                  "BHD ${tutor?.pricing ?? ""}",
                                  style: AppTStyle.primaryStyle18,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: AppTheme.primaryColor,
                            size: 25,
                          ),
                          onPressed: () async {
                            await launchUrl(
                                Uri.parse(
                                    'https://wa.me/?text=https://play.google.com/store/apps/details?id=com.daresni.tutor.student.net'),
                                mode: LaunchMode.externalApplication);
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(height: 1, color: AppTheme.greyColor),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Location: ",
                          style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          tutor?.hasAddress?.country?.name ?? "Not Available",
                          style: AppTStyle.secondaryStyle12.copyWith(fontSize: 12),
                        ),
                        // Text(
                        //   tutor?.nationality?.name ?? "",
                        //   style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14),
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Nationality: ",
                          style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          tutor?.nationality?.name ?? "",
                          style: AppTStyle.secondaryStyle12.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Experience: ",
                          style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${tutor?.workExperience ?? ""} Years",
                          style: AppTStyle.secondaryStyle12.copyWith(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Language: ",
                          style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                        ),

                        Text(
                          tutor?.primaryLanguage?.name?.en??"",
                          style: AppTStyle.secondaryStyle12.copyWith(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Gender: ",
                          style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          tutor?.gender?.name.capitalize ?? "",
                          style: AppTStyle.secondaryStyle12.copyWith(),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How to Teach: ",
                          style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            howToTeach(tutor?.howToTeach),
                            style: AppTStyle.secondaryStyle12.copyWith(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Offer Services: ",
                          style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            tutor?.offerServices ?? "",
                            style: AppTStyle.secondaryStyle12.copyWith(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(height: 1, color: AppTheme.greyColor),
                    const SizedBox(height: 10),
                    Text(
                      "Bio:",
                      style: AppTStyle.primaryStyle12
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(getTutorBio(tutor?.bio ?? "")),
                    const SizedBox(height: 10),
                    Container(height: 1, color: AppTheme.greyColor),
                    const SizedBox(height: 10),
                    Text(
                      "Expertise in Subjects:",
                      style: AppTStyle.primaryStyle12
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                if (tutor?.subjects != null)
                Wrap(
                // children: subjectsGroupedByParentName(tutor!.subjects!),
                children: subjectsGroupedByParentName(convertSubjectsToListOfMaps(tutor!.subjects!)),
                ),
                    // if (tutor?.subjects != null)
                    //   Wrap(
                    //       children: tutor!.subjects!
                    //           .map(
                    //             (e) => subjects(e.name?.en ?? ""),
                    //       )
                    //           .toList()),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String howToTeach(String? value) {
    if (value == null)
      return "";
    else if (value.toLowerCase() == "ss")
      return "Online Session";
    else
      return "Both(Online / Physical Session)";
  }

  Widget subjects(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration:
        BoxDecoration(color: AppTheme.appGreyColor, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style:
                  AppTStyle.secondaryStyle12.copyWith( fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> convertSubjectsToListOfMaps(List<Subject> subjects) {
    return subjects.map((subject) {
      // Convert ParentName to JSON string
      String parentNameJson = jsonEncode(subject.parentName?.toJson() ?? {});

      // Decode JSON string into a map
      Map<String, dynamic> parentNameMap = {};
      if (parentNameJson.isNotEmpty) {
        parentNameMap = jsonDecode(parentNameJson);
      }

      return {
        'name': {'en': subject.name?.en}, // Assuming Name has an 'en' property
        'parent_name': parentNameMap['en'] ?? '', // Use the 'en' key for English name, provide fallback value if null
      };
    }).toList();
  }



  List<Widget> subjectsGroupedByParentName(List<Map<String, dynamic>> subjects) {
    // Create a map to store subjects grouped by parent name
    Map<String, List<Map<String, dynamic>>> groupedSubjects = {};

    // Group subjects by parent name
    subjects.forEach((subject) {
      String parentName = subject['parent_name'];
      if (!groupedSubjects.containsKey(parentName)) {
        groupedSubjects[parentName] = [];
      }
      groupedSubjects[parentName]!.add(subject);
    });

    // Create widgets for each group of subjects
    return groupedSubjects.entries.map((entry) {
      String parentName = entry.key;
      List<Map<String, dynamic>> subjectsInGroup = entry.value;
      return subjectsWidget(parentName, subjectsInGroup);
    }).toList();
  }

  Widget subjectsWidget(String parentName, List<Map<String, dynamic>> subjects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.appGreyColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                parentName,
                style: AppTStyle.secondaryStyle12.copyWith(fontWeight: FontWeight.bold , fontSize: 14),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: subjects.map((subject) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppTheme.greyColor, // Specify the border color here
                  ),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    subject['name']['en'],
                    style: AppTStyle.secondaryStyle10.copyWith(fontSize: 12),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }


  Widget listSubjects(List<Map<String, dynamic>> subjects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: subjects.map((subject) {
        String parentName = subject['parent_name'];
        List<Map<String, dynamic>> subjectsWithName = subjects
            .where((s) => s['parent_name'] == parentName)
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.appGreyColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    parentName,
                    style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: subjectsWithName
                  .map((subject) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.appGreyColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      subject['name']['en'],
                      style: AppTStyle.secondaryStyle12.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ))
                  .toList(),
            ),
          ],
        );
      }).toList(),
    );
  }

  String getTutorBio(String bio) {
    return bio.replaceAll("<br />", "");
  }
}
