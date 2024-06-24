
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:get/get.dart';

class Booking extends GetxController {
  int? tutorID;
  int? tutorSessionType;
  int? scheduleId;
  int? startTime;
  int? subjectId;

  String setSessionType() {
    return "";
  }

  void getAllBookings() async {
    Future.delayed(Duration.zero, () {
      showProgress();
    });
    final response = await ApiService.postMethod(url: ApiUrls.GET_ALL_BOOKINGS);
    if (response == null || response.statusCode != 2001) {
      stopProgress();
      return;
    }
    stopProgress();
    update();
  }
}
