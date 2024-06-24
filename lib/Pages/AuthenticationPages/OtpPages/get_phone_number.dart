import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Pages/AuthenticationPages/OtpPages/otp_enums.dart';
import 'package:darasni/Pages/AuthenticationPages/OtpPages/otp_verification_page.dart';
import 'package:darasni/Plugins/PhoneField/intl_phone_field.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GetPhoneNumber extends StatelessWidget {
  const GetPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
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
              Text("Select Your country &",
                  style: TextStyle(
                      color: AppTheme.secondaryColor, fontSize: 18)),
              Text("Add your contact number",
                  style: TextStyle(
                      color: AppTheme.secondaryColor, fontSize: 18)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Select Country & Enter Your Number",
                      style: TextStyle(
                          color: AppTheme.secondaryColor, fontSize: 12)),
                  const Text("*",
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 10),
              Form(
                key: otpController.formKey,
                child: IntlPhoneField(
                  disableLengthCheck: true,
                  hintText: "xxx-xxx-xxxx",
                  initialCountryCode: 'BH',
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (phone) {
                    logger.i(phone.completeNumber);
                    otpController.setValues(phone.countryCode, phone.number);
                  },
                ),
              ),
              Spacer(),
              Text("Get a verification code"),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
                child: AppButtonWithCorners(
                  "WhatsApp",
                  buttonColor: AppTheme.appDarkGreenColor,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset(ImageRes.ic_whatsapp,height: 30,width: 30,),
                  ),
                  onTap: () {
                    if (otpController.formKey.currentState!.validate()) {
                      otpController.sendOtp(otp_type: OTP_TYPE.whatsapp,).then((value) {
                        if (value) Get.to(() => const OtpVerificationPage(otp_type: OTP_TYPE.sms,));
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10,top: 10),
                child: AppButtonWithCorners(
                  "Submit",
                  buttonColor: AppTheme.primaryColor,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.message_outlined,color: Colors.white,),
                  ),
                  onTap: () {
                    if (otpController.formKey.currentState!.validate()) {
                      otpController.sendOtp(otp_type: OTP_TYPE.sms).then((value) {
                        if (value) Get.to(() => const OtpVerificationPage(otp_type: OTP_TYPE.whatsapp));
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
