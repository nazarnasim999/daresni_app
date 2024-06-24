import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/AuthModels/Student/student_profile.dart';
import 'package:darasni/Models/LocationModel/area_list.dart';
import 'package:darasni/Models/LocationModel/country_list.dart';
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:darasni/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentProfileController extends GetxController {
  PageController pageController = PageController();
  int currentPage = 0;

  void changePage(int value) {
    currentPage = value;
    pageController.jumpToPage(currentPage);

    update();
  }

  StudentProfile? studentProfile;

  Future<void> getProfile() async {
    final response = await ApiService.getMethod(url: ApiUrls.GET_STUDENT_PROFILE);

    if (response == null || response.statusCode != 200) return;
    studentProfile = studentProfileFromJson(response.body);
    setStudentProfileValues();
  }

  void setStudentProfileValues() {
    authController.nameCtrl.text = studentProfile?.data?.name ?? "";
    authController.emailCtrl.text = studentProfile?.data?.email ?? "";
    authController.nationalityCtrl.text = studentProfile?.data?.nationality?.name ?? "";
    authController.genderCtrl.text = studentProfile?.data?.gender ?? "";
    authController.dobCtrl.text = studentProfile?.data?.dob?.toFormattedDate() ?? "";
    authController.phoneCodeCtrl.text = studentProfile?.data?.contact?.countryCode ?? "";
    authController.phoneNumber.text = studentProfile?.data?.contact?.contactNo ?? "";
    authController.countryToShow =
        Countries(name: studentProfile?.data?.hasAddress?.country?.name ?? "");
    authController.areasToShow = Areas(name: studentProfile?.data?.hasAddress?.area?.name ?? "");
    authController.apartmentNoCtrl.text = studentProfile?.data?.hasAddress?.buildingNo ?? "";
    authController.roadNoCtrl.text = studentProfile?.data?.hasAddress?.roadNo ?? "";
    authController.blockNoCtrl.text = studentProfile?.data?.hasAddress?.blockNo ?? "";
    authController.accountCreateAtCtrl.text =
        studentProfile?.data?.createdAt?.toFormattedDateAndTime() ?? "";
    authController.accountUpdateAtCtrl.text =
        studentProfile?.data?.updatedAt.toFormattedDateAndTime() ?? "";
  }

  void deleteAccount() async {
    final result = await ApiService.postMethod(url: ApiUrls.DELETE_ACCOUNT);
    if (result == null || result.statusCode != 200) return;

    // AppStorage.box.erase();3
    // Get.offAll(SplashPage());
  }
}
