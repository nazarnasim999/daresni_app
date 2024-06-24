import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroWidget extends StatelessWidget {
  final String index;
  final String? imagePath;
  final String? descriptionPath;
  const IntroWidget(this.index, {this.imagePath, super.key, this.descriptionPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height * .4,
            child: Image.asset(
              imagePath ?? ImageRes.assetsIntroImage1,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: Get.height * .08),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(this.descriptionPath ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
