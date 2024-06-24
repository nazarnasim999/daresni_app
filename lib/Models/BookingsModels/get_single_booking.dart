import 'dart:convert';

import 'package:darasni/Models/BookingsModels/booking_models.dart';

GetSingleBookingModel getSingleBookingModelFromJson(String str) =>
    GetSingleBookingModel.fromJson(json.decode(str));

class GetSingleBookingModel {
  int? code;
  bool? status;
  BookingData? bookingData;

  GetSingleBookingModel({
    this.code,
    this.status,
    this.bookingData,
  });

  factory GetSingleBookingModel.fromJson(Map<String, dynamic> json) => GetSingleBookingModel(
        code: json["code"],
        status: json["status"],
        bookingData: BookingData.fromJson(json["data"]),
      );
}
