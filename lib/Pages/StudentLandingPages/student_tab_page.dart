import 'dart:io';

import 'package:app_review/app_review.dart';
import 'package:darasni/Pages/ProfilePage/aboutus.dart';
import 'package:darasni/Pages/ProfilePage/pricing.dart';
import 'package:darasni/Pages/ProfilePage/terms.dart';
import 'package:darasni/Pages/StudentLandingPages/view_booking_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '/Controllers/controllers_init.dart';
import '/Pages/AuthenticationPages/login_page.dart';
import '/Pages/Booking/order_rivew.dart';
import '/Pages/ProfilePage/my_profile_page.dart';
import '/Pages/StudentLandingPages/home_page.dart';
import '/Widgets/app_button.dart';
import '/privacy_web_view.dart';
import '/strings_and_const.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:get/get.dart';

class StudentLandingPage extends StatefulWidget {
  const StudentLandingPage({super.key});

  @override
  State<StudentLandingPage> createState() => _StudentLandingPageState();
}

class _StudentLandingPageState extends State<StudentLandingPage> {
  final List<Widget> pagesList = <Widget>[
    const StudentHomePage(),
    const ViewBookingPage(),
    const MyProfilePage(),
    // const SizedBox(),
  ];

  int screenIndex = 0;
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  final String appLink = "https://daresni.net/";

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  void _reloadData() {
    // Implement your data fetching logic here
    // For example, make an API call to fetch the data
    print('Reloading data...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagesList.elementAt(screenIndex),
      drawerEnableOpenDragGesture: false,
      appBar: screenIndex == 0
          ? AppBar(
              leading: Builder(builder: (context) {
                return GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Image.asset(ImageRes.assetsSideMenu));
              }),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => CartsReviewPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset(
                      ImageRes.assetsCart,
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
              ],
              backgroundColor: AppTheme.primaryColor,
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: Get.height * .25,
              color: AppTheme.primaryColor,
              child: Center(
                child: Image.asset(
                  ImageRes.assetsLogoWhite,
                  height: Get.height * .12,
                  width: Get.height * .12,
                ),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.bookmark, color: AppTheme.primaryColor),
              title: Text(
                "My Bookings",
                style: AppTStyle.regularStyle12.copyWith(fontSize: 18),
              ),
              onTap: () {
                Get.back();

                setState(() {
                  screenIndex = 1;
                });
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.star_half_outlined, color: AppTheme.primaryColor),
              title: Text(
                "Rate Us",
                style: AppTStyle.regularStyle12.copyWith(fontSize: 18),
              ),
              onTap: () async {
                if (Platform.isAndroid) {
                  bool available = await AppReview.isRequestReviewAvailable;
                  if(available)
                   await  AppReview.openGooglePlay(fallbackUrl: "com.daresni.tutor.student.net");
                } else if(Platform.isIOS){
                  bool available = await AppReview.isRequestReviewAvailable;
                  if(available)
                    await  AppReview.openAppStore(fallbackUrl: "com.salentro.HanaVedd");

                }
              },
            ),
            const Expanded(child: SizedBox.shrink()),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [


                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //
                //     Image.asset(ImageRes.assetsPaypalIcon, height: 40),
                //   ],
                // ),


                //
                // Container(
                //   padding: EdgeInsets.only( left: 10, bottom: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //
                //       Image.asset(ImageRes.assetsCardPaymentIcon, height: 40),
                //       Container(
                //         width: 120,
                //         child: Column(
                //           children: [
                //             Text("100% Safe & Secure Payment", style: AppTStyle.secondaryStyle),
                //             // Text(" Payment", style: AppTStyle.secondaryStyle12,
                //             //   textAlign: TextAlign.start,),
                //           ],
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(left: 14, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(ImageRes.assetsPaypalIcon, height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            Image.asset(ImageRes.assetsCardPaymentIcon, height: 40),

                          ],
                        ),
                      ),
                      Container(
                        width: 120,
                        child: Column(
                          children: [
                            Text("100% Safe & Secure Payment", style: AppTStyle.secondaryStyle),
                            // Text(" Payment", style: AppTStyle.secondaryStyle12,
                            //   textAlign: TextAlign.start,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(color: Colors.grey.withOpacity(.3), height: 2).paddingOnly(bottom: 2.5),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      "About Us",
                      "Terms and conditions",
                      "Privacy Policy",
                      "Pricing Policy",
                      "Faq’s",
                      "Contact Us",
                    ]
                        .map(
                          (e) => buildPrivacyAndAboutUs(
                            e,
                            () {

                              shareApp(e);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(color: Colors.grey.withOpacity(.3), height: 2).paddingOnly(bottom: 5),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// Facebook
                      // GestureDetector(
                      //   onTap: ()async {
                      //     await FlutterShare.shareFile(
                      //       title: 'Darseni',
                      //       text: appLink,
                      //       filePath: "Share",
                      //     );
                      //   },
                      //   child: Icon(Icons.share,size: 50,color: AppTheme.primaryColor,)
                      //       .paddingOnly(left: 10),
                      // ),

                      GestureDetector(
                        onTap: () async {


                          await launchUrl(
                              Uri.parse(
                                  'https://www.facebook.com/Daresni.Bahrain'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Image.asset(ImageRes.assetsFacebookIcon, width: 20, height: 20)
                            .paddingOnly(left: 10),
                      ),

                      /// Twitter
                      GestureDetector(
                        onTap: () async {


                          await launchUrl(
                              Uri.parse(
                                  'https://twitter.com/daresnibh'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Image.asset(ImageRes.assetsTwitterIcon, width: 20, height: 20)
                            .paddingOnly(left: 10),
                      ),

                      /// Linkedin
                      GestureDetector(
                        onTap: () async {


                          await launchUrl(
                              Uri.parse(
                                  'https://www.linkedin.com/uas/login?session_redirect=%2Fcompany%2F14451549%2F'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Image.asset(ImageRes.assetsLinkedinIcon, width: 20, height: 20)
                            .paddingOnly(left: 10),
                      ),


                      GestureDetector(
                        onTap: () async {


                          await launchUrl(
                              Uri.parse(
                                  'https://www.instagram.com/daresni.bh?igsh=enBpMXkwYXZoNTVn'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Image.asset(ImageRes.assetsInstagramIcon, width: 20, height: 20)
                            .paddingOnly(left: 10),
                      ),

                      /// Instagram
                      // GestureDetector(
                      //   onTap: () {
                      //     flutterShareMe.shareToInstagram(filePath: "filePath");
                      //   },
                      //   child: Image.asset(ImageRes.assetsLinkedinIcon, width: 20, height: 20)
                      //       .paddingOnly(left: 10),
                      // ),
                      //
                      // /// Whatsapp
                      //
                      // GestureDetector(
                      //   onTap: () {
                      //     flutterShareMe.shareToWhatsApp(msg: appLink);
                      //   },
                      //   child: Image.asset(ImageRes.assetsLinkedinIcon, width: 20, height: 20)
                      //       .paddingOnly(left: 10),
                      // ),
                    ],
                  ).paddingOnly(bottom: 10),
                ),
                Text("Copyright © 2024 Daresni - All Rights Reserved.",
                        style: AppTStyle.secondaryStyle10)
                    .paddingAll(5),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                "Log Out",
                prefix: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                onTap: () {
                  authController.logOut().then((value) {
                    if (value) {
                      Get.offAll(LoginPage());
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    ImageRes.assetsHome,
                    color: screenIndex == 0 ? AppTheme.primaryColor : AppTheme.greyColor,
                  )),
              label: "Home"),
          BottomNavigationBarItem(
              icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    ImageRes.assetsBookMark,
                    color: screenIndex == 1 ? AppTheme.primaryColor : AppTheme.greyColor,
                  )),
              label: "Bookings"),
          BottomNavigationBarItem(
              icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    ImageRes.assetsProfileLogo,
                    color: screenIndex == 2 ? AppTheme.primaryColor : AppTheme.greyColor,
                  )),
              label: "Profile"),

          // BottomNavigationBarItem(
          //     icon: SizedBox(
          //         height: 20,
          //         width: 20,
          //         child: Image.asset(
          //           ImageRes.assetsProfileLogo,
          //           color: screenIndex == 3 ? AppTheme.primaryColor : AppTheme.greyColor,
          //         )),
          //     label: "Profile")


        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppTheme.primaryColor,
        currentIndex: screenIndex,
        onTap: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
      ),
    );
  }

  Widget buildPrivacyAndAboutUs(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(children: [
        Icon(Icons.play_arrow, color: AppTheme.secondaryColor).paddingOnly(right: 7),
        Text(text, style: AppTStyle.secondaryStyle14),
      ]).paddingOnly(bottom: 5),
    );
  }

  void shareApp(e) {
    switch (e) {
      case "About Us":
        // Get.to(() => SupportWebView('https://daresni.net/about', "About Us"));
        Get.to(() => AboutUs());

        break;
      case "Terms and conditions":
        // Get.to(() =>
            // SupportWebView('https://daresni.net/terms-and-conditions', "Terms and conditions"));
            Get.to(() => Terms());

        break;
      case "Privacy Policy":


        Get.to(() => SupportWebView('https://daresni.net/privacy-policy', "Privacy Policy"));

        break;
      case "Pricing Policy":
        Get.to(() => SupportWebView('https://daresni.net/pricing-policy', "Pricing Policy"));

        break;
      case "Faq’s":
        Get.to(() => SupportWebView('https://daresni.net/page-faq', "Faq’s"));

        break;
      case "Contact Us":
        Get.to(() => SupportWebView('https://daresni.net/contact', "Contact Us"));

        break;

      default:
    }
  }
}
