import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Pages/StudentLandingPages/home_page.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/tutor_info_tile.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorBookingPage extends StatefulWidget {
  const TutorBookingPage({super.key});

  @override
  State<TutorBookingPage> createState() => _TutorBookingPageState();
}

class _TutorBookingPageState extends State<TutorBookingPage> {
  @override
  void initState() {
    bookingController.getBookingsTutors();
    super.initState();
  }

  String? search;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchForPeople(
            onChange: (String? value) {
              setState(() {
                search = value;
              });
            },
          ),
          Text(
            "Booking List",
            style: AppTStyle.secondaryStyle12.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          GetBuilder(
            builder: (BookingController controller) {
              return Expanded(
                  child: ListView.builder(
                itemCount: bookingController.allBookings?.data?.bookingData?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  if (search == null || search?.isEmpty == true) {
                    return TutorInfoTile(
                        bookingData: bookingController.allBookings?.data?.bookingData?[index]);
                  }

                  return bookingController.allBookings?.data?.bookingData?[index].studentName
                              ?.contains(search ?? "") ==
                          true
                      ? TutorInfoTile(
                          bookingData: bookingController.allBookings?.data?.bookingData?[index])
                      : SizedBox();
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
