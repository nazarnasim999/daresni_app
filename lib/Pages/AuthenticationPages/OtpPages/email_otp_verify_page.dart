// ignore_for_file: must_be_immutable

import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Pages/AuthenticationPages/login_page.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/custom_form_field.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailOtpVerifyPage extends StatefulWidget {
  EmailOtpVerifyPage({super.key, this.resendOtp = false});

  bool resendOtp;

  @override
  State<EmailOtpVerifyPage> createState() => _EmailOtpVerifyPageState();
}

class _EmailOtpVerifyPageState extends State<EmailOtpVerifyPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  EmailOtpVerifyPage get widget {
    return super.widget;
  }

  @override
  void initState() {
    super.initState();
    if (widget.resendOtp) {

      otpController.reSendEmail();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Email Verification",
          style: AppTStyle.primaryStyle12.copyWith(fontSize: 14,color: Colors.white),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                otpController.reSendEmail();
              },
              child: Row(
                children: [
                  Text("Didn't receive Otp? "),
                  Text(
                    "Send again",
                    style: AppTStyle.primaryStyle12.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            AppButton(
              "Submit",
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  await otpController.verifyEmail().then((value) {
                    if (value) Get.offAll(LoginPage());
                  });
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Email verification code send to you , please submit code below ",
                    style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  AppFormField(
                    controller: authController.emailCtrl,
                    title: "Email Address",
                    hintText: "Email Address",
                    validator: (v) {
                      if (v!.isEmpty) return "Required";
                      return null;
                    },
                  ),
                  AppFormField(
                    controller: otpController.emailOtpCtrl,
                    title: "Verification Code",
                    hintText: "Verification Code",
                    validator: (v) {
                      if (v!.isEmpty) return "Required";
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
