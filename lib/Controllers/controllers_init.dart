import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/AuthenticationController/otp_verification.dart';
import 'package:darasni/Controllers/BankDetailController/bank_detail_controller.dart';
import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/Booking%20Controller/filters_controller.dart';
import 'package:darasni/Controllers/LocationController/location_controller.dart';
import 'package:darasni/Controllers/ProfileController/student_profile_controller.dart';
import 'package:darasni/Controllers/Schedule/schedule_controller.dart';
import 'package:darasni/Controllers/Subjects/subjects_controller.dart';
import 'package:darasni/Controllers/home_page_controller.dart';
import 'package:darasni/Controllers/withdrawal_controller.dart';
import 'package:darasni/main.dart';
import 'package:get/get.dart';

void putControllers() {
  Get.put(ThemeController());
  Get.put(HomeController());
  Get.put(OtpVerification());
  Get.put(LocationController());
  Get.put(AuthenticationController());
  Get.put(BookingController());
  Get.put(StudentProfileController());
  Get.put(BankDetailController());
  Get.put(ScheduleController());
  Get.put(SubjectController());
  Get.put(WithdrawalController());
  Get.put(FiltersTutorsControllers());
}

ThemeController themeController = Get.find<ThemeController>();
OtpVerification otpController = Get.find<OtpVerification>();
HomeController homeController = Get.find<HomeController>();
AuthenticationController authController = Get.find<AuthenticationController>();
BookingController bookingController = Get.find<BookingController>();
StudentProfileController profileController = Get.find<StudentProfileController>();
LocationController locationController = Get.find<LocationController>();
BankDetailController bankController = Get.find<BankDetailController>();
ScheduleController scheduleController = Get.find<ScheduleController>();
SubjectController subjectController = Get.find<SubjectController>();
WithdrawalController withdrawalController = Get.find<WithdrawalController>();
FiltersTutorsControllers filtersTutorsControllers = Get.find<FiltersTutorsControllers>();
