import 'dart:convert';

import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/AuthModels/otp_verification.dart';
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Pages/AuthenticationPages/OtpPages/otp_enums.dart';

class OtpVerification extends GetxController {
  final TextEditingController codeCtrl = TextEditingController(text: "+92");
  final TextEditingController numberCtrl = TextEditingController(text: "3134905014");
  final TextEditingController otpCtrl = TextEditingController();
  final TextEditingController emailOtpCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SendOtp? otpModel;

  void setValues(String code, String number) {
    codeCtrl.text = code;
    numberCtrl.text = number;
    update();
  }

  Future<bool> sendOtp({OTP_TYPE? otp_type}) async {
    showProgress();

    Map<String, String> body = {
      "phone_code": codeCtrl.text,
      "phone": numberCtrl.text,
      "type": otp_type==OTP_TYPE.whatsapp? "whatsapp": otp_type==OTP_TYPE.sms?"sms" : "sms"
    };
    logger.wtf(body);
    try {
      final response = await ApiService.postMethod(url: ApiUrls.SEND_OTP, body: body);
      if (response?.statusCode != 200) return false;
      otpModel = sendOtpFromJson(response!.body);
      update();

      return true;
    } on Exception catch (e) {
      logger.e(e);
      return false;
    } finally {
      stopProgress();
    }
  }

  Future<bool> verifyOtp() async {
    showProgress();
    Map<String, String> body = {
      "phone_code": codeCtrl.text,
      "phone": numberCtrl.text,
      "verify_number": otpCtrl.text,
    };
    try {
      final response = await ApiService.postMethod(url: ApiUrls.VERIFY_OTP, body: body);
      stopProgress();
      if (response?.statusCode != 200) return false;
      final jd = json.decode(response!.body);
      logger.i(response.body);
      AppAlerts.showSnack(jd["message"], error: !jd["status"]);
      if (!jd["status"]) {
        return false;
      }
      clearCtrl();
      return true;
    } on Exception catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<bool> verifyEmail() async {
    showProgress();
    Map<String, String> body = {
      "email": authController.emailCtrl.text,
      "email_otp": otpController.emailOtpCtrl.text,
    };
    final result = await ApiService.postMethod(url: ApiUrls.VERIFY_EMAIL_OTP, body: body);
    stopProgress();
    if (result == null || result.statusCode != 200) return false;

    final jd = json.decode(result.body);

    if (!jd["status"]) {
      AppAlerts.showSnack(
          "${jd["message"]} ${jd["errors"].toString().replaceAll("[", "").replaceAll("]", '')}",
          error: true);
      return false;
    }

    AppAlerts.showSnack(jd["message"]);

    return true;
  }

  Future<bool> reSendEmail() async {
    await 0.delay();
    showProgress();
    Map<String, String> body = {
      "email": authController.emailCtrl.text,
    };
    final result = await ApiService.postMethod(url: ApiUrls.RE_EMAIL_OTP, body: body);
    stopProgress();
    if (result == null || result.statusCode != 200) return false;

    final jd = json.decode(result.body);

    if (!jd["status"]) {
      AppAlerts.showSnack(
          "${jd["message"]} ${jd["errors"].toString().replaceAll("[", "").replaceAll("]", '')}",
          error: true);
      return false;
    }

    AppAlerts.showSnack(jd["message"]);

    return true;
  }

  void clearCtrl() {
    // codeCtrl.clear();
    // numberCtrl.clear();
    // otpCtrl.clear();
    // otpCtrl.clear();
  }
}
