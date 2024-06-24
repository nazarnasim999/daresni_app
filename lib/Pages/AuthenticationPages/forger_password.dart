import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/custom_form_field.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: AppButton(
          "Submit",
          onTap: () {
            if (formKey.currentState!.validate()) {
              authController.forgetPassword().then((value) {
                return null;
              });
            }
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Forget Password",
          style: AppTStyle.primaryStyle12.copyWith(fontSize: 14, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "Please Enter You Email",
              style: AppTStyle.primaryStyle12.copyWith(fontSize: 20),
            ),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: AppFormField(
                isRequiredField: true,
                title: "Email",
                controller: authController.emailCtrl,
                hintText: "Enter your email here",
                validator: (v) {
                  if (v!.isEmpty)
                    return "Required";
                  else if (!v.isEmail) return "Invalid Email";
                  return null;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
