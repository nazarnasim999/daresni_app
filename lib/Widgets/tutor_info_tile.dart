import 'package:darasni/Models/BookingsModels/booking_models.dart';
import 'package:darasni/Pages/TutorLandingPages/view_student_profile_page.dart';
import 'package:darasni/Widgets/profile_dp.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../Utils/utils.dart';

class TutorInfoTile extends StatelessWidget {
  final BookingData? bookingData;
  const TutorInfoTile({this.bookingData, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppTheme.appGreyColor),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileDP(imageUrl: bookingData?.studentProfile ?? ""),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        bookingData?.studentName ?? "",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        bookingData?.subject?.name ?? "",
                        style: AppTStyle.secondaryStyle12.copyWith(fontWeight: FontWeight.w100),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Date: ",
                            style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            bookingData?.bookingDate ?? "",
                            style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Start Time:",
                            style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            bookingData?.startTime ?? "",
                            style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "End Time:",
                            style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            bookingData?.endTime ?? "",
                            style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  Column(
                    children: [
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: AppTheme.primaryColor,
                        ),
                        itemSize: 10,
                        onRatingUpdate: (rating) {
                          logger.i(rating);
                        },
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ViewStudentProfilePage(bookingData?.id));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.secondaryColor, borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "View Bookings",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
