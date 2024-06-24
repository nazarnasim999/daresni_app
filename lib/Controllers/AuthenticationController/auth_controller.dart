import 'dart:convert';
import '/Controllers/controllers_init.dart';
import '/Models/AuthModels/Student/sign_up_response.dart';
import '/Models/AuthModels/Student/student_login_model.dart';
import '/Models/AuthModels/get_tutor_profile.dart' as tutorProfile;
import '/Models/AuthModels/login_model.dart' as login hide Country, Expertise;
import '/Models/LocationModel/area_list.dart';
import '/Models/LocationModel/country_list.dart';
import '/Models/LocationModel/state_list.dart';
import '/Models/Qualifications/qualifications_list.dart';
import '/Models/languages_list.dart';
import '/Pages/AuthenticationPages/registration_final_page.dart';
import '/Pages/AuthenticationPages/work_detail_page.dart';
import '/Pages/StudentLandingPages/student_tab_page.dart';
import '/Pages/TutorLandingPages/tutor_landing_page.dart';
import '/Services/HttpServices/api_services.dart';
import '/Services/HttpServices/api_urls.dart';
import '/Services/StorageServices/get_storage_services.dart';
import '/Utils/get_image.dart';
import '/Utils/utils.dart';
import '/extensions.dart';
import '/strings_and_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '/Models/subject_list.dart';

enum UserType { student, tutor, institute }

class AuthenticationController extends GetxController {
  UserType userType = UserType.student;

  bool isTutor() {
    if (userType == UserType.tutor) return true;
    return false;
  }

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController(text: AppStorage.box.read(AppStorage.saveLoginId) ?? "");
  final phoneCodeCtrl = TextEditingController();
  final phoneNumber = TextEditingController();
  final nationalityCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final passwordCtrl =
      TextEditingController(text: AppStorage.box.read(AppStorage.saveLoginPassword) ?? "");
  final reEnterCtrl = TextEditingController();
  final apartmentNoCtrl = TextEditingController();
  final buildingNoCtrl = TextEditingController();
  final roadNoCtrl = TextEditingController();
  final blockNoCtrl = TextEditingController();
  final nationalIDCtrl = TextEditingController();
  final workExperienceCtrl = TextEditingController();
  final mainLanguageCtrl = TextEditingController();
  final qualificationCtrl = TextEditingController();
  final pricingCtrl = TextEditingController();
  final bioCtrl = TextEditingController();
  final tutorDescriptionCtrl = TextEditingController();
  final areaCtrl = TextEditingController();
  final accountCreateAtCtrl = TextEditingController();
  final accountUpdateAtCtrl = TextEditingController();
  final expertiseCtrl = TextEditingController();
  final teachingLanguagesCtrl = TextEditingController();
  final offerServicesCtrl = TextEditingController();

  int? languageID;
  List<Languages> languagesCanTeach = <Languages>[];
  int? nationalityID;
  int? countryID;
  int? stateID;
  int? cityID;
  int? areaID;
  int? expertiseID;
  String? typeOfService;
  TeachingsWay? howToTeach;
  int? qualificationId;
  Countries? countryToShow;
  States? statesToShow;
  Areas? areasToShow;
  Languages? languageTOShow;
  Subjects? expertiseTOShow;

  bool rememberMe = true;
  bool enableFingerPrint = false;
  bool isAgree = false;

  GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  GlobalKey<FormState> addressValidationKey = GlobalKey<FormState>();

  void setNationalityID(int? value) {
    nationalityID = value;
    update();
  }

  void setCountryID(int? value) {
    countryID = value;
    update();

    if (isTutor())
      locationController.getStateList();
    else
      locationController.getAreaList(countryID: countryID, stateId: stateID);
  }

  void setStateID(int? id) {
    stateID = id;
    update();
    locationController.getAreaList(countryID: countryID, stateId: stateID);
  }

