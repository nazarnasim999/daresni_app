import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Pages/AuthenticationPages/login_page.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class RegistrationFinalPage extends StatefulWidget {
  const RegistrationFinalPage({super.key});

  @override
  State<RegistrationFinalPage> createState() => _RegistrationFinalPageState();
}

class _RegistrationFinalPageState extends State<RegistrationFinalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext, bool isKeyboardVisible) {
        if (isKeyboardVisible) {
          FocusScope.of(context).unfocus();
        }

        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: AppButton(
                    "Login Now",
                    onTap: () {
                      AuthenticationController controller = Get.find<AuthenticationController>();

                      if (controller.userType == UserType.student) {
                        // Get.to(() => StudentLandingPage());
                        Get.offAll(() => LoginPage());
                        return;
                      }
                      // Get.to(() => TutorLandingPage());
                      Get.offAll(() => LoginPage());
                    },
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(),
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(ImageRes.assetsAppLogo),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "EGG-CELLENT",
                    style: AppTStyle.primaryStyle12.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ).paddingOnly(bottom: 20),

                  Image.asset(ImageRes.eggIcon, scale: 4),
                  // Text("For Registration Daresni",
                  //     style: AppTStyle.secondaryStyle12.copyWith(fontSize: 18)),

                  // CircleAvatar(
                  //   backgroundColor: AppTheme.appGreenColor,
                  //   radius: 50,
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     radius: 47,
                  //     child: Icon(
                  //       Icons.check,
                  //       color: AppTheme.appGreenColor,
                  //       size: 40,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Text("Congratulations!", style: AppTStyle.primaryStyle12.copyWith(fontSize: 24,fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        "Now you are a part of Daresni "
                        "Your account will be verified by "
                        "our Admin Support Team.",textAlign: TextAlign.center,
                        style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Note:", style: AppTStyle.secondaryStyle12.copyWith(fontSize: 24,fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(getCongratsText(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String getCongratsText() {
    if (authController.userType == UserType.tutor) return "You can start accepting bookings!";
    return "You can now start booking your Tutor or Coach!";
  }
}
