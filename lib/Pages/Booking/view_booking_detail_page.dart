import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/profile_dp.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/BookingsModels/student_booking_model.dart';

// ignore: must_be_immutable
class BookingDetailPage extends StatefulWidget {
  final BookTutor? tutor;

  BookingDetailPage(this.tutor, {super.key});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  @override
  void initState() {
    bookingController.viewSingleStudentBooking(widget.tutor?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.i(bookingController.singleStudentBookingsModels?.data?.tutor?.user?.email);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: AppButton(
          "Start Class",
          onTap: () async {
            try {
              if (bookingController.singleStudentBookingsModels?.data?.zoomData == null) {
                throw Exception('Could not launch Empty or Null Url');
              }
              final url =
                  Uri.parse(bookingController.singleStudentBookingsModels?.data?.zoomData ?? "");

              if (!await launchUrl(
                url,
                mode: LaunchMode.inAppWebView,
              )) {}
            } on Exception catch (e) {
              AppAlerts.showSnack("Zoom Data Not Available Yet");

              throw Exception('Could not launch $e');
            }
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "View Bookings",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GetBuilder<BookingController>(
        builder: (BookingController controller) {
          final data = bookingController.singleStudentBookingsModels?.data;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ProfileDP(
                    imageUrl: data?.tutor?.user?.profilePicture ?? "",
                    radius: 80,
                  ),
                  const SizedBox(height: 10),
                  Text(data?.tutor?.user?.name ?? "",
                      style: AppTStyle.primaryStyle12.copyWith(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("Bio:", style: AppTStyle.primaryStyle12.copyWith(fontSize: 16)),
                  Text(data?.tutor?.user?.bio ?? "Not Available", style: AppTStyle.regularStyle12),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Title Course :",
                        style: AppTStyle.secondaryStyle12.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      Text(
                        "Booked on : ",
                        style: AppTStyle.secondaryStyle12.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data?.bookingDate ?? "",
                        style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.appGreyColor, borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
                        child: Text(
                          data?.subject?.name ?? "",
                          style: AppTStyle.primaryStyle12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Session Date &Time Schedule :",
                    style: AppTStyle.secondaryStyle12.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(height: 20),
                      Text("${data?.startTime ?? ""} to ${data?.endTime ?? ""}",
                          style: AppTStyle.primaryStyle12)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(height: 1, color: AppTheme.appGreyColor),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "BHD.${data?.price ?? ""}/-",
                        style: AppTStyle.primaryStyle12
                            .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
