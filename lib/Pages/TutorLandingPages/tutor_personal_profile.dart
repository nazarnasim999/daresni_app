import '/Controllers/AuthenticationController/auth_controller.dart';
import '/Controllers/LocationController/location_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/LocationModel/country_list.dart';
import '/Plugins/DropDownSearch/dropdown_search.dart';
import '/Utils/utils.dart';
import '/Widgets/app_input_field.dart';
import '/Widgets/form_loading.dart';
import '/Widgets/profile_dp.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/AuthModels/login_model.dart';

class TutorPersonalInfo extends StatefulWidget {
  const TutorPersonalInfo({super.key});

  @override
  State<TutorPersonalInfo> createState() => _TutorPersonalInfoState();
}

class _TutorPersonalInfoState extends State<TutorPersonalInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = authController.getUser()?.user;
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
                        authController.updateProfilePic();
                      },
                      child: ProfileDP(
                        radius: 50,
                        imageUrl: user?.profilePicture ?? "",
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        authController.updateProfilePic();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
                  // AppInputField(
                  //   label: "Nationality",
                  //   controller: controller.nationalityCtrl,
                  // ),
                  SizedBox(height: 10),

                  /// Country Field
                  GetBuilder(
                    initState: (GetBuilderState controller) {
                      locationController.getCountryList();
                    },
                    builder: (LocationController loc) {
                      return loc.countryListModel != null
                          ? DropdownSearch<Countries>(
                              validator: (Countries? co) {
                                if (co?.name == null) return "Required";
                                if (co!.name!.isEmpty) return "Required";
                                return null;
                              },
                              forTutor: true,
                              isRequiredField: true,
                              title: "Nationality",
                              items: loc.countryListModel?.countries ?? [],
                              onChanged: (Countries? data) {
                                authController.countryToShow = null;
                                controller.setCountryID(data?.id);
                              },
                              itemAsString: (Countries? c) {
                                return c?.name ?? "";
                              },
                              selectedItem: authController.countryToShow,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                    hintText: "Select Country",
                                    hintStyle: AppTStyle.secondaryStyle12),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Search",
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const FormLoading();
                    },
                  ),

                  /// Gender
                  GetBuilder(
                    builder: (LocationController controller) {
                      return DropdownSearch<String>(
                        validator: (String? v) {
                          if (v == null) {
                            return "Required";
                          } else if (v.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        isRequiredField: true,
                        title: "Gender",
                        items: const ["male", "female"],
                        selectedItem: authController.genderCtrl.text,
                        onChanged: (String? data) {
                          authController.genderCtrl.text = data ?? "";
                        },
                        itemAsString: (String? g) {
                          return g?.capitalize ?? "";
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                              hintText: "Select Gender", hintStyle: AppTStyle.secondaryStyle12),
                        ),
                      );
                    },
                  ),
                  AppInputField(
                    label: "Date of Birth",
                    controller: controller.dobCtrl,
                  ),
                  AppInputField(
                    label: "Country Code",
                    controller: controller.phoneCodeCtrl,
                  ),
                  AppInputField(
                    label: "Contact Number",
                    controller: controller.phoneNumber,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Change Password",
                    style: AppTStyle.secondaryStyle12
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  AppInputField(
                    label: "Current Password",
                    controller: controller.passwordCtrl,
                  ),
                  AppInputField(
                    label: "New Password",
                    controller: controller.reEnterCtrl,
                  ),
                  AppInputField(
                    label: "Re-enter Password",
                    controller: controller.reEnterCtrl,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
