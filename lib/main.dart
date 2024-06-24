import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/splash_page.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  putControllers();

  runApp(
    GetBuilder(
      builder: (ThemeController controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: controller.themeData,
          home: const SplashPage(),
        );
      },
    ),
  );
}

class ThemeController extends GetxController {
  ThemeData? themeData;

  void setThemeData() {
    AuthenticationController authenticationController = Get.find<AuthenticationController>();
    if (authenticationController.userType == UserType.student) {
      themeData = ThemeData(
              fontFamily: 'Helvetica Neue',
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: const MaterialColor(0xff9F172E, {
                50: Color(0xffFDE2E5),
                100: Color(0xffF8B5BD),
                200: Color(0xffF08692),
                300: Color(0xffEB5970),
                400: Color(0xffE52F55),
                500: Color(0xffDC042B),
                600: Color(0xffD90229),
                700: Color(0xffCF0026),
                800: Color(0xffC60123),
                900: Color(0xffBB001E),
              }),
              appBarTheme: AppBarTheme(
                  centerTitle: false,
                  backgroundColor: ThemeData.light().scaffoldBackgroundColor,
                  elevation: 0,
                  iconTheme: IconThemeData(color: AppTheme.secondaryColor)))
          .copyWith(

              // textTheme: GoogleFonts.fredokaTextTheme(),
              );
      return;
    }
    themeData = ThemeData(
            fontFamily: 'Helvetica Neue',
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: const MaterialColor(0xff102C4C, {
              50: Color(0xffFDE2E5),
              100: Color(0xffF8B5BD),
              200: Color(0xffF08692),
              300: Color(0xffEB5970),
              400: Color(0xffE52F55),
              500: Color(0xffDC042B),
              600: Color(0xffD90229),
              700: Color(0xffCF0026),
              800: Color(0xffC60123),
              900: Color(0xffBB001E),
            }),
            appBarTheme: AppBarTheme(
                centerTitle: false,
                backgroundColor: ThemeData.light().scaffoldBackgroundColor,
                elevation: 0,
                iconTheme: IconThemeData(color: AppTheme.secondaryColor)))
        .copyWith(
            // textTheme: GoogleFonts.fredokaTextTheme(),
            );
    Future.delayed(Duration.zero, () => update());
  }
}
