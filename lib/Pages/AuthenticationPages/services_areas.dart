import 'package:darasni/Controllers/LocationController/location_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/LocationModel/area_list.dart';
import 'package:darasni/Models/LocationModel/country_list.dart';
import 'package:darasni/Models/LocationModel/state_list.dart';
import 'package:darasni/Plugins/DropDownSearch/dropdown_search.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesAreas extends StatelessWidget {
  const ServicesAreas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: AppButton(
          "Submit",
          onTap: () {
            logger.i(locationController.multiCountriesId.length);
            logger.i(locationController.multiStatesID.length);
            logger.i(locationController.multiCitesID.length);
            Get.back();
          },
        ),
      ),
      appBar: AppBar(
        leading:  IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text("Services Areas",style: TextStyle(color: Colors.white),),
        backgroundColor: AppTheme.secondaryColor,
      ),
      body: GetBuilder<LocationController>(
        builder: (LocationController controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  controller.countryListModel?.countries != null
                      ? DropdownSearch<Countries>.multiSelection(
                          items: controller.countryListModel?.countries ?? [],
                          isRequiredField: true,
                          title: "In which countries you can teach?",
                          onChanged: (List<Countries> country) {
                            controller.multiCountriesId = [];
                            country.forEach((element) {
                              controller.multiCountriesId.add(element.id!);
                            });

                            controller.getMultiStateList();
                          },
                          itemAsString: (Countries? lan) {
                            return lan?.name ?? "";
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                hintText: "Non Selected", hintStyle: AppTStyle.secondaryStyle12),
                          ),
                          popupProps: PopupPropsMultiSelection.menu(
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
                      : SizedBox.shrink(),
                  controller.multiStatesList.isNotEmpty
                      ? DropdownSearch<States>.multiSelection(
                          items: controller.multiStatesList,
                          isRequiredField: true,
                          title: "In which States you can teach?",
                          onChanged: (List<States> st) {
                            controller.multiStatesID = [];
                            st.forEach((element) {
                              controller.multiStatesID.add(element.id!);
                            });
                            controller.getMultiCitesList();
                          },
                          itemAsString: (States? st) {
                            return st?.name ?? "";
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                hintText: "Non Selected", hintStyle: AppTStyle.secondaryStyle12),
                          ),
                          popupProps: PopupPropsMultiSelection.menu(
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
                      : SizedBox.shrink(),
                  controller.multiCitesModel?.data != null
                      ? DropdownSearch<Areas>.multiSelection(
                          items: controller.multiCitesList,
                          isRequiredField: true,
                          title: "In which States you can teach?",
                          onChanged: (List<Areas> ar) {
                            controller.multiCitesID = [];
                            ar.forEach((element) {
                              controller.multiCitesID.add(element.id!);
                            });

                            // controller.getMultiCitesList();
                          },
                          itemAsString: (Areas? ar) {
                            return ar?.name ?? "";
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                hintText: "Non Selected", hintStyle: AppTStyle.secondaryStyle12),
                          ),
                          popupProps: PopupPropsMultiSelection.menu(
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
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
