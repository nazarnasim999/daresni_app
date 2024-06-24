import '/Controllers/AuthenticationController/auth_controller.dart';
import '/Controllers/LocationController/location_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/LocationModel/country_list.dart';
import '/Plugins/DropDownSearch/dropdown_search.dart';
import '/Widgets/app_input_field.dart';
import '/Widgets/profile_dp.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<AuthenticationController>(
            builder: (AuthenticationController controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        controller.getImage();
                      },
                      child: ProfileDP(
                        imageUrl: profileController.studentProfile?.data?.profilePicture ?? "",
                        fileImage: controller.imageUrl,
                        radius: 50,
                        onDelete: () {
                          controller.imageUrl = null;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        // logger.i(authController.userType);
                        authController.updateProfilePic();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tap to Change Profile Image",
                          style: AppTStyle.secondaryStyle12.copyWith(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  AppInputField(
                    label: "Your Full Name",
                    controller: controller.nameCtrl,
                  ),
                  AppInputField(
                    label: "Your Email Address",
                    controller: controller.emailCtrl,
                  ),
                  SizedBox(height: 10),
                  GetBuilder(
                    initState: (GetBuilderState state) async {
                      locationController.getCountryList();
                    },
                    builder: (LocationController loc) {
                      return DropdownSearch<Countries>(
                        title: "Nationality",
                        items: locationController.countryListModel?.countries ?? [],
                        itemAsString: (Countries? c) {
                          return c?.name ?? "";
                        },
                        selectedItem: controller.countryToShow,
                        onChanged: (Countries? c) {
                          controller.setCountryID(c?.id);
                        },
                      );
                    },
                  ),
                  AppInputField(
                    label: "Gender",
                    controller: controller.genderCtrl,
                  ),
                  AppInputField(
                    label: "Date of Birth",
                    controller: controller.dobCtrl,
                  ),



                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [


                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 0),
                        child: Text(
                          'Contact Number',
              // style: AppTStyle.primaryStyle12,






                          style: TextStyle(
                            fontSize: 10.0,
                              color: AppTheme.primaryColor
                             // Set the font size


                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 50,

                            child: AppInputField(
                              // label: "Country Code",
                              controller: controller.phoneCodeCtrl,
                            ),
                          ),

                          Container(
                            width: 1, // Set the width of the vertical line
                            height: 30, // Set the height of the vertical line
                            color: Colors.black, // Set the color of the vertical line
                          ),





                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 300,
                            child: AppInputField(
                              // label: "Contact Number",
                              controller: controller.phoneNumber,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  // Text(
                  //   "Change Password",
                  //   style: AppTStyle.secondaryStyle12
                  //       .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  // ),
                  // const SizedBox(height: 5),
                  // AppInputField(
                  //   label: "Current Password",
                  //   controller: controller.passwordCtrl,
                  // ),
                  // AppInputField(
                  //   label: "New Password",
                  //   controller: controller.passwordCtrl,
                  // ),
                  // AppInputField(
                  //   label: "Re-enter Password",
                  //   controller: controller.reEnterCtrl,
                  // ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
