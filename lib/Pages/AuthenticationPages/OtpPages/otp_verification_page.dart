import 'dart:async';

import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Pages/AuthenticationPages/sign_up_page.dart';
import 'package:darasni/Plugins/PinField/OtpInput/pin_code_fields.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'otp_enums.dart';

class OtpVerificationPage extends StatefulWidget {
  final OTP_TYPE? otp_type;
  const OtpVerificationPage({super.key,this.otp_type});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  int sec = 30;
  Timer? timer;
  bool retry = true;

  void runTimer() {
    retry = false;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (sec != 0) sec--;
      if (sec == 0) {
        this.timer?.cancel();
        retry = true;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    runTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not received code? ",
                    style: TextStyle(color: AppTheme.secondaryColor, fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    if (retry) Get.back();
                  },
                  child: retry
                      ? Text(
                          "Try Again! ",
                          style: TextStyle(color: AppTheme.primaryColor, fontSize: 16),
                        )
                      : Text(
                          "Try again in 00 : $sec ",
                          style: TextStyle(color: AppTheme.primaryColor, fontSize: 16),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            AppButton(
              "Submit",
              onTap: () {
                otpController.verifyOtp().then((value) {
                  if (value) {
                    Get.to(() => const SignUpPage());
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                  "Verification",
                  style: TextStyle(color: AppTheme.primaryColor, fontSize: 40),
                ),
                Text("Enter your 6 digit verification",
                    style: TextStyle(color: AppTheme.secondaryColor, fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("(OTP)", style: TextStyle(color: AppTheme.primaryColor, fontSize: 18)),
                    Text(" code", style: TextStyle(color: AppTheme.secondaryColor, fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 25),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Your OTP Code",
                        style: TextStyle(color: AppTheme.secondaryColor, fontSize: 12))),
                const SizedBox(height: 5),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    otpController.otpCtrl.text = value;
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");

                    return true;
                  },
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
