import 'dart:io';
import '/Controllers/AuthenticationController/auth_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Pages/AuthenticationPages/OtpPages/email_otp_verify_page.dart';
import '/Pages/AuthenticationPages/choose_account_type.dart';
import '/Pages/AuthenticationPages/forger_password.dart';
import '/Pages/StudentLandingPages/student_tab_page.dart';
import '/Pages/TutorLandingPages/tutor_landing_page.dart';
import '/Services/StorageServices/get_storage_services.dart';
import '/Utils/utils.dart';
import '/Widgets/app_button.dart';
import '/Widgets/custom_form_field.dart';
import '/strings_and_const.dart';
import '/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (AppStorage.box.read(AppStorage.enableFinger) ?? false) {
      getAuth();
    }

    super.initState();
  }

  void getAuth() async {
    if (Platform.isAndroid) {
      return authController.getFingerPrint();
    } else {
      await 0.delay();
      showFaceIdDialog();
      // return await Get.defaultDialog(
      //   title: "Authenticate",
      //   content: Text(
      //     "App is trying to open face id to get login automatically",
      //     style: TextStyle(fontSize: 14),
      //   ).paddingSymmetric(horizontal: 20, vertical: 10),
      //   onCancel: () {
      //     Get.back();
      //   },
      //   onConfirm: () {
      //     authController.getFingerPrint();
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                    style:
                        TextStyle(color: AppTheme.primaryColor, fontSize: 40),
                  ),
                  Text("Log in to your account!",
                      style: AppTStyle.regularStyle18),
                  const SizedBox(height: 40),
                  AppFormField(
                    isRequiredField: true,
                    title: "Your email address",
                    hintText: "Enter Your Email",
                    controller: authController.emailCtrl,
                    validator: (v) {
                      if (v!.isEmpty)
                        return "Required";
                      else if (!v.isEmail) return "invalid email";
                      return null;
                    },
                  ),
                  AppFormField(
                    obSecure: true,
                    title: "password",
                    hintText: "Password",
                    controller: authController.passwordCtrl,
                    isPasswordField: true,
                    validator: (v) {
                      if (v!.isEmpty) return "Required";
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Remember me", style: AppTStyle.primaryStyle12),
                      GetBuilder<AuthenticationController>(
                        builder: (AuthenticationController controller) {
                          return Transform.scale(
                            scale: .56,
                            child: CupertinoSwitch(
                                activeColor: AppTheme.primaryColor,
                                value: controller.rememberMe,
                                onChanged: (bool v) {
                                  controller.rememberMeFun();
                                }),
                          );
                        },
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ForgetPasswordScreen());
                        },
                        child: Text(
                          "Forget Password?",
                          style: AppTStyle.primaryStyle12
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Enable Finger Print / Face ID",
                          style: AppTStyle.primaryStyle12),
                      GetBuilder<AuthenticationController>(
                        builder: (AuthenticationController controller) {
                          return Transform.scale(
                            scale: .56,
                            child: CupertinoSwitch(
                              activeColor: AppTheme.primaryColor,
                              value: AppStorage.box
                                      .read(AppStorage.enableFinger) ??
                                  controller.enableFingerPrint,
                              onChanged: (bool v) {
                                if (formKey.currentState!.validate()) {
                                  controller.enableFingerPrintFun();
                                } else {
                                  AppAlerts.showSnack(
                                      "Enter email and password",
                                      error: true);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ChooseAccountType());
              },
              child: Wrap(
                children: [
                  Text("Don’t have an account?",
                      style: AppTStyle.secondaryStyle12),
                  Text(
                    " Sign Up",
                    style: AppTStyle.primaryStyle12.copyWith(),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (authController.emailCtrl.text.isNotEmpty &&
                          authController.emailCtrl.text.isEmail) {
                        Get.to(() => EmailOtpVerifyPage(
                              resendOtp: true,
                            ));
                      } else {
                        AppAlerts.showSnack("Please enter email");
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          "Tap for ",
                          style: AppTStyle.secondaryStyle12,
                        ),
                        Text(
                          "Email Verification",
                          style: AppTStyle.primaryStyle12
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            AppButton(
              "Sign In",
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  await authController.loginUser().then(
                    (value) {
                      if (value) {
                        if (authController.getUser()?.user?.role ==
                            AppConst.STUDENT_ROLE) {
                          return Get.offAll(StudentLandingPage());
                        } else if (authController.getUser()?.user?.role ==
                            AppConst.TUTOR_ROLE) {
                          return Get.offAll(TutorLandingPage());
                        } else if (authController.getUser()?.user?.role ==
                            AppConst.INSTITUTE_ROLE) {
                          return Get.offAll(TutorLandingPage());
                        }
                      }
                      return null;
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void showFaceIdDialog() async{
    Get.dialog(Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50,left: 50),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Authenticate",
                    style:
                    TextStyle(color: AppTheme.primaryColor, fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset(ImageRes.ic_face_id,height: 120,width: 120,fit: BoxFit.fill,),
                Text(
                  "Face ID",
                  style:
                  TextStyle(color: AppTheme.black, fontSize: 17,fontWeight: FontWeight.bold),
                ),
                Text(
                  "App is trying to open Face ID\n"
                      "to get login automatically",
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(color: AppTheme.black),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(color: AppTheme.primaryColor),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(top: 4,bottom: 4),
                        child: Text("Cancel",style: TextStyle(color: Colors.white),),
                      ),),
                                      ),
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      Get.back();
                      authController.getFingerPrint();
                    },
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(color: AppTheme.primaryColor),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(top: 4,bottom: 4),
                        child: Text("OK",style: TextStyle(color: Colors.white),),
                      ),),
                    ),
                  ),
                ],
                ),
                SizedBox(height: 30,)

              ],
            ),
          ),
        ),
      ),
    ));

  }
}
