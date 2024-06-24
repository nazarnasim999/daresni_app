import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/LocationController/location_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/LocationModel/area_list.dart';
import 'package:darasni/Models/LocationModel/country_list.dart';
import 'package:darasni/Models/LocationModel/state_list.dart';
import 'package:darasni/Plugins/DropDownSearch/dropdown_search.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/custom_form_field.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'work_detail_page.dart';

class AddressInfoPage extends StatelessWidget {
  const AddressInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: GetBuilder(
              builder: (AuthenticationController controller) {
                return Form(
                  key: controller.addressValidationKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text("Sign Up", style: AppTStyle.secondaryStyle12.copyWith(fontSize: 30)),
                      const SizedBox(height: 7.5),
                      Text(
                          authController.userType == UserType.student
                              ? "to become a student"
                              : "to become a Tutor",
                          style: AppTStyle.secondaryStyle12.copyWith(fontSize: 20)),

                      const SizedBox(height: 50),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Address Info",
                              style: AppTStyle.primaryStyle12.copyWith(fontSize: 19))),
                      const SizedBox(height: 20),

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
                                  isRequiredField: true,
                                  title: "Country",
                                  items: loc.countryListModel?.countries ?? [],
                                  onChanged: (Countries? data) {
                                    controller.setCountryID(data?.id);
                                  },
                                  itemAsString: (Countries? c) {
                                    return c?.name ?? "";
                                  },
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
                              : SizedBox.shrink();
                        },
                      ),

                      /// State
                      if (authController.isTutor())
                        GetBuilder(
                          builder: (LocationController loc) {
                            return loc.stateList != null
                                ? DropdownSearch<States>(
                                    validator: (States? st) {
                                      if (st?.name == null) return "Required";
                                      if (st!.name.isEmpty) return "Required";
                                      return null;
                                    },
                                    isRequiredField: true,
                                    title: "State",
                                    items: loc.stateList?.state ?? [],
                                    onChanged: (States? st) {
                                      controller.setStateID(st?.id);
                                    },
                                    itemAsString: (States? st) {
                                      return st?.name ?? "";
                                    },
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                          hintText: "Select State",
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
                                : SizedBox.shrink();
                          },
                        ),

                      /// Area

                      GetBuilder(
                        builder: (LocationController loc) {
                          return loc.areaList != null
                              ? DropdownSearch<Areas>(
                                  validator: (Areas? ar) {
                                    if (ar?.name == null) return "Required";
                                    if (ar!.name.isEmpty) return "Required";
                                    return null;
                                  },
                                  isRequiredField: true,
                                  title: "Area",
                                  items: loc.areaList?.areas ?? [],
                                  onChanged: (Areas? ar) {
                                    controller.setAreaID(ar?.id);
                                  },
                                  itemAsString: (Areas? ar) {
                                    return ar?.name ?? "";
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                        hintText: "Select Area",
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
                              : SizedBox.shrink();
                        },
                      ),

                      /// Apartment
                      AppFormField(
                        isRequiredField: true,
                        title: "Apartment/Villa/House/Flat No",
                        hintText: "xxx-xxx-xxxxx",
                        controller: authController.apartmentNoCtrl,
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          return null;
                        },
                      ),

                      AppFormField(
                        isRequiredField: true,
                        title: "Building No",
                        hintText: "xxx-xxx-xxxxx",
                        controller: authController.buildingNoCtrl,
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          return null;
                        },
                      ),

                      /// Road No
                      AppFormField(
                        isRequiredField: true,
                        title: "Road No",
                        hintText: "xxx-xxx-xxxxx",
                        controller: authController.roadNoCtrl,
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          return null;
                        },
                      ),

                      /// Block No
                      AppFormField(
                        isRequiredField: true,
                        title: "Block No",
                        hintText: "xxx-xxx-xxxxx",
                        controller: authController.blockNoCtrl,
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          return null;
                        },
                      ),

                      /// National ID (CPR)*
                      AppFormField(
                        // keyboardType: TextInputType.number,
                        isRequiredField: authController.userType==UserType.student?false:true,
                        title: "National ID (CPR)",
                        hintText: "xxx-xxx-xxxxx",
                        controller: authController.nationalIDCtrl,
                        validator: (v) {
                          if (v!.isEmpty && authController.userType==UserType.tutor) return "Required";
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: controller.isAgree,
                            onChanged: (v) {
                              controller.isAgree = !controller.isAgree;
                              controller.update();
                            },
                            checkColor: AppTheme.primaryColor,
                            fillColor: MaterialStateProperty.all(AppTheme.appGreyColor),
                          ),
                          Text("I agree and read Daresni’s", style: AppTStyle.secondaryStyle12),
                          Text("Terms & Conditions*", style: AppTStyle.primaryStyle12),
                        ],
                      )
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
              (authController.userType == UserType.tutor) ? "Submit & Next" : "Register Now",
              onTap: () {
                final AuthenticationController controller = Get.find<AuthenticationController>();
                if (!authController.addressValidationKey.currentState!.validate()) {
                  return;
                } else if (!controller.isAgree) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please Agree Terms and Conditions'),
                    ),
                  );
                  return;
                }
                if (controller.userType == UserType.tutor) {
                  Get.to(() => WorkDetailPage());

                  return;
                }

                authController.registerStudent().then((value) {
                  // Get.offAll(() => const RegistrationFinalPage());

                  return null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
