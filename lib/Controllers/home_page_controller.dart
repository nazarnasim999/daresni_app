import 'package:get/get.dart';

class HomeController extends GetxController {
  int screenIndex = 0;

  void changePage(value) {
    screenIndex = value;
    update();
  }
}
