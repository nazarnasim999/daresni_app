// ignore_for_file: must_be_immutable

import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/tutor_list.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../Utils/utils.dart';
import 'select_date_time.dart';

class BookingSummaryPage extends StatefulWidget {
  Tutors? tutors;

  BookingSummaryPage({this.tutors, super.key});

  @override
  State<BookingSummaryPage> createState() => _BookingSummaryPageState();
}

class _BookingSummaryPageState extends State<BookingSummaryPage> {
  @override
  void initState() {
    bookingController.getAvailability(widget.tutors?.tutorId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder(
          builder: (BookingController controller) {
            return AppButton(
              "Select & Next",
              onTap: controller.howToTeach == null
                  ? null
                  : () => Get.to(() => SelectDateTimeBooking(widget.tutors)),
            );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Summary",
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
            const SizedBox(height: 10),
            Text(
              "Short Summary",
              style: AppTStyle.primaryStyle12.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      bookingController.tutorModel?.data?.name ?? "",
                      style: AppTStyle.primaryStyle12
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      ImageRes.assetsVerifiedUser,
                      height: 15,
                      width: 15,
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    // RatingBar.builder(
                    //   initialRating: bookingController.tutorModel?.data?.rating?.toDouble() ?? 0,
                    //   minRating: 0,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: false,
                    //   ignoreGestures: true,
                    //   itemCount: 5,
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star,
                    //     color: AppTheme.primaryColor,
                    //   ),
                    //   itemSize: 15,
                    //   onRatingUpdate: (rating) {
                    //     logger.i(rating);
                    //   },
                    // ),
                  ],
                ),
                // const SizedBox(height: 7),
                // Row(
                //   children: [
                //     Icon(Icons.pin_drop, color: AppTheme.primaryColor),
                //     Text(
                //       bookingController.tutorModel?.data?.nationality?.name ?? "",
                //       style: AppTStyle.secondaryStyle12
                //           .copyWith(fontSize: 10, fontWeight: FontWeight.w300),
                //     ),
                //   ],
                // ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Selected Subjects",
              style: AppTStyle.secondaryStyle12.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 7),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(5)),
              child: Text(
                "${bookingController.tutorModel?.data?.subjects
                        ?.firstWhere((element) => element.subjectId == bookingController.subjectID)
                        .parentName
                        ?.en ??
                    ""} - ${bookingController.tutorModel?.data?.subjects
                    ?.firstWhere((element) => element.subjectId == bookingController.subjectID)
                    .name
                    ?.en ??
                    ""}",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 1,
              color: AppTheme.greyColor,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GetBuilder(

                builder: (BookingController controller) {

                  return
                    // ListView.builder(
                    // itemCount: getTutorsSessionType().length,
                    // itemBuilder: (BuildContext context, int index) {
                    //
                    //
                    //   return RadioListTile<String>(
                    //     dense: true,
                    //     toggleable: true,
                    //     activeColor: AppTheme.primaryColor,
                    //     title: Text(
                    //       getTutorsSessionType()[index].title,
                    //       style: AppTStyle.secondaryStyle12,
                    //     ),
                    //     value: getTutorsSessionType()[index].value,
                    //     groupValue: controller.howToTeach,
                    //     onChanged: (String? value) {
                    //
                    //       controller.howToTeach = value;
                    //       controller.update();
                    //     },
                    //   );


                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getTutorsSessionType().length,
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
                              title: Text(getTutorsSessionType()[index].title),
                              value: getTutorsSessionType()[index].value,
                              groupValue: controller.howToTeach,
                              onChanged: (String? value) {

                                controller.howToTeach = value;
                                controller.update();
                              },
                            ),
                          );

                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<TeachingsWay> getTutorsSessionType() {
    if (widget.tutors?.howToTeach == null)
      return [];
    else if (widget.tutors?.howToTeach == "os")
      return [TeachingsWay("Online Session", "os")];
    else if (widget.tutors?.howToTeach == "ps")
      return [TeachingsWay("Physical Session", "ps")];
    else if (widget.tutors?.howToTeach == "ph")
      return [TeachingsWay("Physical Session", "ps")];
    else if (widget.tutors?.howToTeach == "both")
      return [TeachingsWay("Online Session", "os"), TeachingsWay("Physical Session", "ph")];
    else
      return [];
  }
}
