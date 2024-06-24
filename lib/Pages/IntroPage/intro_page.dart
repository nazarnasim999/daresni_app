import 'package:darasni/Controllers/IntroController/intro_controller.dart';
import 'package:darasni/Pages/AuthenticationPages/login_page.dart';
import 'package:darasni/Services/StorageServices/get_storage_services.dart';
import 'package:darasni/Widgets/intro_widget.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<IntroController>(
          builder: (IntroController controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppStorage.box.write(AppStorage.intro, true);

                      Get.offAll(() => LoginPage());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Skip",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onHorizontalDragEnd: (a) {
                        if (controller.pageIndex == 2) {
                          Get.offAll(LoginPage());
                        }
                      },
                      child: PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.introList.length,
                        onPageChanged: (int i) {
                          controller.pageIndex = i;

                          controller.update();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(height: Get.height * .18),
                              IntroWidget(
                                controller.introList[index].text,
                                imagePath: controller.introList[index].imagePath,
                                descriptionPath: controller.introListText[index],
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        controller.introList.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: controller.pageIndex == index
                                        ? AppTheme.secondaryColor
                                        : AppTheme.greyColor,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            )),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
