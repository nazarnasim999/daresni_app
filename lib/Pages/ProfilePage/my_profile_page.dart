import 'package:darasni/Controllers/ProfileController/student_profile_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Pages/ProfilePage/address_info.dart';
import 'package:darasni/Pages/ProfilePage/personal_info.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late PageController pageController;
  int screenIndex = 0;

  @override
  void initState() {
    profileController.getProfile();
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    screenIndex = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: AppButton(
          "Save Changes",
          onTap: () async {
            await showAlertDialog().then((value) {
              if (value) authController.updateStudentProfile();
            });
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('Delete Account'),
                    content: Text(
                        'Are you sure you want to delete your account? This action cannot be undone.'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Dismisses the dialog
                        },
                      ),
                      CupertinoDialogAction(
                        child:
                            Text('Delete', style: TextStyle(color: CupertinoColors.destructiveRed)),
                        onPressed: () {
                          profileController.deleteAccount();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              "Delete Account",
              style: AppTStyle.primaryStyle12.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: AppTheme.primaryColor,
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
                      screenIndex = 0;
                      setState(() {});
                      pageController.animateToPage(0,
                          duration: const Duration(microseconds: 500), curve: Curves.easeIn);
                    },
                    child: Text(
                      "Personal Info",
                      style: screenIndex == 0
                          ? AppTStyle.primaryStyle12
                              .copyWith(fontWeight: FontWeight.bold, fontSize: 16)
                          : AppTStyle.secondaryStyle12
                              .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: AppTheme.greyColor,
                  ),
                  TextButton(
                      onPressed: () {
                        screenIndex = 1;
                        setState(() {});
                        pageController.animateToPage(1,
                            duration: const Duration(microseconds: 500), curve: Curves.easeIn);
                      },
                      child: Text(
                        "Address Info",
                        style: screenIndex == 1
                            ? AppTStyle.primaryStyle12
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 16)
                            : AppTStyle.secondaryStyle12
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: const [
                PersonalInfo(),
                AddressInfo(),
              ],
            ),
          ),
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
