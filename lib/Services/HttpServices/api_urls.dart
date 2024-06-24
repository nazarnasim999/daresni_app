// ignore_for_file: constant_identifier_names
import 'package:flutter/foundation.dart';


class ApiUrls {

  // static const String BASE_URL = "https://stage.daresni.net/";
  static const String BASE_URL = "https://daresni.net/";
  static const String PREFIX = "api/";
  static const String BASE_WITH_PREFIX = BASE_URL + PREFIX;

  /// OTP
  static const String SEND_OTP = "${BASE_WITH_PREFIX}send_otp";
  static const String VERIFY_OTP = "${BASE_WITH_PREFIX}verifyOtp";
  static const String VERIFY_EMAIL_OTP = "${BASE_WITH_PREFIX}varify_email_otp";
  static const String RE_EMAIL_OTP = "${BASE_WITH_PREFIX}send_email_otp_request";

  /// Location

  static const String GET_COUNTRY = "${BASE_WITH_PREFIX}country_list";
  static const String GET_STATE = "${BASE_WITH_PREFIX}state_list?country_id=";
  static const String GET_CITY = "${BASE_WITH_PREFIX}city_by_state/";
  static const String GET_AREA = "${BASE_WITH_PREFIX}area_list?";
  static const String GET_MULTI_STATE = "${BASE_WITH_PREFIX}get_multi_states_from_country";
  static const String GET_MULTI_CITIES_FORM_STATE =
      "${BASE_WITH_PREFIX}get_multi_cities_from_states";

  /// Tutor

  /// Registration
  static const String REGISTER_TUTOR = "${BASE_WITH_PREFIX}tutor-register";
  static const String LOGIN_USER = "${BASE_WITH_PREFIX}login";
  static const String GET_TUTOR_PROFILE = "${BASE_WITH_PREFIX}getTutorProfile";
  static const String GET_STUDENT_PROFILE = "${BASE_WITH_PREFIX}getStudentProfile";
  static const String LOGOUT_USER = "${BASE_WITH_PREFIX}logoutuser";
  static const String UPDATE_TUTOR_PROFILE = "${BASE_WITH_PREFIX}updateTutorProfile";
  static const String UPDATE_STUDENT_PROFILE = "${BASE_WITH_PREFIX}updateStudentProfile";
  static const String UPDATE_PROFILE_PICTURE = "${BASE_WITH_PREFIX}profileImageUpdate";
  static const String UPDATE_DOCUMENTS = "${BASE_WITH_PREFIX}tutor-documents";
  static const String FORGET_PASSWORD = "${BASE_WITH_PREFIX}forget-password";

  /// Account Delete
  static const String DELETE_ACCOUNT = "${BASE_WITH_PREFIX}accountDelete";

  /// Get Tutor List
  static const String GET_TUTOR_LIST = "${BASE_WITH_PREFIX}tutors";
  static const String GET_SINGLE_TUTOR = "${BASE_WITH_PREFIX}getSingleTutorDetail";
  static const String SEARCH_TUTORS = "${BASE_WITH_PREFIX}search-tutor";
  static const String TUTORS_AVAILABILITY_DAYS = "${BASE_WITH_PREFIX}tutor/availability";

  /// Add To Cart
  static const String ADD_TO_CART = "${BASE_WITH_PREFIX}add_to_cart";

  /// get languages

  static const String GET_LANGUAGES = "${BASE_WITH_PREFIX}language_list";

  /// Get Subjects
  static const String GET_SUBJECTS = "${BASE_WITH_PREFIX}subject_list";
  static const String GET_QUALIFICATION_LIST = "${BASE_WITH_PREFIX}qualification_list";

  /// Bank Details

  static const String GET_ALL_BANKS = "${BASE_WITH_PREFIX}all_bank_list";
  static const String GET_ALL_TUTOR_BANK = "${BASE_WITH_PREFIX}getAllTutorBanks";

  static const String GET_BANK_DETAILS = "${BASE_WITH_PREFIX}getallbankdetail";
  static const String SAVE_BANK_DETAIL = "${BASE_WITH_PREFIX}saveBankDetail";
  static const String REMOVE_BANK_DETAIL = "${BASE_WITH_PREFIX}removeBankDetail";
  static const String UPDATE_BANK_DETAIL = "${BASE_WITH_PREFIX}updateBankDetail";

  /// Schedule

  static const String ADD_SCHEDULE = "${BASE_WITH_PREFIX}saveTutorSchedule";
  static const String UPDATE_SCHEDULE = "${BASE_WITH_PREFIX}updateTutorSchedule";
  static const String GET_SCHEDULE = "${BASE_WITH_PREFIX}getTutorSchedule";
  static const String DELETE_SCHEDULE = "${BASE_WITH_PREFIX}removeTutorSchedule";

  /// Booking
  static const String GET_ALL_BOOKINGS = "${BASE_WITH_PREFIX}view-bookings";
  static const String GET_SINGLE_BOOKING = "${BASE_WITH_PREFIX}view-single-booking";
  static const String GET_AVAILABILITY = "${BASE_WITH_PREFIX}tutor/availability";
  static const String GET_TIME_SLOTS = "${BASE_WITH_PREFIX}tutor/get_time_slot";
  static const String VIEW_CART = "${BASE_WITH_PREFIX}view-cart";
  static const String DELETE_CART = "${BASE_WITH_PREFIX}remove_cart_item";
  static const String CREATE_BOOKING = "${BASE_WITH_PREFIX}booking";
  static const String APPLY_FILTERS = "${BASE_WITH_PREFIX}search-filters";

  /// Student APIS

  /// Register
  static const String STUDENT_REGISTRATION = "${BASE_WITH_PREFIX}student-registration";

  /// GET WALLET AND REQUEST FOR WITH DRAWAL
  static const String GET_WALLET = "${BASE_WITH_PREFIX}my-balance";
  static const String LIST_OF_WITHDRAWAL = "${BASE_WITH_PREFIX}list-of-withdraws";
  static const String REQUEST_FOR_WITHDRAWAL = "${BASE_WITH_PREFIX}request-withdraw";
}
