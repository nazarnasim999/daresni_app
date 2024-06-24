import 'package:darasni/Controllers/ProfileController/student_profile_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tutor_address_info.dart';
import 'tutor_personal_profile.dart';
import 'tutor_work_info.dart';

int pageNo=0;
class TutorProfilePage extends StatefulWidget {
  const TutorProfilePage({super.key});

  @override
  State<TutorProfilePage> createState() => _TutorProfilePageState();
}

class _TutorProfilePageState extends State<TutorProfilePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      profileController.changePage(pageNo);
    });

    authController.getTutorProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: AppButton(
          "Save Changes",
          onTap: () async {
            final result = await showAlertDialog();
            if (result == true) {
              authController.updateTutorProfile();
            }
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          GetBuilder<StudentProfileController>(
            builder: (StudentProfileController controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.changePage(0);
                    },
                    child: Text(
                      "Personal",
                      style: controller.currentPage == 0
                          ? AppTStyle.secondaryStyle12
                              .copyWith(fontWeight: FontWeight.bold, fontSize: 16)
                          : AppTStyle.secondaryStyle12.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.greyColor),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: AppTheme.greyColor,
                  ),
                  TextButton(
                      onPressed: () {
                        controller.changePage(1);
                      },
                      child: Text(
                        "Address",
                        style: controller.currentPage == 1
                            ? AppTStyle.secondaryStyle12
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 16)
                            : AppTStyle.secondaryStyle12.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppTheme.greyColor),
                      )),
                  Container(
                    width: 2,
                    height: 30,
                    color: AppTheme.greyColor,
                  ),
                  TextButton(
                      onPressed: () {
                        controller.changePage(2);
                      },
                      child: Text(
                        "Work",
                        style: controller.currentPage == 2
                            ? AppTStyle.secondaryStyle12
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 16)
                            : AppTStyle.secondaryStyle12.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppTheme.greyColor),
                      )),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: profileController.pageController,
            children: const [
              TutorPersonalInfo(),
              TutorAddressInfo(),
              TutorWorkInfo(),
            ],
          )),
        ],
      ),
    );
  }

  Future<bool> showAlertDialog() async {
    bool res = false;

    await showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Save your changes?",
                      style: AppTStyle.primaryStyle12
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("You just made some changes, do you want to keep them",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'No',
                    style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16),
                  ),
                  onPressed: () {
                    res = false;
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Yes',
                    style: AppTStyle.primaryStyle12.copyWith(fontSize: 16),
                  ),
                  onPressed: () {
                    res = true;

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    return res;
  }
}
