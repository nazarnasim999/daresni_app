import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/tutor_list.dart';
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:get/get.dart';

class FiltersTutorsControllers extends GetxController {
  /// TODO: SEARCH BY NAME
  int currentPag = 1;
  bool loadingMore = false;
  TutorListModel? tutorListModel;
  // List<Tutors> tutorsList = <Tutors>[];
  String? name;

  int? countryId;
  int? stateId;
  int? areaId;

  int? subjectId;
  int? languageId;

  String? sessionType;
  String? certificateType;
  String? gender;

  Future<void> applySortingFilters(String value) async {
    bookingController.tutorsList = [];
    update();
    showProgress();
    final response = await ApiService.getMethod(url: "${ApiUrls.APPLY_FILTERS}?sorting=$value&page=$currentPag");
    stopProgress();
    if (response == null || response.statusCode != 200) {
      return;
    }

    bookingController. tutorsList.addAll(tutorListModelFromJson(response.body).data!.tutors);

    update();
  }

  void getTutorByPagination(String value) async {
    loadingMore = true;
    update();
    currentPag++;
    if (currentPag == tutorListModel?.data?.lastPage) return;

    final response = await ApiService.getMethod(
        url: "${ApiUrls.GET_TUTOR_LIST}?sorting=$value&page=$currentPag");

    if (response == null || response.statusCode != 200) return;

    tutorListModel = tutorListModelFromJson(response.body);
    tutorListModel?.data?.tutors.forEach((element) {
      bookingController. tutorsList.add(element);
    });
    loadingMore = false;

    update();
  }
  void resetFilters() {
    currentPag=1;
    countryId=null;
    stateId = null;
    areaId = null;
    subjectId = null;
    languageId= null;
    sessionType =null;
    certificateType=null;
    gender=null;
  }

  Future<void> getFilterTutor() async {
    bookingController.tutorsList = [];
    showProgress();
    List<String> params = [];
    params.add("page=$currentPag");
    if (name != null) params.add("search_by_name=$name");
    if (countryId != null) params.add("country=$countryId");
    if (stateId != null) params.add("state=$stateId");
    if (areaId != null) params.add("city=$areaId");
    if (subjectId != null) params.add("subject=$subjectId");
    if (languageId != null) params.add("language=$languageId");
    if (sessionType != null) params.add("session=$sessionType");
    if (certificateType != null) params.add("certificate=$certificateType");
    if (gender != null) params.add("gender=$gender");
    logger.e(params.join("&"));

    final response = await ApiService.getMethod(url: "${ApiUrls.APPLY_FILTERS}?${params.join("&")}");
    stopProgress();

    if (response == null || response.statusCode != 200) return;
    logger.e(response.body);
    bookingController.tutorsList.addAll(tutorListModelFromJson(response.body).data?.tutors??[]);
    update();
  }

  void getFilterTutorByPagination() async {
    loadingMore = true;
    update();
    currentPag++;
    if (currentPag == tutorListModel?.data?.lastPage) return;
    List<String> params = [];
    params.add("?page=$currentPag");
    if (name != null) params.add("?search_by_name=$countryId");
    if (countryId != null) params.add("?country=$countryId");
    if (stateId != null) params.add("state=$stateId");
    if (areaId != null) params.add("city=$areaId");
    if (subjectId != null) params.add("subject=$subjectId");
    if (languageId != null) params.add("language=$languageId");
    if (sessionType != null) params.add("session=$sessionType");
    if (certificateType != null) params.add("certificate=$certificateType");
    if (gender != null) params.add("gender=$gender");
    final response = await ApiService.getMethod(url: "${ApiUrls.APPLY_FILTERS}${params.join("&")}");

    if (response == null || response.statusCode != 200) return;

    tutorListModel = tutorListModelFromJson(response.body);
    tutorListModel?.data?.tutors.forEach((element) {
      bookingController.tutorsList.add(element);
    });
    loadingMore = false;

    update();
  }

}
