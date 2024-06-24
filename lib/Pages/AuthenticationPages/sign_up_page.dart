import '/Controllers/AuthenticationController/auth_controller.dart';
import '/Controllers/LocationController/location_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Pages/AuthenticationPages/address_info_page.dart';
import '/Plugins/DropDownSearch/dropdown_search.dart';
import '/Utils/utils.dart';
import '/Widgets/app_button.dart';
import '/Widgets/custom_form_field.dart';
import '/Widgets/profile_dp.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back,color: AppTheme.primaryColor,),
                    ),
                  ],
                ),
                Form(
                  key: authController.validationKey,
                  child: GetBuilder(
                    builder: (AuthenticationController controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text("Sign Up",
                              style: AppTStyle.secondaryStyle12
                                  .copyWith(fontSize: 30)),
                          const SizedBox(height: 7.5),
                          Text(
                              authController.userType == UserType.student
                                  ? "to become a student"
                                  : "to become a Tutor",
                              style: AppTStyle.secondaryStyle12
                                  .copyWith(fontSize: 20)),
                          const SizedBox(height: 50),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Profile Picture",
                                  style: AppTStyle.primaryStyle12
                                      .copyWith(fontSize: 19))),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              controller.getImage();
                            },
                            child: ProfileDP(
                              fileImage: controller.imageUrl,
                              radius: 50,
                              onDelete: () {
                                controller.imageUrl = null;
                                controller.update();
                              },
                            ),
                          ),
                          Text("Tap to Add/Change Profile Picture",
                              style: AppTStyle.primaryStyle12),
                          const SizedBox(height: 20),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Personal Info ",
                                  style: AppTStyle.primaryStyle12
                                      .copyWith(fontSize: 18))),
                          const SizedBox(height: 20),

                          /// Name Field
                          AppFormField(
                            validator: (String? v) {
                              if (v!.isEmpty) return "Required";
                              return null;
                            },
                            isRequiredField: true,
                            title: "Enter Full Name",
                            hintText: "Your Full Name",
                            controller: authController.nameCtrl,
                          ),
                          AppFormField(
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return "Required";
                              } else if (!v.isEmail) {
                                return "Invalid Email";
                              }
                              return null;
                            },
                            isRequiredField: true,
                            title: "Your Email Address",
                            hintText: "Enter Your Email",
                            controller: authController.emailCtrl,
                          ),

                          /// Nationality
                          // GetBuilder(
                          //   initState: (GetBuilderState controller) {
                          //     locationController.getCountryList();
                          //   },
                          //   builder: (LocationController loc) {
                          //     return loc.countryListModel != null
                          //         ? DropdownSearch<Countries>(
                          //             validator: (Countries? co) {
                          //               if (co?.name == null) return "Required";
                          //               if (co!.name!.isEmpty) return "Required";
                          //               return null;
                          //             },
                          //             isRequiredField: true,
                          //             forTutor: authController.isTutor(),
                          //             title: "Nationality",
                          //             items: loc.countryListModel?.countries ?? [],
                          //             onChanged: (Countries? data) {
                          //               controller.setNationalityID(data?.id);
                          //             },
                          //             itemAsString: (Countries? c) {
                          //               return c?.name ?? "";
                          //             },
                          //             dropdownDecoratorProps: DropDownDecoratorProps(
                          //               dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                          //                   hintText: "Select Country",
                          //                   hintStyle: AppTStyle.secondaryStyle12),
                          //             ),
                          //             popupProps: PopupProps.menu(
                          //               showSearchBox: true,
                          //               searchFieldProps: TextFieldProps(
                          //                 decoration: InputDecoration(
                          //                   label: Text(
                          //                     "Search",
                          //                     style: TextStyle(
                          //                       color: AppTheme.primaryColor,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         : const FormLoading();
                          //   },
                          // ),

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
                                  dropdownSearchDecoration:
                                      dropdownSearchDecoration.copyWith(
                                          hintText: "Select Gender",
                                          hintStyle: AppTStyle.secondaryStyle12),
                                ),
                              );
                            },
                          ),

                          /// Date of Birth

                          AppFormField(
                            validator: (String? v) {
                              if (v!.isEmpty) return "Required";
                              return null;
                            },
                            isRequiredField: true,
                            title: "Date of Birth",
                            hintText: "yyyy-mm-dd",
                            controller: authController.dobCtrl,
                            readOnly: true,
                            onTap: () async {
                              await controller.getDob();
                            },
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Set Password",
                                  style: AppTStyle.primaryStyle12
                                      .copyWith(fontSize: 18))),

                          /// Password
                          AppFormField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Required";
                              } else if (v.length < 8) {
                                return "password must be at least 8 characters";
                              }

                              return null;
                            },
                            obSecure: true,
                            title: "Password",
                            controller: authController.passwordCtrl,
                            isPasswordField: true,
                          ),

                          /// Re-Enter_Password
                          AppFormField(
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return "Required";
                              } else if (v != controller.passwordCtrl.text) {
                                return "Password mismatch";
                              }

                              return null;
                            },
                            isPasswordField: true,
                            obSecure: true,
                            title: "Re-enter Password",
                            controller: authController.reEnterCtrl,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
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
              "Submit & Next",
              onTap: () {
                if (authController.validationKey.currentState!.validate()) {
                  Get.to(() => const AddressInfoPage());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
