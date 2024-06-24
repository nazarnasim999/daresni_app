import 'package:darasni/Models/BookingsModels/student_booking_model.dart';
import 'package:darasni/Widgets/profile_dp.dart';
import 'package:darasni/extensions.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingInfoTile extends StatelessWidget {
  final BookTutor? tutor;
  final VoidCallback? onTap;
  const BookingInfoTile(this.tutor, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          height: Get.height * .15,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: const Color(0xffBFBFBF),
              )),
          child: Row(
            children: [
              ProfileDP(imageUrl: tutor?.tutorProfile ?? ""),
              const SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        tutor?.tutorName?.subStringName ?? "",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        ImageRes.assetsVerifiedUser,
                        height: 15,
                        width: 15,
                      )
                    ],
                  ),
                  Text(
                    "Expertise : ${tutor?.tutorExpertise?.substring15 ?? ""}",
                    style: AppTStyle.secondaryStyle12
                        .copyWith(fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Booking Date : ${tutor?.bookingDate ?? ""}",
                    style: AppTStyle.primaryStyle12
                        .copyWith(fontSize: 10, fontWeight: FontWeight.w200),
                  ),

                  // const SizedBox(height: 5),
                ],
              ),
              const Expanded(child: SizedBox.shrink()),
              Row(
                children: [
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: onTap,
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
              )
            ],
          )),
    );
  }
}
