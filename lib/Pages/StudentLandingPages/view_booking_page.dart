import '/Controllers/Booking%20Controller/booking_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/BookingsModels/student_booking_model.dart';
import '/Pages/Booking/view_booking_detail_page.dart';
import '/Pages/StudentLandingPages/home_page.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/booking_info_tile.dart';

class ViewBookingPage extends StatefulWidget {
  const ViewBookingPage({super.key});

  @override
  State<ViewBookingPage> createState() => _ViewBookingPageState();
}

class _ViewBookingPageState extends State<ViewBookingPage> {
  String searchValue = "";

  @override
  void initState() {
    bookingController.getAllBookingsStudent();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Bookings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GetBuilder<BookingController>(
          builder: (BookingController controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SearchForPeople(
                  onChange: (String value) {
                    searchValue = value.toLowerCase();
                    setState(() {});
                  },
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: controller.studentBookingsModels?.data?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    BookTutor? data = controller.studentBookingsModels?.data?.data?[index];

                    return data?.tutorName?.toLowerCase().contains(searchValue) == true
                        ? BookingInfoTile(
                            data,
                            onTap: () {
                              Get.to(() => BookingDetailPage(data));
                            },
                          )
                        : SizedBox();
                  },
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
