import 'package:intl/intl.dart';

import '/Models/BookingsModels/view_carts.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';

class OrderReviewCard extends StatelessWidget {
  final Carts? carts;
  final VoidCallback? onDelete;
  const OrderReviewCard(this.carts, {this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          // bookingController.selectCartForPayment(carts);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color:  AppTheme.orangeColor),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        carts?.tutorName??"",
                        style: AppTStyle.secondaryStyle12.copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      setSessionType(carts?.sessionType ?? ""),
                      style: AppTStyle.primaryStyle12,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: AppTheme.primaryColor,
                      size: 15,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      formatDate(carts?.bookingDate ?? ""),
                      style: AppTStyle.primaryStyle12,
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppTheme.primaryColor,
                      size: 15,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${formatTime(carts?.startTime ?? "")} - ${formatTime(carts?.endTime ?? "")}",
                      style: AppTStyle.primaryStyle12,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Hourly Price: ",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14),
                    ),
                    Text(
                      "BHD. ${carts?.pricing ?? ""}",
                      style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Net Amount: ",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14),
                    ),
                    Text(
                      carts?.pricing ?? "",
                      style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                    ),

                  ],
                ),


                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Selected Subject: ",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14),
                    ),
                    Text(
                      carts?.subject?.name?.en ?? "",
                      style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    GestureDetector(
                        onTap: onDelete,
                        child: Icon(
                          Icons.delete,
                          color: AppTheme.secondaryColor,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  String formatDate(String date) {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateFormat outputFormat = DateFormat('EEEE, dd-MMM-yyyy');
    final DateTime parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  String setSessionType(String sessionType) {
    if (sessionType == "os")
      return "Online Session";
    else if (sessionType == "ps")
      return "Physical Session";

    else if (sessionType == "ph")
      return "Physical Session";
    else
      return "Both (Online Session / Physical Session)";
  }


  String formatTime(String time) {
    final DateFormat inputFormat = DateFormat('HH:mm');
    final DateFormat outputFormat = DateFormat('h:mm a');
    final DateTime parsedTime = inputFormat.parse(time);
    return outputFormat.format(parsedTime);
  }
}
