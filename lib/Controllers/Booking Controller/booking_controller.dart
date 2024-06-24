import 'dart:convert';
import 'package:darasni/Controllers/TutorDetails/single_tutor.dart';
import 'package:darasni/Models/BookingsModels/booking_days_availability.dart';
import 'package:darasni/Models/BookingsModels/booking_models.dart';
import 'package:darasni/Models/BookingsModels/get_availability.dart';
import 'package:darasni/Models/BookingsModels/get_single_booking.dart';
import 'package:darasni/Models/BookingsModels/get_time_slots.dart';
import 'package:darasni/Models/BookingsModels/single_student_booking_model.dart';
import 'package:darasni/Models/BookingsModels/student_booking_model.dart';
import 'package:darasni/Models/BookingsModels/view_carts.dart';
import 'package:darasni/Models/PaymentModels/pay_pal_respone.dart';
import 'package:darasni/Models/PaymentModels/tap_payment_response.dart';
import 'package:darasni/Models/tutor_list.dart';
import 'package:darasni/Pages/StudentLandingPages/student_tab_page.dart';
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:darasni/extensions.dart';
import 'package:get/get.dart';
import '../../Utils/utils.dart';

class BookingController extends GetxController {
  int? subjectID;
  int paymentSelection = -1;
  TimeSlots? timeSelection;
  String? paymentMethod;
  String? studentStatus;
  String? howToTeach;
  DateTime? selectedDate;

  GetBookingModel? allBookings;

  void getBookingsTutors() async {
    Future.delayed(Duration.zero, () {
      showProgress();
    });
    logger.e(ApiUrls.GET_ALL_BOOKINGS);
    final response = await ApiService.postMethod(url: "${ApiUrls.GET_ALL_BOOKINGS}");
    stopProgress();

    if (response == null || response.statusCode != 200) return;

    allBookings = getBookingModelFromJson(response.body);

    update();
  }

  StudentBookingsModels? studentBookingsModels;

  void getAllBookingsStudent() async {
    final response = await ApiService.postMethod(url: ApiUrls.GET_ALL_BOOKINGS);
    if (response == null || response.statusCode != 200) return;
    studentBookingsModels = studentBookingsModelsFromJson(response.body);
    update();
  }

  GetSingleBookingModel? singleBooking;

  void getSingleBookings(bookingID) async {
    await 0.delay();
    singleBooking = null;
    update();
    Map<String, String> body = {"booking_id": bookingID.toString()};
    Future.delayed(Duration.zero, () => showProgress());

    final response = await ApiService.postMethod(url: ApiUrls.GET_SINGLE_BOOKING, body: body);
    stopProgress();
    if (response == null || response.statusCode != 200) return;

    singleBooking = getSingleBookingModelFromJson(response.body);
    update();
  }

  TutorListModel? tutorListModel;
  int currentPag = 1;

  List<Tutors> tutorsList = <Tutors>[];
  // List<Tutors> tutorsSearchList = <Tutors>[];

  void searchTutors(String value) async {
    final response =
        await ApiService.getMethod(url: "${ApiUrls.APPLY_FILTERS}?search_by_name=${value}");
    if (response == null || response.statusCode != 200) return;
    tutorsList = [];
    update();
    tutorListModel = tutorListModelFromJson(response.body);
    if (tutorListModel?.data?.tutors == null) return;

    tutorsList.addAll(tutorListModel!.data!.tutors);
    update();
  }

  Future<void> getTutorList() async {
    tutorsList = [];
    update();
    final response = await ApiService.getMethod(url: "${ApiUrls.GET_TUTOR_LIST}?page=$currentPag");

    if (response == null || response.statusCode != 200) return;

    tutorListModel = tutorListModelFromJson(response.body);
    tutorsList.addAll(tutorListModel!.data!.tutors);
    update();
  }

  bool loadingMore = false;

  void getTutorByPagination() async {
    loadingMore = true;
    update();
    currentPag++;
    if (currentPag == tutorListModel?.data?.lastPage) return;

    final response = await ApiService.getMethod(url: "${ApiUrls.GET_TUTOR_LIST}?page=$currentPag");

    if (response == null || response.statusCode != 200) return;

    tutorListModel = tutorListModelFromJson(response.body);
    tutorListModel?.data?.tutors.forEach((element) {
      tutorsList.add(element);
    });
    loadingMore = false;

    update();
  }

  TutorModel? tutorModel;

  void getTutorDetail(int? tutorId) async {
    Map<String, String> body = {"tutor_id": tutorId?.toString() ?? ""};
    Future.delayed(Duration.zero, () {
      showProgress();
    });
    final response = await ApiService.postMethod(url: ApiUrls.GET_SINGLE_TUTOR, body: body);
    stopProgress();

    if (response == null || response.statusCode != 200) return;

    tutorModel = tutorModelFromJson(response.body);
    update();
  }

  GetAvailabilityModel? availabilityModel;

  void getAvailability(int? tutorId) async {
    final response = await ApiService.postMethod(url: ApiUrls.GET_AVAILABILITY, body: {
      "tutor_id": tutorId.toString(),
    });
    if (response == null || response.statusCode != 200) return;
    availabilityModel = getAvailabilityModelFromJson(response.body);
    await getTimeSlots(availabilityModel?.data.first.scheduleId);
    update();
  }

  List<String> daysList = <String>[];

  void addDaysToList(DateTime? start) {
    daysList = <String>[];
    final startDate = start??DateTime.now();
    int lastDay = DateTime(startDate.year, startDate.month + 1, 0).day + 1;

    for (int i = startDate.day; i < lastDay; i++) {
      daysList.add("${startDate.year}-${startDate.month}-${i}");
    }
  }

