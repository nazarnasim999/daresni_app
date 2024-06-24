import 'dart:io';
import 'package:app_review/app_review.dart';
import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Controllers/home_page_controller.dart';
import 'package:darasni/Pages/TutorLandingPages/add_schedule_page.dart';
import 'package:darasni/Pages/TutorLandingPages/bank_detail.dart';
import 'package:darasni/Pages/TutorLandingPages/tutor_home_page.dart';
import 'package:darasni/Pages/TutorLandingPages/withdrawal_request_page.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/splash_page.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../privacy_web_view.dart';
import 'tutor_booking.dart';
import 'tutor_profile.dart';

class TutorLandingPage extends StatefulWidget {
  const TutorLandingPage({super.key});

  @override
  State<TutorLandingPage> createState() => _TutorLandingPageState();
}

class _TutorLandingPageState extends State<TutorLandingPage> {
  final List<Widget> pagesList = <Widget>[
    TutorHomePage(),
    TutorBookingPage(),
    const TutorBankDetailPage(),
    const TutorProfilePage(),
  ];

  String buildAppbarTitle() {
    if (homeController.screenIndex == 0) {
      return "DARESNI";
    } else if (homeController.screenIndex == 1) {
      return "Bookings";
    } else if (homeController.screenIndex == 2) {
      return "Bank Detail";
    } else {
      return "Profile";
    }
  }

  @override
  void initState() {
    super.initState();
    if (authController.getUser()?.user?.role == AppConst.TUTOR_ROLE) {
      authController.setUserType(UserType.tutor);
    } else if (authController.getUser()?.user?.role == AppConst.STUDENT_ROLE) {
      authController.setUserType(UserType.student);
    } else if (authController.getUser()?.user?.role ==
        AppConst.INSTITUTE_ROLE) {
      authController.setUserType(UserType.institute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) {
        return Scaffold(
          body: pagesList.elementAt(controller.screenIndex),
          drawerEnableOpenDragGesture: false,
          // Prevent user sliding open
          appBar: AppBar(
            title: Text(
              buildAppbarTitle(),
              style: AppTStyle.primaryStyle12
                  .copyWith(color: Colors.white, fontSize: 16),
            ),
            leading: Builder(builder: (context) {
              return GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Icon(Icons.menu)
                  // Image.asset(ImageRes.assetsSideMenu),
                  );
            }),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: TextButton(
                    onPressed: () async {
                      await authController.logOut().then((value) {
                        if (value) {
                          return Get.offAll(const SplashPage());
                        }
                        return null;
                      });
                    },
                    child: Text(
                      "Log out",
                      style: AppTStyle.primaryStyle12
                          .copyWith(fontSize: 14, color: Colors.white),
                    )),
              ),
            ],
            backgroundColor: AppTheme.secondaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  height: Get.height * .25,
                  color: authController.userType == UserType.student
                      ? AppTheme.primaryColor
                      : AppTheme.secondaryColor,
                  child: Center(
                    child: Image.asset(
                      ImageRes.assetsLogoWhite,
                      height: Get.height * .12,
                      width: Get.height * .12,
                    ),
                  ),
                ),
                if (authController.userType == UserType.tutor)
                  ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.bookmark,
                      color: authController.userType == UserType.student
                          ? AppTheme.primaryColor
                          : AppTheme.secondaryColor,
                    ),
                    title: Text(
                      "My Bookings",
                      style: AppTStyle.regularStyle12.copyWith(fontSize: 18),
                    ),
                    onTap: () {
                      controller.changePage(1);

                      Get.back();
                    },
                  ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.draw_rounded,
                    color: authController.userType == UserType.student
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryColor,
                  ),
                  title: Text(
                    "Request Withdrawal",
                    style: AppTStyle.regularStyle12.copyWith(fontSize: 18),
                  ),
                  onTap: () {
                    Get.back();
                    Get.to(() => RequestWithdrawal());
                  },
                ),
                if (authController.userType == UserType.tutor)
                  ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.schedule,
                      color: authController.userType == UserType.student
                          ? AppTheme.primaryColor
                          : AppTheme.secondaryColor,
                    ),
                    title: Text(
                      "Add Schedule",
                      style: AppTStyle.regularStyle12.copyWith(fontSize: 18),
                    ),
                    onTap: () {
                      Get.to(() => AddSchedulePage());
                    },
                  ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.star_half_outlined,
                    color: authController.userType == UserType.student
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryColor,
                  ),
                  title: Text(
                    "Rate Us",
                    style: AppTStyle.regularStyle12.copyWith(fontSize: 18),
                  ),
                  onTap: () async {
                    if (Platform.isAndroid) {
                      bool available = await AppReview.isRequestReviewAvailable;
                      if (available)
                        await AppReview.openGooglePlay(
                            fallbackUrl: "com.daresni.tutor.student.net");
                    } else if (Platform.isIOS) {
                      bool available = await AppReview.isRequestReviewAvailable;
                      if (available)
                        await AppReview.openAppStore(
                            fallbackUrl: "com.salentro.HanaVedd");
                    }
                  },
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    color: authController.userType == UserType.student
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryColor,
                  ),
                  title: Text(
                    "Privacy Policy",
                    style: AppTStyle.regularStyle12.copyWith(fontSize: 18),
                  ),
                  onTap: () {
                    Get.to(() => SupportWebView(
                        'https://daresni.net/privacy-policy',
                        "Privacy Policy"));
                  },
                ),
                const Expanded(child: SizedBox.shrink()),
                if (authController.userType == UserType.student)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: AppButton(
                      "Log Out",
                      prefix: const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                      onTap: () {},
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedLabelStyle: TextStyle(color: AppTheme.greyColor),
            selectedLabelStyle: TextStyle(color: AppTheme.secondaryColor),
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      ImageRes.assetsHome,
                      color: controller.screenIndex == 0
                          ? AppTheme.secondaryColor
                          : AppTheme.greyColor,
                    )),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        ImageRes.assetsBookMark,
                        color: controller.screenIndex == 1
                            ? AppTheme.secondaryColor
                            : AppTheme.greyColor,
                      )),
                  label: "Bookings"),
              BottomNavigationBarItem(
                  icon: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        ImageRes.assetsBankDetail,
                        color: controller.screenIndex == 2
                            ? AppTheme.secondaryColor
                            : AppTheme.greyColor,
                      )),
                  label: "Bank Detail"),
              BottomNavigationBarItem(
                  icon: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        ImageRes.assetsProfileLogo,
                        color: controller.screenIndex == 3
                            ? AppTheme.secondaryColor
                            : AppTheme.greyColor,
                      )),
                  label: "Profile"),
            ],
            unselectedItemColor: Colors.grey,
            selectedItemColor: AppTheme.secondaryColor,
            showUnselectedLabels: true,
            currentIndex: controller.screenIndex,
            onTap: (int index) {
              setState(() {
                controller.screenIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}

