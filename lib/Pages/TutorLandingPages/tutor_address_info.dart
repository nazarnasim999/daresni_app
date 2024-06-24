import '/Controllers/AuthenticationController/auth_controller.dart';
import '/Controllers/LocationController/location_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/LocationModel/area_list.dart';
import '/Models/LocationModel/country_list.dart';
import '/Models/LocationModel/state_list.dart';
import '/Plugins/DropDownSearch/dropdown_search.dart';
import '/Utils/utils.dart';
import '/Widgets/app_input_field.dart';
import '/Widgets/form_loading.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorAddressInfo extends StatelessWidget {
  const TutorAddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<AuthenticationController>(
            builder: (AuthenticationController authCtrl) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),

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
                                authCtrl.countryToShow = null;
                                authCtrl.statesToShow = null;
                                authCtrl.stateID = null;
                                authCtrl.areasToShow = null;
                                authCtrl.areaID = null;

                                authCtrl.setCountryID(data?.id);
                                authCtrl.update();
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

                  /// State Field
                  GetBuilder(
                    initState: (GetBuilderState state) async {},
                    builder: (LocationController loc) {
                      return loc.stateList != null
                          ? DropdownSearch<States>(
                              validator: (States? co) {
                                if (co?.name == null) return "Required";
                                if (co!.name.isEmpty) return "Required";
                                return null;
                              },
                              forTutor: true,
                              isRequiredField: true,
                              title: "State",
                              items: loc.stateList?.state ?? [],
                              onChanged: (States? data) {
                                authCtrl.statesToShow = null;
                                authCtrl.stateID = null;
                                authCtrl.areasToShow = null;
                                authCtrl.areaID = null;
                                authCtrl.setStateID(data?.id);
                              },
                              itemAsString: (States? c) {
                                return c?.name ?? "";
                              },
                              selectedItem: authController.statesToShow,
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
                          : const FormLoading();
                    },
                  ),

                  /// Area Field
                  GetBuilder<LocationController>(
                    initState: (GetBuilderState controller) async {},
                    builder: (LocationController loc) {
                      return loc.areaList != null
                          ? DropdownSearch<Areas>(
                              validator: (Areas? co) {
                                if (co?.name == null) return "Required";
                                if (co!.name.isEmpty) return "Required";
                                return null;
                              },
                              forTutor: true,
                              isRequiredField: true,
                              title: "Area",
                              items: loc.areaList?.areas ?? [],
                              onChanged: (Areas? data) {
                                authCtrl.setAreaID(data?.id);
                              },
                              itemAsString: (Areas? c) {
                                return c?.name ?? "";
                              },
                              selectedItem: authController.areasToShow,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                    hintText: "Select Area", hintStyle: AppTStyle.secondaryStyle12),
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

                  AppInputField(
                    label: "Apartment/Villa/House/Flat No",
                    controller: authCtrl.apartmentNoCtrl,
                  ),
                  AppInputField(
                    label: "Road No",
                    controller: authCtrl.roadNoCtrl,
                  ),
                  AppInputField(
                    label: "Block No",
                    controller: authCtrl.blockNoCtrl,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Other Information",
                    style: AppTStyle.secondaryStyle12
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  AppInputField(
                    readonly: true,
                    label: "Account Created On",
                    controller: authCtrl.accountUpdateAtCtrl,
                  ),
                  AppInputField(
                    readonly: true,
                    label: "Last Updated",
                    controller: authCtrl.accountUpdateAtCtrl,
                  ),
                ],
              );
            },
          ),
        ),
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
