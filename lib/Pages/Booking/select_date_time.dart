
import 'package:intl/intl.dart';

import '/Controllers/Booking%20Controller/booking_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/BookingsModels/get_time_slots.dart';
import '/Models/tutor_list.dart';
import '/Pages/Booking/order_rivew.dart';
import '/Plugins/CalendarDatePicker/src/models/calendar_date_picker2_config.dart';
import '/Plugins/CalendarDatePicker/src/widgets/calendar_date_picker2.dart';
import '/Widgets/app_button.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDateTimeBooking extends StatefulWidget {
  final Tutors? tutors;

  const SelectDateTimeBooking(this.tutors, {super.key});

  @override
  State<SelectDateTimeBooking> createState() => _SelectDateTimeBookingState();
}

class _SelectDateTimeBookingState extends State<SelectDateTimeBooking> {
  @override
  void initState() {
    bookingController.getAvailabilityDays(widget.tutors?.tutorId).then((value) {
      setState(() {});
    });

    // bookingController.getAvailability(widget.tutors?.tutorId);

    super.initState();
  }

  List<DateTime> availableList = <DateTime>[];
DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder(
          builder: (BookingController controller) {
            return AppButton(
              "Add to Cart",
              onTap: controller.timeSlots == null
                  ? null
                  : () {
                      bookingController
                          .addToCart(widget.tutors?.tutorId)
                          .then((value) => Get.to(() => CartsReviewPage()));
                    },
            );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Book Your Time & Date",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text("Pick a date", style: AppTStyle.primaryStyle12.copyWith(fontSize: 16)),
            const SizedBox(height: 10),
            GetBuilder<BookingController>(
              initState: (GetBuilderState state) {},
              builder: (
                BookingController controller,
              ) {
                return controller.bookingAvailableDays != null
                    ? CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          selectedDayHighlightColor: Colors.grey.withOpacity(.5),
                          calendarType: CalendarDatePicker2Type.single,
                          firstDate: DateTime.now(),
                          currentDate:selectedDate ,

                          dayBuilder: ({
                            required date,
                            textStyle,
                            decoration,
                            isSelected,
                            isDisabled,
                            isToday,
                          }) {
                            Widget? dayWidget;
                            for (var element in controller.bookingAvailableDays!.data) {
                              RegExp regExp = RegExp(r'(?<=-)\d{1,2}$');
                              String? day = regExp.firstMatch(element.date ?? "")?.group(0);

                              RegExp regExpMonth = RegExp(r'(?<=-)\d{1,2}(?=-)');
                              String? month = regExpMonth.firstMatch(element.date ?? "")?.group(0);

                              final selected = date.day.toString() == day;
                              final selectedMonth = date.month.toString() == month;
                              final available = element.status == "Available";

                              if (selected && selectedMonth) {
                                dayWidget = Container(
                                  decoration: decoration,
                                  child: Center(
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Text(
                                          MaterialLocalizations.of(context).formatDecimal(date.day),
                                          style: textStyle,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 27.5),
                                          child: Container(
                                            height: 6,
                                            width: 6,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: available == true
                                                  ? AppTheme.secondaryColor
                                                  : AppTheme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                            return dayWidget;
                          },
                        ),
                        value: [DateTime.now()],
                        onDisplayedMonthChanged: (date){
                          print('selected $date');
                          bookingController.getAvailabilityDays(widget.tutors?.tutorId,startDate: date).then((value) {
                            setState(() {});
                          });
                        },
                        onValueChanged: (dates) {

                          var date = dates.firstOrNull;
                          print('selected $date');
                          selectedDate=date;
                          int? id=bookingController.getScheduleId(date);
                          bookingController.getTimeSlots(id);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(color: AppTheme.primaryColor),
                      );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Available Days:").paddingOnly(right: 10),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.secondaryColor),
                ),
                Expanded(child: SizedBox.shrink()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Not Available:").paddingOnly(right: 10),
                    Container(
                      height: 10,
                      width: 10,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("Select Available Time :",
                style:
                    AppTStyle.primaryStyle12.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: GetBuilder<BookingController>(
                builder: (BookingController controller) {
                  return ListView.builder(
                    itemCount: controller.timeSlotModel?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile<TimeSlots?>(
                        dense: true,
                        toggleable: true,
                        activeColor: AppTheme.primaryColor,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(formatTime(controller.timeSlotModel?.data?[index].startTime ?? ""),
                                style: AppTStyle.primaryStyle12),
                            SizedBox(width: 10),
                            Text('to',
                                style: AppTStyle.primaryStyle12),
                            SizedBox(width: 10),
                            Text(formatTime(controller.timeSlotModel?.data?[index].endTime ?? ""),
                                style: AppTStyle.primaryStyle12),
                          ],
                        ),
                        value: controller.timeSlotModel?.data?[index],
                        groupValue: controller.timeSlots,
                        onChanged: (TimeSlots? v) {
                          controller.timeSlots = v;
                          controller.update();
                        },
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

  Widget dotWidget(Color color) {
    return CircleAvatar(
      radius: 5,
      backgroundColor: color,
    );
  }


  String formatTime(String time) {
    final DateFormat inputFormat = DateFormat('HH:mm');
    final DateFormat outputFormat = DateFormat('h:mm a');
    final DateTime parsedTime = inputFormat.parse(time);
    return outputFormat.format(parsedTime);
  }
}
