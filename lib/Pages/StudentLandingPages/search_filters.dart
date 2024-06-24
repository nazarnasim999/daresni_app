import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/Booking%20Controller/filters_controller.dart';
import 'package:darasni/Controllers/LocationController/location_controller.dart';
import 'package:darasni/Controllers/Subjects/subjects_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/LocationModel/area_list.dart';
import 'package:darasni/Models/LocationModel/country_list.dart';
import 'package:darasni/Models/LocationModel/state_list.dart';
import 'package:darasni/Models/languages_list.dart';
import 'package:darasni/Models/subject_list.dart';
import 'package:darasni/Plugins/DropDownSearch/dropdown_search.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/form_loading.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filterd_tutors.dart';

class SearchFiltersPage extends StatefulWidget {
  const SearchFiltersPage({super.key});

  @override
  State<SearchFiltersPage> createState() => _SearchFiltersPageState();
}

class _SearchFiltersPageState extends State<SearchFiltersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filtersTutorsControllers.resetFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                "Clear filters",
                buttonColor: AppTheme.naviBlueColor,
                onTap: () {
                  Get.back();
                  Get.to(() => SearchFiltersPage());

                },
              ).paddingAll(5),
            ),
            Expanded(
              child: AppButton(
                "Search",
                onTap: () {
                  filtersTutorsControllers.getFilterTutor().then(
                        (value) {
                      Get.to(() => FilteredTutorsPage());
                    },
                  );
                },
              ).paddingAll(5),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppTheme.primaryColor,
        title: Text("Apply Filters",style: TextStyle(color: Colors.white),),
      ),
      body: GetBuilder<FiltersTutorsControllers>(
        builder: (GetxController _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                /// Country
                GetBuilder(
                  initState: (GetBuilderState controller) {
                    locationController.getCountryList();
                  },
                  builder: (LocationController loc) {
                    return loc.countryListModel != null
                        ? DropdownSearch<Countries>(
                            title: "Country",
                            items: loc.countryListModel?.countries ?? [],
                            onChanged: (Countries? data) {
                              filtersTutorsControllers.countryId = data?.id;
                              loc.stateList = null;
                              loc.areaList?.areas = null;
                              loc.update();

                              locationController.getStateList(countryId: data?.id);
                            },
                            itemAsString: (Countries? c) {
                              return c?.name ?? "";
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                hintText: "Select Country",
                                hintStyle: AppTStyle.secondaryStyle12,
                              ),
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
                ).paddingOnly(top: 50),

                /// State

                GetBuilder(
                  initState: (GetBuilderState state) async {},
                  builder: (LocationController loc) {
                    return loc.stateList != null
                        ? DropdownSearch<States>(
                            isRequiredField: true,
                            title: "State",
                            items: loc.stateList?.state ?? [],
                            onChanged: (States? data) {
                              filtersTutorsControllers.stateId = data?.id;

                              locationController.getAreaList(
                                countryID: filtersTutorsControllers.countryId,
                                stateId: data?.id,
                              );
                            },
                            itemAsString: (States? c) {
                              return c?.name ?? "";
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                  hintText: "None", hintStyle: AppTStyle.secondaryStyle12),
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
                        : SizedBox();
                  },
                ),

                /// Area
                GetBuilder(
                  initState: (GetBuilderState state) async {},
                  builder: (LocationController loc) {
                    return loc.areaList?.areas != null
                        ? DropdownSearch<Areas>(
                            title: "Area",
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                hintText: "None",
                                hintStyle: AppTStyle.secondaryStyle12,
                              ),
                            ),
                            items: loc.areaList?.areas ?? [],
                            itemAsString: (Areas? a) {
                              return a?.name ?? "";
                            },
                            onChanged: (Areas? a) {
                              filtersTutorsControllers.areaId = a?.id;
                            },
                          )
                        : SizedBox();
                  },
                ),

                /// Session Type
                // GetBuilder(
                //   builder: (LocationController controller) {
                //     return DropdownSearch<String>(
                //       title: "Session Type",
                //       items: const ["Physical Session", "Online Session"],
                //       onChanged: (String? data) {
                //         if (data == "Physical Session") {
                //           filtersTutorsControllers.sessionType = "ps";
                //         } else
                //           filtersTutorsControllers.sessionType = "os";
                //       },
                //       itemAsString: (String? g) {
                //         return g?.capitalize ?? "";
                //       },
                //       dropdownDecoratorProps: DropDownDecoratorProps(
                //         dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                //             hintText: "Select Session Type", hintStyle: AppTStyle.secondaryStyle12),
                //       ),
                //     );
                //   },
                // ),





                GetBuilder(
                    builder: (LocationController controller) {
                      child:
                      return DropdownSearch<String>(
                        title: "Session Type",
                        items: const ["Physical Session", "Online Session"],
                        onChanged: (String? data) {
                          if (data == "Physical Session") {
                            filtersTutorsControllers.sessionType = "ps";
                          } else
                            filtersTutorsControllers.sessionType = "os";
                        },

                        itemAsString: (String? g) {
                          return g?.capitalize ?? "";
                        },
                        popupProps: PopupProps.menu(
                          fit: FlexFit.loose,
                          menuProps: MenuProps(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          containerBuilder: (ctx, popupWidget) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Flexible(
                                  child: Container(
                                    child: popupWidget,
                                    color: Colors.white,

                                    height: 100,
                                  ),
                                ),


                              ],
                            );
                          },
                        ),

                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                              hintText: "Select Session Type", hintStyle: AppTStyle.secondaryStyle12),
                        ),
                      );

                    }
                ),




                /// Subject
                GetBuilder<SubjectController>(
                  initState: (GetBuilderState state) {
                    subjectController.getSubjects();
                  },
                  builder: (SubjectController sub) {
                    return DropdownSearch<Subjects>(
                      title: "Subject",
                      items: subjectController.subjectList?.subjects ?? [],
                      onChanged: (Subjects? data) {
                        filtersTutorsControllers.subjectId = data?.id;
                      },
                      itemAsString: (Subjects? sub) {
                        return sub?.nameInEnglish ?? "";
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                            hintText: "Select Subject", hintStyle: AppTStyle.secondaryStyle12),
                      ),
                    );
                  },
                ),

                /// Sub Subject
                // GetBuilder<SubjectController>(
                //   initState: (GetBuilderState state) {
                //     subjectController.getSubjects();
                //   },
                //   builder: (SubjectController sub) {
                //     return DropdownSearch<Subjects>(
                //       title: "Subject",
                //       items: subjectController.subjectList?.subjects ?? [],
                //       onChanged: (Subjects? data) {
                //         filtersTutorsControllers.subjectId = data?.id;
                //       },
                //       itemAsString: (Subjects? sub) {
                //         return sub?.nameInEnglish ?? "";
                //       },
                //       dropdownDecoratorProps: DropDownDecoratorProps(
                //         dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                //             hintText: "Select Subject", hintStyle: AppTStyle.secondaryStyle12),
                //       ),
                //     );
                //   },
                // ),
                /// Language
                GetBuilder(
                  initState: (GetBuilderState _) {
                    authController.getLanguages();
                  },
                  builder: (AuthenticationController authCtrl) {
                    return DropdownSearch<Languages>(
                      title: "Language",
                      items: authCtrl.languagesList?.languages ?? [],
                      onChanged: (Languages? data) {
                        filtersTutorsControllers.languageId = data?.id;
                      },
                      itemAsString: (Languages? lan) {
                        return lan?.nameInEnglish ?? "";
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                            hintText: "Select Language", hintStyle: AppTStyle.secondaryStyle12),
                      ),
                    );
                  },
                ),

                /// Certifications
                // GetBuilder(
                //   builder: (LocationController controller) {
                //     return DropdownSearch<String>(
                //
                //       title: "Certification",
                //       items: const ["All", "Certified", "Not Certified"],
                //       onChanged: (String? data) {
                //         filtersTutorsControllers.certificateType = data;
                //       },
                //       itemAsString: (String? g) {
                //         return g ?? "";
                //       },
                //       dropdownDecoratorProps: DropDownDecoratorProps(
                //         dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                //             hintText: "Select Certification Type",
                //             hintStyle: AppTStyle.secondaryStyle12),
                //       ),
                //     );
                //   },
                // ),


                GetBuilder(
            builder: (LocationController controller) {
              child:
             return DropdownSearch<String>(
                title: "Certification",
                items: const ["All", "Certified", "Not Certified"],
                onChanged: (String? data) {
                  filtersTutorsControllers.certificateType = data;
                },

                itemAsString: (String? g) {
                  return g ?? "";
                },
                popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  containerBuilder: (ctx, popupWidget) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Flexible(
                          child: Container(
                            child: popupWidget,
                            color: Colors.white,

                            height: 100,
                          ),
                        ),


                      ],
                    );
                  },
                ),

                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                      hintText: "Select Certification Type",
                      hintStyle: AppTStyle.secondaryStyle12),
                ),
              );

            }
                ),


                // GetBuilder(
                //   builder: (LocationController controller) {
                //     return
                //
                //
                //
                //
                //       DropdownSearch<String>(
                //         title: "Gender",
                //         items: const ["male", "female"],
                //         onChanged: (String? data) {
                //           filtersTutorsControllers.gender = data;
                //         },
                //         itemAsString: (String? g) {
                //           return g?.capitalize ?? "";
                //         },
                //         dropdownDecoratorProps: DropDownDecoratorProps(
                //           dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                //               hintText: "Select Gender", hintStyle: AppTStyle.secondaryStyle12),
                //
                //         ),
                //
                //
                //
                //       );
                //   },
                // ),

                GetBuilder(
                    builder: (LocationController controller) {
                      child:
                      return DropdownSearch<String>(
                        title: "Gender",
                        items: const ["male", "female"],
                        onChanged: (String? data) {
                                  filtersTutorsControllers.gender = data;
                                },

                        itemAsString: (String? g) {
                          return g ?? "";
                        },
                        popupProps: PopupProps.menu(
                          fit: FlexFit.loose,
                          menuProps: MenuProps(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          containerBuilder: (ctx, popupWidget) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Flexible(
                                  child: Container(
                                    child: popupWidget,
                                    color: Colors.white,

                                    height: 100,
                                  ),
                                ),


                              ],
                            );
                          },
                        ),

                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                              hintText: "Select Gender",
                              hintStyle: AppTStyle.secondaryStyle12),
                        ),
                      );

                    }
                ),

                /// Gender
                // GetBuilder(
                //   builder: (LocationController controller) {
                //     return
                //
                //
                //
                //
                //       DropdownSearch<String>(
                //       title: "Gender",
                //       items: const ["male", "female"],
                //       onChanged: (String? data) {
                //         filtersTutorsControllers.gender = data;
                //       },
                //       itemAsString: (String? g) {
                //         return g?.capitalize ?? "";
                //       },
                //       dropdownDecoratorProps: DropDownDecoratorProps(
                //         dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                //             hintText: "Select Gender", hintStyle: AppTStyle.secondaryStyle12),
                //
                //       ),
                //
                //
                //
                //     );
                //   },
                // ).paddingOnly(bottom: 50),
              ],
            ),
          );
        },
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
