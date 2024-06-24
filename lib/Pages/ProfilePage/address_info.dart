import '/Controllers/AuthenticationController/auth_controller.dart';
import '/Controllers/LocationController/location_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/LocationModel/area_list.dart';
import '/Models/LocationModel/country_list.dart';
import '/Plugins/DropDownSearch/dropdown_search.dart';
import '/Widgets/app_input_field.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: AppButton(
      //     "Save Changes",
      //     onTap: () async {
      //       await showAlertDialog().then((value) {
      //         if (value) authController.updateStudentProfile();
      //       });
      //     },
      //   ),
      // ),
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
                  GetBuilder(
                    initState: (GetBuilderState state) async {
                      locationController.getAreaList(
                          countryID: controller.countryID, stateId: null);
                    },
                    builder: (LocationController loc) {
                      return DropdownSearch<Areas>(
                        title: "Area",
                        items: loc.areaList?.areas ?? [],
                        itemAsString: (Areas? a) {
                          return a?.name ?? "";
                        },
                        selectedItem: controller.areasToShow,
                        onChanged: (Areas? a) {
                          controller.setCountryID(a?.id);
                        },
                      );
                    },
                  ),
                  AppInputField(
                    label: "Apartment/Villa/House/Flat No",
                    controller: controller.apartmentNoCtrl,
                  ),
                  AppInputField(
                    label: "Road No",
                    controller: controller.roadNoCtrl,
                  ),
                  AppInputField(
                    label: "Block No",
                    controller: controller.blockNoCtrl,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account Created On",
                        style: AppTStyle.primaryStyle12,
                      ),
                      Text(
                        controller.accountCreateAtCtrl.text,
                        style: AppTStyle.primaryStyle12.copyWith(color: AppTheme.secondaryColor),
                      ),
                    ],
                  ).paddingOnly(top: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last Updated",
                        style: AppTStyle.primaryStyle12,
                      ),
                      Text(
                        controller.accountUpdateAtCtrl.text,
                        style: AppTStyle.primaryStyle12.copyWith(color: AppTheme.secondaryColor),
                      ),
                    ],
                  ).paddingOnly(top: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Future<bool> showAlertDialog() async {
  //   bool res = false;
  //
  //   await showDialog<void>(
  //     context: Get.context!,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Material(
  //         color: Colors.transparent,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 20),
  //           child: AlertDialog(
  //             title: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text("Save your changes?",
  //                     style: AppTStyle.primaryStyle12
  //                         .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
  //                 const SizedBox(height: 5),
  //                 Text("You just made some changes, do you want to keep them",
  //                     style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14))
  //               ],
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: Text(
  //                   'No',
  //                   style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16),
  //                 ),
  //                 onPressed: () {
  //                   res = false;
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               TextButton(
  //                 child: Text(
  //                   'Yes',
  //                   style: AppTStyle.primaryStyle12.copyWith(fontSize: 16),
  //                 ),
  //                 onPressed: () {
  //                   res = true;
  //
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //   return res;
  // }
}
