import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/IntroController/intro_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Pages/AuthenticationPages/login_page.dart';
import 'package:darasni/Pages/IntroPage/intro_page.dart';
import 'package:darasni/Pages/StudentLandingPages/student_tab_page.dart';
import 'package:darasni/Pages/TutorLandingPages/tutor_landing_page.dart';
import 'package:darasni/Services/StorageServices/get_storage_services.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final TextStyle welcomeStyle = TextStyle(fontSize: 25, color: AppTheme.primaryColor);

  @override
  void initState() {
    Get.put(IntroController());
    checkUserStatusAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(ImageRes.assetsAppLogo),
          ),
          const SizedBox(height: 116),
          Text(
            "Welcome to Daresni",
            style: welcomeStyle,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("The", style: TextStyle(fontSize: 22, color: AppTheme.secondaryColor)),
              Text(" world’s #1",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor)),
            ],
          ),
          Text(" Tutor & Coach",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor)),
          Text(" booking platform.",
              style: TextStyle(fontSize: 22, color: AppTheme.secondaryColor)),
          const SizedBox(height: 100)
        ],
      ),
    );
  }

  void checkUserStatusAndNavigate() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (AppStorage.box.read(AppStorage.rememberMe) == true) {
          if (authController.getUser()?.user?.role == AppConst.TUTOR_ROLE) {
            authController.setUserType(UserType.tutor);
            if (AppStorage.box.read(AppStorage.intro) == true) {
              return Get.offAll(() => const TutorLandingPage());
            } else {
              return Get.offAll(() => const IntroPage());
            }
          } else {
            if (AppStorage.box.read(AppStorage.enableFinger)==true) {
              return Get.offAll(()=>LoginPage());
            }

            authController.setUserType(UserType.student);
            if (AppStorage.box.read(AppStorage.intro) == true) {
              return Get.offAll(() => const StudentLandingPage());
            } else {
              return Get.offAll(() => const IntroPage());
            }
          }
        }

        if (AppStorage.box.read(AppStorage.intro) == true)
          return Get.offAll(() => LoginPage());
        else
          return Get.offAll(() => IntroPage());
      },
    );
  }
}
