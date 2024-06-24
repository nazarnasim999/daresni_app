import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/BookingsModels/booking_models.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewStudentProfilePage extends StatefulWidget {
  final int? bookingID;

  const ViewStudentProfilePage(this.bookingID, {super.key});

  @override
  State<ViewStudentProfilePage> createState() => _ViewStudentProfilePageState();
}

class _ViewStudentProfilePageState extends State<ViewStudentProfilePage> {
  @override
  void initState() {
    bookingController.getSingleBookings(widget.bookingID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Booking",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        backgroundColor: AppTheme.secondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GetBuilder(
          builder: (BookingController controller) {
            BookingData? bookingData = controller.singleBooking?.bookingData;
            return controller.singleBooking?.bookingData!=null?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      "Booked On: ",
                      style: AppTStyle.secondaryStyle12.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${bookingData?.bookingDate} - ${bookingData?.bookingTime}",
                      style: AppTStyle.primaryStyle12.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: AppTheme.orangeColor,
                      ),
                      itemSize: 10,
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: AppTheme.appGreyColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Student Name : ",
                              style: AppTStyle.secondaryStyle12.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              bookingData?.studentName ?? "",
                              style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "Location :",
                              style: AppTStyle.secondaryStyle12.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              bookingData?.studentAddress?.area??"NA",
                              style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Session Date &Time Schedule :",
                          style: AppTStyle.secondaryStyle12.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: AppTheme.primaryColor,
                              size: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${bookingData?.startTime} to ${bookingData?.endTime}",
                              // "13 - 14 - 15 ( Mon - Thu - Wed )",
                              style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: AppTheme.primaryColor,
                              size: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Evening : 2:00pm to 6:00pm",
                              style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "Session Type :",
                              style: AppTStyle.secondaryStyle12.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              bookingData?.sessionType ?? "",
                              style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Title Course :",
                  style: AppTStyle.secondaryStyle12
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    subjects(bookingData?.subject?.name ?? ""),
                    // subjects("Programming"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      "Start Class With Zoom :",
                      style: AppTStyle.secondaryStyle12.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    // Text(
                    //   " None",
                    //   style: AppTStyle.primaryStyle12.copyWith(
                    //     fontSize: 14,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 10),
                if (bookingData?.sessionType != "physical session")
                  SizedBox(
                    width: Get.width * .35,
                    child: AppButton(
                      "Start Class",
                      onTap: () async {
                        final url = Uri.parse(bookingData?.zoomData ?? "");
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('Could not launch $url');
                        }
                      },
                    ),
                  ),
                const SizedBox(height: 10),
                Container(height: 1, color: AppTheme.greyColor),
                const SizedBox(height: 10),
                Text(
                  "Status :",
                  style: AppTStyle.secondaryStyle12
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(child: GetBuilder(
                  builder: (BookingController controller) {
                    return ListView.builder(
                      itemCount: controller.statusList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: controller.studentStatus != controller.statusList[index]
                                    ? AppTheme.appGreyColor
                                    : AppTheme.primaryColor,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: RadioListTile(
                            dense: true,
                            toggleable: true,
                            activeColor: AppTheme.primaryColor,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(controller.statusList[index]),
                            value: controller.statusList[index].toLowerCase(),
                            groupValue: bookingData?.meetingStatus ?? "",
                            onChanged: (v) {
                              logger.i(v);
                              controller.changeStudentStatus(v.toString());
                            },
                          ),
                        );
                      },
                    );
                  },
                ))
              ],
            ):SizedBox();
          },
        ),
      ),
    );
  }

  Widget subjects(text) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.appGreyColor, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [Text(text, style: AppTStyle.primaryStyle12)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