  void setCityID(int? id) {
    cityID = id;
    update();
    locationController.getAreaList(countryID: countryID, stateId: stateID);
  }

  void setAreaID(int? id) {
    areaID = id;
    update();
    locationController.getCityList();
  }

  void rememberMeFun() {
    rememberMe = !rememberMe;

    update();
  }

  void enableFingerPrintFun() {
    enableFingerPrint = !enableFingerPrint;

    if (enableFingerPrint) {
      getFingerPrint();
    }
    update();
  }

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> getFingerPrint() async {
    /// validate email and password
    if (emailCtrl.text.isEmpty) {
      emailCtrl.text = await AppStorage.box.read(AppStorage.saveLoginId) ?? "";
      passwordCtrl.text = await AppStorage.box.read(AppStorage.saveLoginPassword) ?? "";
    }
    if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) return;

    final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (!availableBiometrics.isNotEmpty) {
      AppAlerts.showSnack("Authentication Not Available", error: true);
      return;    }
    Get.back();

      try {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to login',
            options: const AuthenticationOptions(
              stickyAuth: true,
              sensitiveTransaction: true,
              useErrorDialogs: true,
            ));
        if (didAuthenticate) {
          await AppStorage.box.write(AppStorage.saveLoginId, emailCtrl.text);
          await AppStorage.box.write(AppStorage.saveLoginPassword, passwordCtrl.text);

          await loginUser().then((value) {
            if (value) {
              if (value) {
                if (authController.getUser()?.user?.role == AppConst.STUDENT_ROLE) {
                  return Get.offAll(StudentLandingPage());
                }
                else if (authController.getUser()?.user?.role == AppConst.TUTOR_ROLE) {
                  return Get.offAll(TutorLandingPage());
                } else if (authController.getUser()?.user?.role == AppConst.INSTITUTE_ROLE) {
                  return Get.offAll(TutorLandingPage());
                }
              }
            }
          });
        }
      } on Exception catch (e) {
        logger.e(e);
      }
  }

  void setUserType(UserType userType) {
    this.userType = userType;
    themeController.setThemeData();
    Future.delayed(Duration.zero, () {
      update();
    });
  }

  Future<void> getDob() async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      dobCtrl.text = "${date.year}-${date.month}-${date.day}";
    }
    update();
  }

  String? imageUrl;

  Future<void> getImage() async {
    imageUrl = await GetImage.getImage();
    logger.i(imageUrl);
    update();
  }

  String? certificatesImage;

  void getCertificates() async {
    certificatesImage = await GetImage.getImage();
    logger.i(certificatesImage);
    update();
  }

  String? cPRDocumentImage;

  void getCPRDocument() async {
    cPRDocumentImage = await GetImage.getImage();
    logger.i(cPRDocumentImage);
    update();
  }

  String? passportImage;

  void getPassport() async {
    passportImage = await GetImage.getImage();
    logger.i(passportImage);
    update();
  }

  LanguagesList? languagesList;

  Future<void> getLanguages() async {
    final response = await ApiService.getMethod(url: ApiUrls.GET_LANGUAGES);
    if (response == null || response.statusCode != 200 || response.body.isEmpty) {
      return;
    }
    languagesList = languagesListFromJson(response.body);
    subjectController.getSubjects();
    update();
  }

  List<int> setTeachingLanguages() {
    List<int> list = <int>[];
    for (var element in languagesCanTeach) {
      list.add(element.id!);
    }

    return list;
  }

  bool agreeTAndC = false;
  bool agreeProfilePrivacy = false;

  List<ServicesType> servicesTypeList = <ServicesType>[
    ServicesType("Every One(Children and Adult Maile & Female ) / Private Session"),
    ServicesType("Children Only"),
    ServicesType("Adult Male Only"),
    ServicesType("Adult Female and Children Only"),
  ];

  /// Tutor
  void registerTutor() async {
    showProgress();
    Map<String, String> fields = {
      'name': nameCtrl.text,
      'email': emailCtrl.text,
      'password': passwordCtrl.text,
      'password_confirmation': reEnterCtrl.text,
      'nationality': nationalityID.toString(),
      'gender': genderCtrl.text,
      'dob': dobCtrl.text,
      'phonecode': otpController.codeCtrl.text,
      'phone': otpController.numberCtrl.text,
      'country_id': countryID.toString(),
      'area': areaID.toString(),
      'flat_no': apartmentNoCtrl.text,
      'building_no': buildingNoCtrl.text,
      'road_no': roadNoCtrl.text,
      'block_no': blockNoCtrl.text,
      'cpr_number': nationalIDCtrl.text,
      'work_experience': workExperienceCtrl.text,
      'language_id': languageID.toString(),
      'expertise': expertiseID.toString(),
      'qualification': qualificationCtrl.text,
      'languages_tutor_can_teach': setTeachingLanguages().toString(),
      'subjects_tutor_can_teach': '${subjectController.selectedSubjects.toList()}',
      'which_country_offer_services': '${locationController.multiCountriesId}',
      'which_state_offer_services': '${locationController.multiCitesID}',
      'which_city_offer_services': '${locationController.multiCitesID}',
      'country_name': "[${countryID.toString()}]",
      'pricing': pricingCtrl.text,
      'how_to_teach': howToTeach?.value ?? "",
      'Offer_services': typeOfService ?? "",
      'bio': bioCtrl.text,
      'tutor_description': bioCtrl.text,
      // 'state': "[]",
      // 'city_name': "[]"
    };
    Map<String, String> files = {};
    files.addIf(imageUrl != null, "profile_picture", imageUrl ?? "");
    files.addIf(certificatesImage != null, "certification", certificatesImage ?? "");
    files.addIf(passportImage != null, "passport_pic", passportImage ?? "");
    files.addIf(cPRDocumentImage != null, "cpr", cPRDocumentImage ?? "");

    final result = await ApiService.postMultiPartQuery(
      ApiUrls.REGISTER_TUTOR,
      fields: fields,
      files: files,
    );
    stopProgress();
    // bool status = json.decode(result!)["status"];
    List<dynamic> error =
        json.decode(result!)["errors"] != null ? json.decode(result)["errors"] : [];

    if (error.isNotEmpty) {
      AppAlerts.showSnack(error.toString().replaceAll("[", "").replaceAll("]", ""));
    }

    if (error.isEmpty) {
      Get.offAll(RegistrationFinalPage());
    }
  }

  StudentRegistration? studentRegistration;

  Future<void> registerStudent() async {
    showProgress();
    Map<String, String> fields = {
      'name': nameCtrl.text,
      'email': emailCtrl.text,
      'phone_code': otpController.codeCtrl.text,
      'contact_no': otpController.numberCtrl.text,
      'nationality': countryID?.toString() ?? "",
      'gender': genderCtrl.text,
      'dob': dobCtrl.text,
      'password': passwordCtrl.text,
      'password_confirmation': reEnterCtrl.text,
      'country_id': countryID?.toString() ?? "",
      'area': areaID?.toString() ?? "",
      'flat_no': apartmentNoCtrl.text,
      'building_no': buildingNoCtrl.text,
      'road_no': roadNoCtrl.text,
      'block_no': blockNoCtrl.text
    };
    Map<String, String> files = {};
    files.addIf(imageUrl != null, "profile_picture", imageUrl ?? "");
    final result = await ApiService.postMultiPartQuery(
      ApiUrls.STUDENT_REGISTRATION,
      fields: fields,
      files: files,
    );
    stopProgress();
    if (result == null) return;

    studentRegistration = studentRegistrationFromJson(result);
    if (studentRegistration?.status == false) {
      AppAlerts.showSnack(
          "${studentRegistration?.message ?? "Something Went Wrong"} ${studentRegistration?.errors.toString().replaceAll("]", "").replaceAll("[", "")}",
          error: true);
      return;
    }
    AppAlerts.showSnack(
        studentRegistration?.message.toString().replaceAll("[]", "") ?? "Something Went Wrong",
        error: false);

    Get.offAll(RegistrationFinalPage());
  }

  getStudentProfile() async {
    final response = await ApiService.getMethod(url: ApiUrls.GET_STUDENT_PROFILE);

    if (response == null || response.statusCode != 200) return;

    await AppStorage.box.write(AppStorage.getUser, response.body);
  }

  login.LoginModel? loginModel;
  StudentLoginResponse? studentLoginResponse;

  Future<bool> loginUser() async {
    print('object');
    Map<String, String> body = {"email": emailCtrl.text, "password": passwordCtrl.text};
    showProgress();
    final result = await ApiService.postMethod(url: ApiUrls.LOGIN_USER, body: body);
    stopProgress();
    if (result?.statusCode != 200 || result == null) return false;

    final jd = json.decode(result.body);
    if (!jd["status"]) {
      AppAlerts.showSnack(jd["message"]);
      return false;
    }
    AppAlerts.showSnack(jd["message"]);

    await AppStorage.box.write(AppStorage.getUser, result.body);
    if (rememberMe) {
      await AppStorage.box.write(AppStorage.rememberMe, true);
      await AppStorage.box.write(AppStorage.saveLoginId, emailCtrl.text);
      await AppStorage.box.write(AppStorage.saveLoginPassword, passwordCtrl.text);

      if (enableFingerPrint) {
        await AppStorage.box.write(AppStorage.enableFinger, true);
      }
    }
    return true;
  }

  login.LoginModel? getUser() {
    if (AppStorage.box.hasData(AppStorage.getUser)) {
      final String data = AppStorage.box.read(AppStorage.getUser);
      return login.loginModelFromJson(data);
    }
    return null;
  }

  Future<bool> logOut() async {
    showProgress();
    final response = await ApiService.postMethod(
        url: ApiUrls.LOGOUT_USER, body: {"user_id": getUser()?.user?.id ?? 0});
    stopProgress();
    // if (response != null && response.statusCode == 200) {
    // await AppStorage.box.erase();
    await AppStorage.box.remove(AppStorage.getUser);
    await AppStorage.box.remove(AppStorage.rememberMe);

    return true;
    // }
    // return false;
  }

  tutorProfile.GetProfileModel? tutorProfileModel;

  void getTutorProfile() async {
    final response = await ApiService.getMethod(url: ApiUrls.GET_TUTOR_PROFILE);

    if (response == null || response.statusCode != 200) return;
    tutorProfileModel = tutorProfile.getProfileModelFromJson(response.body);

    accountCreateAtCtrl.text =
        authController.getUser()?.user?.createAt?.toFormattedDateAndTime() ?? "";
    accountUpdateAtCtrl.text =
        authController.getUser()?.user?.updateAt?.toFormattedDateAndTime() ?? "";
    offerServicesCtrl.text = tutorProfileModel?.profileData?.offerServices ?? "";
    nameCtrl.text = tutorProfileModel?.profileData?.name ?? "";
    emailCtrl.text = tutorProfileModel?.profileData?.email ?? "";
    nationalityCtrl.text = tutorProfileModel?.profileData?.nationality?.name ?? "";
    genderCtrl.text = tutorProfileModel?.profileData?.gender ?? "";
    dobCtrl.text = tutorProfileModel?.profileData?.dob?.toFormattedDate() ?? "";
    nationalityID = tutorProfileModel?.profileData?.nationality?.id;
    tutorDescriptionCtrl.text = tutorProfileModel?.profileData?.description ?? "";
    apartmentNoCtrl.text = tutorProfileModel?.profileData?.hasAddress?.buildingNo ?? "";
    buildingNoCtrl.text = tutorProfileModel?.profileData?.hasAddress?.buildingNo ?? "";
    roadNoCtrl.text = tutorProfileModel?.profileData?.hasAddress?.roadNo ?? "";
    blockNoCtrl.text = tutorProfileModel?.profileData?.hasAddress?.blockNo ?? "";
    nationalIDCtrl.text = tutorProfileModel?.profileData?.nationalId ?? "";
    workExperienceCtrl.text = tutorProfileModel?.profileData?.workExperience ?? "";
    mainLanguageCtrl.text = tutorProfileModel?.profileData?.primaryLanguage?.id?.toString() ?? "";
    qualificationCtrl.text = tutorProfileModel?.profileData?.expertise?.name?.en ?? "";
    pricingCtrl.text = tutorProfileModel?.profileData?.pricing?.toString() ?? "";
    bioCtrl.text = tutorProfileModel?.profileData?.bio ?? "";
    tutorDescriptionCtrl.text = tutorProfileModel?.profileData?.description ?? "";

    howToTeach = TeachingsWay(
        tutorProfileModel?.profileData?.howToTeach ?? "",
        tutorProfileModel?.profileData?.howToTeach?.toLowerCase() == "physical session"
            ? "ps"
            : "os");

    typeOfService = tutorProfileModel?.profileData?.offerServices;
    expertiseCtrl.text = tutorProfileModel?.profileData?.expertise?.name?.en ?? "";
    phoneCodeCtrl.text = tutorProfileModel?.profileData?.contact?.countryCode ?? "";
    phoneNumber.text = tutorProfileModel?.profileData?.contact?.contactNo ?? "";
    countryToShow = Countries(name: authController.nationalityCtrl.text);
    statesToShow =
        States(name: authController.tutorProfileModel?.profileData?.hasAddress?.area?.name ?? "");
    areasToShow =
        Areas(name: authController.tutorProfileModel?.profileData?.hasAddress?.area?.name ?? "");

    languageTOShow = Languages(
        nameInEnglish:
            authController.tutorProfileModel?.profileData?.primaryLanguage?.name?.en ?? "");
    expertiseTOShow = Subjects(
        nameInEnglish: authController.tutorProfileModel?.profileData?.expertise?.name?.en ?? "");

    /// Set Id
    countryID = tutorProfileModel?.profileData?.hasAddress?.country?.id;
    stateID = tutorProfileModel?.profileData?.hasAddress?.area?.stateId;
    areaID = tutorProfileModel?.profileData?.hasAddress?.area?.id;
    expertiseID = tutorProfileModel?.profileData?.expertise?.id;

    await locationController.getCountryList();
    await locationController.getStateList();
    await locationController.getAreaList(countryID: countryID, stateId: stateID);
    await authController.getLanguages();

    update();
  }

  void updateProfilePic() async {
    String? path = await GetImage.getImage();
    if (path == null) return;
    showProgress();
    final response =
        await ApiService.postMultiPartQuery(ApiUrls.UPDATE_PROFILE_PICTURE, files: {"image": path});
    stopProgress();
    if (response == null) return;

    if (userType == UserType.tutor) {
      getTutorProfile();
    } else
      getStudentProfile();
  }

  Future<bool> forgetPassword() async {
    showProgress();
    Map<String, String> body = {"email": emailCtrl.text};

    final response = await ApiService.postMethod(url: ApiUrls.FORGET_PASSWORD, body: body);
    stopProgress();
    if (response == null || response.statusCode != 200) return false;

    final jd = json.decode(response.body);

    AppAlerts.showSnack(jd["message"] ?? "Email Sent");
    emailCtrl.clear();
    return true;
  }

  void updateTutorProfile() async {
    showProgress();
    Map<String, dynamic> body = {
      'name': nameCtrl.text,
      'email': emailCtrl.text,
      'nationality': nationalityID?.toString() ?? "",
      'gender': genderCtrl.text,
      'dob': dobCtrl.text,
      'phone_code': phoneCodeCtrl.text,
      'contact_no': phoneNumber.text,
      'national_id': nationalIDCtrl.text,
      'flat_no': apartmentNoCtrl.text,
      'block_no': blockNoCtrl.text,
      'road_no': roadNoCtrl.text,
      'qualification': qualificationCtrl.text,
      'how_to_teach': howToTeach?.value ?? "",
      'Offer_services': typeOfService ?? "",
      'work_experience': workExperienceCtrl.text,
      'language': mainLanguageCtrl.text,
      'area': areaID?.toString() ?? "",
      'pricing': pricingCtrl.text,
      'expertise': expertiseID?.toString() ?? "",
      'bio': bioCtrl.text,
      'subject_tutor_can_teach': subjectController.selectedSubjects.toList()
    };
    logger.i(body);
    final response = await ApiService.postMethod(url: ApiUrls.UPDATE_TUTOR_PROFILE, body: body);
    stopProgress();
    if (response == null || response.statusCode != 200) return;

    String? mess = jsonDecode(response.body)["error"] ?? jsonDecode(response.body)["message"];

    AppAlerts.showSnack(mess ?? "Something Went Wrong");
  }

  void updateStudentProfile() async {
    showProgress();
    Map<String, String> body = {
      'name': nameCtrl.text,
      'email': emailCtrl.text,
      'nationality': nationalityID?.toString() ?? "",
      'gender': genderCtrl.text,
      'dob': dobCtrl.text,
      'phone_code': phoneCodeCtrl.text,
      'contact_no': phoneNumber.text,
      'national_id': nationalIDCtrl.text,
      'flat_no': apartmentNoCtrl.text,
      'block_no': blockNoCtrl.text,
      'road_no': roadNoCtrl.text,
      'qualification': qualificationCtrl.text,
      'how_to_teach': howToTeach?.title ?? "",
      'Offer_services': typeOfService ?? "",
      'work_experience': workExperienceCtrl.text,
      'language': mainLanguageCtrl.text,
      'area': areaID?.toString() ?? "",
      'pricing': pricingCtrl.text,
      'expertise': expertiseID?.toString() ?? "",
    };
    final response = await ApiService.postMethod(url: ApiUrls.UPDATE_STUDENT_PROFILE, body: body);
    stopProgress();
    if (response == null || response.statusCode != 200) return;

    String mess = jsonDecode(response.body)["error"] ?? jsonDecode(response.body)["message"];

    AppAlerts.showSnack(mess);
  }

  void updateDocuments() async {
    if (cPRDocumentImage == null || certificatesImage == null || passportImage == null) {
      AppAlerts.showSnack("Please Select Files", error: true);

      return;
    }
    showProgress();

    Map<String, String> files = {};

    if (certificatesImage != null) {
      files.addIf(true, "certification", certificatesImage!);
    }
    if (cPRDocumentImage != null) {
      files.addIf(true, "cpr", cPRDocumentImage!);
    }
    if (passportImage != null) {
      files.addIf(true, "passport_pic", passportImage!);
    }

    final response = await ApiService.postMultiPartQuery(ApiUrls.UPDATE_DOCUMENTS, files: files);
    if (response == null) return;
    stopProgress();

    stopProgress();
    AppAlerts.showSnack(json.decode(response)["message"]);

    cPRDocumentImage = null;
    passportImage = null;
    certificatesImage = null;
    getTutorProfile();
  }

  QualificationList? qualificationList;

  void getQualificationList() async {
    final response = await ApiService.getMethod(url: ApiUrls.GET_QUALIFICATION_LIST);
    if (response == null || response.statusCode != 200) return;
    qualificationList = qualificationListFromJson(response.body);
    logger.e(response.body);
    update();
  }

  void setPrimaryLanguage(id) {
    this.languageID = id;
    update();
  }

  void setExpertiesID(int? id) {
    expertiseID = id;
    update();
  }
}
