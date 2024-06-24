import 'package:darasni/strings_and_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  final PageController pageController = PageController();
  int pageIndex = 0;

  List<IntroModel> introList = <IntroModel>[
    IntroModel("1", ImageRes.assetsIntroImage1),
    IntroModel("2", ImageRes.assetsIntroImage2),
    IntroModel("3", ImageRes.assetsIntroImage3),
    IntroModel("4", ImageRes.assetsIntroImage4),
  ];
  List<String> introListText = [
    "Welcome to the world of Daresni!",
    "Where you can find a private \nTutor, Coach or Camp that suits YOU!",
    "Digital & Physical sessions made easy.",
    "Where we BEE-Lieve in YOU! ♥️",
  ];
}

class IntroModel {
  final String imagePath;
  final String text;
  IntroModel(this.text, this.imagePath);
}
