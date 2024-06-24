import 'package:darasni/Models/subject_list.dart';
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:get/get.dart';

class SubjectController extends GetxController {
  Subjects? subjectTOShow;

  SubjectList? subjectList;

  Set<int> selectedSubjects = <int>{};

  void getSubjects() async {
    final response = await ApiService.getMethod(url: ApiUrls.GET_SUBJECTS);
    if (response == null || response.statusCode != 200 || response.body.isEmpty) {
      return;
    }
    subjectList = subjectListFromJson(response.body);

    update();
  }

  void addSingleSubjects(int value) {
    selectedSubjects.add(value);
    update();
  }

  void removeSingleSubject(int value) {
    selectedSubjects.remove(value);

    update();
  }
}
