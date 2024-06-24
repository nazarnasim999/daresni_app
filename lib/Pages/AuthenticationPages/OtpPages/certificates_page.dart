import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CertificatesPage extends StatelessWidget {
  CertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: GetBuilder(
              initState: (GetBuilderState<AuthenticationController> state) async {
                return authController.getLanguages();
              },
              builder: (AuthenticationController controller) {
                return Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text("Sign Up", style: AppTStyle.secondaryStyle12.copyWith(fontSize: 30)),
                      const SizedBox(height: 7.5),
                      Text("Tutors & Coaches",
                          style: AppTStyle.secondaryStyle12.copyWith(fontSize: 20)),
                      const SizedBox(height: 50),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Certificates",
                              style: AppTStyle.secondaryStyle12.copyWith(fontSize: 19))),
                      const SizedBox(height: 20),
                      Text(
                        "Users will be more likely to book a coach if your "
                        "best certification is uploaded. However,"
                        " this will not be shared externally or to any user."
                        " Certifications will remain confidential within your account."
                        " Your account will be noted as “certified” "
                        "once documentation has been cross-checked with the Daresni team.",
                        style: AppTStyle.primaryStyle12,
                      ),
                      const SizedBox(height: 10),
                      AppButton("Choose File", onTap: () {
                        authController.getCertificates();
                      }),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: controller.certificatesImage == null
                            ? Text(
                                "No File Chosen",
                                style: AppTStyle.primaryStyle12,
                              )
                            : Icon(
                                Icons.check,
                                color: AppTheme.secondaryColor,
                              ),
                      ),
                      const SizedBox(height: 10),
                      bar,
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Upload Your CPR Document",
                            style: AppTStyle.secondaryStyle12,
                          ),
                          Text(
                            "*",
                            style: AppTStyle.primaryStyle12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AppButton("Choose File", onTap: () {
                        authController.getCPRDocument();
                      }),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: controller.cPRDocumentImage == null
                            ? Text(
                                "No File Chosen",
                                style: AppTStyle.primaryStyle12,
                              )
                            : Icon(
                                Icons.check,
                                color: AppTheme.secondaryColor,
                              ),
                      ),
                      const SizedBox(height: 20),
                      bar,
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Upload Your Passport",
                            style: AppTStyle.secondaryStyle12,
                          ),
                          Text(
                            "*",
                            style: AppTStyle.primaryStyle12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AppButton("Choose File", onTap: () {
                        authController.getPassport();
                      }),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: controller.passportImage == null
                            ? Text(
                                "No File Chosen",
                                style: AppTStyle.primaryStyle12,
                              )
                            : Icon(
                                Icons.check,
                                color: AppTheme.secondaryColor,
                              ),
                      ),
                      const SizedBox(height: 20),
                      bar,
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.agreeTAndC,
                              onChanged: (onChanged) {
                                controller.agreeTAndC = !controller.agreeTAndC;
                                controller.update();
                              }),
                          Expanded(
                            child: Text(
                              "Please tick here to acknowledge "
                              "and agree you have read "
                              "Daresni’s Terms & Conditions*",
                              style: AppTStyle.secondaryStyle12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.agreeProfilePrivacy,
                              onChanged: (onChanged) {
                                controller.agreeProfilePrivacy = !controller.agreeProfilePrivacy;
                                controller.update();
                              }),
                          Expanded(
                            child: Text(
                              "By ticking this box, you agree to potentially "
                              "share your basic profile to "
                              "include name, photos, activity.",
                              style: AppTStyle.secondaryStyle12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Daresni offers a home service and"
                        " you will be provided with the "
                        "location after a bookings is made."
                        " You will be expected to go to the "
                        "appointment at the scheduled date and time. ",
                        style: AppTStyle.primaryStyle12,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            AppButton(
              "Register Now",
              onTap: () {
                authController.registerTutor();

                // Get.offAll(() => const RegistrationFinalPage());
              },
            ),
          ],
        ),
      ),
    );
  }

  final bar = Container(height: 1, color: AppTheme.greyColor);
}
