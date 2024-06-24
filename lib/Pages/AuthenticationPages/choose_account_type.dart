import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Pages/AuthenticationPages/OtpPages/get_phone_number.dart';
import 'package:darasni/Pages/AuthenticationPages/login_page.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:darasni/under_dev.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseAccountType extends StatelessWidget {
  ChooseAccountType({super.key});

  final AuthenticationController controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?",
                style: TextStyle(color: AppTheme.secondaryColor, fontSize: 16)),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child:
                    Text(" Log In", style: TextStyle(color: AppTheme.primaryColor, fontSize: 16))),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(ImageRes.assetsAppLogo),
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome!",
                style: TextStyle(color: AppTheme.primaryColor, fontSize: 40),
              ),
              Text("Are you a New", style: TextStyle(color: AppTheme.secondaryColor, fontSize: 18)),
              const SizedBox(height: 100),
              AppButton(
                "Student/Parent Registration",
                onTap: () {
                  controller.setUserType(UserType.student);
                  Get.to(() => const GetPhoneNumber());
                },
                buttonColor: AppTheme.primaryColor,
              ),
              const SizedBox(height: 20),
              AppButton(
                "Tutor/Couch Registration",
                onTap: () {
                  controller.setUserType(UserType.tutor);

                  logger.i(controller.userType);
                  Get.to(() => const GetPhoneNumber());
                },
                buttonColor: AppTheme.naviBlueColor,
              ),
              const SizedBox(height: 20),
              AppButton(
                "Institute/Course Registration",
                onTap: () {
                  controller.setUserType(UserType.institute);
                  Get.to(() => const UnderDev());
                },
                buttonColor: AppTheme.appGreenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
