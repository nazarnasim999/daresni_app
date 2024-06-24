import 'package:darasni/Controllers/Subjects/subjects_controller.dart';
import 'package:darasni/Pages/AuthenticationPages/select_subjects.dart';

import '/Controllers/AuthenticationController/auth_controller.dart';
import '/Controllers/LocationController/location_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/languages_list.dart';
import '/Pages/TutorLandingPages/tutor_documents.dart';
import '/Plugins/DropDownSearch/dropdown_search.dart';
import '/Utils/utils.dart';
import '/Widgets/app_button.dart';
import '/Widgets/app_input_field.dart';
import '/Widgets/form_loading.dart';
import '/strings_and_const.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/subject_list.dart';

class TutorWorkInfo extends StatelessWidget {
  const TutorWorkInfo({super.key});

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
                  AppInputField(
                    label: "Work Experience",
                    controller: controller.workExperienceCtrl,
                  ),
                  const SizedBox(height: 10),

                  /// Primary Language
                  GetBuilder(
                    initState: (GetBuilderState controller) {},
                    builder: (LocationController loc) {
                      return authController.languagesList != null
                          ? DropdownSearch<Languages>(
                              validator: (Languages? co) {
                                if (co?.nameInEnglish == null) return "Required";
                                if (co!.nameInEnglish.isEmpty) return "Required";
                                return null;
                              },
                              forTutor: true,
                              isRequiredField: true,
                              title: "Language",
                              items: authController.languagesList?.languages ?? [],
                              onChanged: (Languages? data) {
                                authController.languageTOShow = null;
                                controller.setPrimaryLanguage(data?.id);
                              },
                              itemAsString: (Languages? c) {
                                return c?.nameInEnglish ?? "";
                              },
                              selectedItem: authController.languageTOShow,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                    hintText: "Select Language",
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

                  ///  Expertise
                  GetBuilder(
                    initState: (GetBuilderState controller) {},
                    builder: (SubjectController loc) {
                      return subjectController.subjectList != null
                          ? DropdownSearch<Subjects>(
                              validator: (Subjects? co) {
                                if (co?.nameInEnglish == null) return "Required";
                                if (co!.nameInEnglish!.isEmpty) return "Required";
                                return null;
                              },
                              forTutor: true,
                              isRequiredField: true,
                              title: "Select of Expertise?",
                              items: subjectController.subjectList?.subjects ?? [],
                              onChanged: (Subjects? data) {
                                subjectController.subjectTOShow = null;
                                controller.setExpertiesID(data?.id);
                              },
                              itemAsString: (Subjects? c) {
                                return c?.nameInEnglish ?? "";
                              },
                              selectedItem: authController.expertiseTOShow,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                    hintText: "Select of Expertise?",
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
                  GestureDetector(
                      onTap: () {
                        Get.to(()=>SelectSubject(editSubjects: true));
                      },
                      child: Text(
                        "Edit Subjects",
                        style: TextStyle(color: Colors.blue),
                      )),

                  Wrap(
                    children: List.generate(
                      authController.getUser()?.user?.subjects?.length ?? 0,
                      (index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 1),
                                Text(
                                  authController.getUser()?.user?.subjects?[index].name?.en ?? "",
                                  style: AppTStyle.secondaryStyle12,
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: AppTheme.appGreyColor, borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                  AppInputField(
                    label: "Select Qualification?",
                    controller: controller.qualificationCtrl,
                  ),
                  AppInputField(
                    label: "Pricing (Per Hour) in BD",
                    controller: controller.pricingCtrl,
                    inputType: TextInputType.number,
                  ),
                  AppInputField(
                    label: "You Like to Offer Your Service?",
                    controller: controller.offerServicesCtrl,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Bio",
                    style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: .5, color: AppTheme.secondaryColor)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                      child: TextField(
                        controller: controller.bioCtrl,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Text(
                            "Your Bio",
                            style: AppTStyle.secondaryStyle12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownSearch<TeachingsWay>(
                    validator: (TeachingsWay? way) {
                      if (way?.title == null) return "Required";
                      if (way!.title.isEmpty) return "Required";
                      return null;
                    },
                    isRequiredField: true,
                    forTutor: true,
                    title: "How can you Teach?",
                    items: AppConst.teachingWayList,
                    onChanged: (TeachingsWay? way) {
                      controller.howToTeach = way;
                    },
                    itemAsString: (TeachingsWay? way) {
                      return "${way?.title ?? ""}";
                    },
                    selectedItem: TeachingsWay(
                        "${controller.howToTeach == "os" ? "Online Session" : "Physical Session"}",
                        "${controller.howToTeach == "os" ? "os" : "ph"}"),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                          hintText: "Not Selected", hintStyle: AppTStyle.secondaryStyle12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .2),
                    child: AppButton("Update Documents", onTap: () {
                      Get.to(() => TutorDocuments());
                    }),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