  BookingAvailableDays? bookingAvailableDays;

  Future<void> getAvailabilityDays(int? tutorId,{DateTime? startDate}) async {
    addDaysToList(startDate);
    final fields = {
      "tutor_id": tutorId.toString(),
      "dates": jsonEncode(daysList),
    };

    final response = await ApiService.postMethod(url: ApiUrls.GET_AVAILABILITY, body: fields);

    if (response == null || response.statusCode != 200) return;
    bookingAvailableDays = bookingAvailableDaysFromJson(response.body);

    update();
  }

  GetTimeSlotModel? timeSlotModel;

  Future<void> getTimeSlots(int? scheduleId) async {
    timeSlotModel = null;
    if (scheduleId == null || scheduleId == 0) {
      timeSlotModel = null;
      AppAlerts.showSnack("No Schedule Found");
      update();
      return;
    }

    final response =
        await ApiService.postMethod(url: ApiUrls.GET_TIME_SLOTS, body: {"schedule_id": scheduleId});

    if (response == null || response.statusCode != 200) return;
    timeSlotModel = getTimeSlotModelFromJson(response.body);
    update();
  }

  int? getScheduleId(DateTime? firstOrNull) {
    var date = firstOrNull.toString().split(" ")[0];
    print('newdate $date');
    selectedDate = firstOrNull;
    return bookingAvailableDays?.data.firstWhereOrNull((element) {
      // Split the date into parts
      List<String> dateParts = element.date!.split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2]);

      // Format the month with leading zero
      String formattedMonth = month.toString().padLeft(2, '0');

      // Reconstruct the formatted date
      String formattedDate = '$year-$formattedMonth-$day';

      return formattedDate == date && element.status != "Occupied";
    })?.id;
  }

  TimeSlots? timeSlots;

  Future<void> addToCart(int? tutorId) async {
    Map<String, String> body = {
      'tutor_id': '$tutorId',
      'tutor_session_type': howToTeach ?? "",
      'schedule_id': timeSlots?.scheduleId?.toString() ?? "",
      'start_time': timeSlots?.startTime ?? "",
      'end_time': timeSlots?.endTime ?? "",
      'subject_id': subjectID?.toString() ?? "",
      // 'current_date': DateTime.now().toFormattedDate()
      'current_date': selectedDate != null ? selectedDate!.toFormattedDate() : ""
    };
    showProgress();

    final response = await ApiService.postMethod(url: ApiUrls.ADD_TO_CART, body: body);
    stopProgress();

    if (response == null || response.statusCode != 200) return;

    final jd = json.decode(response.body);

    AppAlerts.showSnack(jd["message"]);
  }

  ViewCartsModel? cartsModelList;

  void viewCart() async {
    cartsModelList = null;
    final response = await ApiService.getMethod(url: ApiUrls.VIEW_CART);

    if (response == null || response.statusCode != 200) return;
    cartsModelList = viewCartsModelFromJson(response.body);
    if (cartsModelList?.data == null) AppAlerts.showSnack(cartsModelList?.message ?? "");
    update();
  }

  void setHowTOTeach(String value) {
    if (howToTeach != null) {
      howToTeach = null;
    } else {
      howToTeach = value;
    }
    update();
  }

  List<String> statusList = <String>[
    "pending",
    "start Meeting",
    "completed",
    "student Not Show",
  ];

  void changeStudentStatus(value) {
    if (studentStatus == null) {
      studentStatus = value;
    } else {
      studentStatus = null;
    }
    update();
  }

  List<String> paymentMethodList = <String>[
    "Paypal",
    "Credit/Debit Card",
  ];

  void deleteCart(int? id) async {
    final response = await ApiService.postMethod(
      url: ApiUrls.DELETE_CART,
      body: {"cart_id": id?.toString() ?? ""},
    );
    if (response == null || response.statusCode != 200) return;
    cartsModelList?.data?.removeWhere((element) => element.id == id);
    update();
  }

  PaypalResponse? paypalResponse;

  bool setPaypalResponse(Map value) {
    final str = json.encode(value);
    paypalResponse = paypalResponseFromJson(str);
    if (paypalResponse?.paymentId != null) return true;
    return false;
  }

  TapPaymentResponse? tapResponse;

  bool setTapPaymentResponse(Map value) {
    final str = json.encode(value);
    tapResponse = tapPaymentResponseFromJson(str);
    if (paypalResponse?.paymentId != null) return true;
    return false;
  }

  Future<bool> paymentForCartItem(String transactionId) async {
    Map<String, String> body = {
      'transaction_id': transactionId,
      'payment_method': '${paymentMethod}',
    };

    final response = await ApiService.postMethod(url: ApiUrls.CREATE_BOOKING, body: body);
    if (response == null || response.statusCode != 200) return false;
    final jd = json.decode(response.body);
    AppAlerts.showSnack(jd["message"]);
    if (jd["status"]) {
      viewCart();
      timeSlots = null;
      paypalResponse = null;
      tapResponse = null;

      Get.offAll(StudentLandingPage());
      return true;
    }
    return false;
  }

  SingleStudentBookingsModels? singleStudentBookingsModels;

  void viewSingleStudentBooking(int? tutorId) async {
    final response = await ApiService.postMethod(
      url: ApiUrls.GET_SINGLE_BOOKING,
      body: {"booking_id": tutorId?.toString() ?? ""},
    );
    if (response == null || response.statusCode != 200) return;
    singleStudentBookingsModels = singleStudentBookingsModelsFromJson(response.body);
    update();
  }
}

class Subjects {
  final int id;
  final String title;

  Subjects(this.id, this.title);
}
