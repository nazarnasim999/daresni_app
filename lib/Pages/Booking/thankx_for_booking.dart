import 'package:darasni/Pages/StudentLandingPages/student_tab_page.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThankForBookingPage extends StatelessWidget {
  const ThankForBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: AppButton("Go to Home", onTap: () {
          Get.offAll(const StudentLandingPage());
        }),
      ),
      appBar: AppBar(
        title: const Text(
          "Payment Details",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Image.asset(
              ImageRes.assetsAppLogo,
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 20),
            Text(
              "Thank You",
              style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Order has been placed Successfully",
                  style: AppTStyle.secondaryStyle12.copyWith(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundColor: AppTheme.appGreenColor,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 65,
                child: Icon(
                  Icons.check,
                  size: 70,
                  color: AppTheme.appGreenColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Congratulations!",
              style: AppTStyle.primaryStyle12.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "You will receive a confirmation in the email or SMS",
              style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
