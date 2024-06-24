import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/LocationController/location_controller.dart';
import 'package:darasni/Controllers/Subjects/subjects_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/Qualifications/qualifications_list.dart';
import 'package:darasni/Models/languages_list.dart';
import 'package:darasni/Pages/AuthenticationPages/OtpPages/certificates_page.dart';
import 'package:darasni/Pages/AuthenticationPages/select_subjects.dart';
import 'package:darasni/Plugins/DropDownSearch/dropdown_search.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/custom_form_field.dart';
import 'package:darasni/Widgets/form_loading.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../Models/subject_list.dart';
import 'registration_final_page.dart';
import 'services_areas.dart';

// ignore: must_be_immutable
class WorkDetailPage extends StatelessWidget {
  WorkDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: GetBuilder(
              initState: (GetBuilderState<AuthenticationController> state) async {
                authController.getQualificationList();
                return authController.getLanguages();
              },
              builder: (AuthenticationController controller) {
                return Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text("Sign Up", style: AppTStyle.secondaryStyle12.copyWith(fontSize: 30)),
                      const SizedBox(height: 7.5),
                      Text("Tutors & Coaches",
                          style: AppTStyle.secondaryStyle12.copyWith(fontSize: 20)),
                      const SizedBox(height: 50),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Work Detail",
                              style: AppTStyle.primaryStyle12.copyWith(fontSize: 19))),
                      const SizedBox(height: 20),

                      /// Work Experience
                      AppFormField(
                        isRequiredField: true,
                        title: "Work Experience",
                        hintText: "Enter Years",
                        hintStyle: AppTStyle.secondaryStyle12,
                        controller: authController.workExperienceCtrl,
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          return null;
                        },
                      ),

                      Text(
                        "Please select one main language and one main subject "
                        "to showcase as an expertise in your profile on our "
                        "main page users will still be able to view your entire list"
                        " of subjects and categories by maximizing your profile...",
                        style: AppTStyle.primaryStyle12,
                      ),
                      const SizedBox(height: 10),

                      /// Main Language
                      controller.languagesList != null
                          ? DropdownSearch<Languages>(
                              validator: (Languages? lan) {
                                if (lan?.nameInEnglish == null) return "Required";
                                if (lan!.nameInEnglish.isEmpty) return "Required";
                                return null;
                              },
                              isRequiredField: true,
                              title: "Language",
                              items: controller.languagesList?.languages ?? [],
                              onChanged: (Languages? lan) {
                                controller.languageID = lan?.id;
                              },
                              itemAsString: (Languages? lan) {
                                return lan?.nameInEnglish ?? "";
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                    hintText: "Non Selected",
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
                          : const FormLoading(),

                      /// Teaching Language
                      controller.languagesList != null
                          ? DropdownSearch<Languages>.multiSelection(
                              items: controller.languagesList!.languages,
                              isRequiredField: true,
                              title: "In which language you can teach?",
                              onChanged: (List<Languages> lan) {
                                controller.languagesCanTeach = lan;
                              },
                              itemAsString: (Languages? lan) {
                                return lan?.nameInEnglish ?? "";
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                    hintText: "Non Selected",
                                    hintStyle: AppTStyle.secondaryStyle12),
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
                          : const FormLoading(),

                      /// Subjects
                      GetBuilder<SubjectController>(
                        builder: (SubjectController controller) {
                          return controller.subjectList?.subjects != null
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppFormField(
                                      forTutor: true,
                                      title: "What can you teach ( Subjects )?",
                                      isRequiredField: true,
                                      hintText: "Subjects",
                                      hintStyle: AppTStyle.secondaryStyle12,
                                      readOnly: true,
                                      onTap: () async {
                                        Get.to(() => SelectSubject());
                                      },
                                    ),
                                    controller.selectedSubjects.length == 0
                                        ? Text(
                                            "Subject Not Selected Yet",
                                            style: AppTStyle.primaryStyle12,
                                          )
                                        : Text(
                                            "${controller.selectedSubjects.length} Subject Selected",
                                            style: AppTStyle.primaryStyle12,
                                          )
                                  ],
                                )
                              : const FormLoading();
                        },
                      ),

                      SizedBox(height: 20),

                      /// Expertise
                      ///
                      GetBuilder(
                        builder: (SubjectController controller) {
                          return DropdownSearch<Subjects>(
                            items: controller.subjectList?.subjects ?? [],
                            isRequiredField: true,
                            title: "Expertise?",
                            onChanged: (Subjects? sub) {
                              authController.expertiseID = sub?.id;
                            },
                            itemAsString: (Subjects? sub) {
                              return sub?.nameInEnglish ?? "";
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                  hintText: "Non Selected", hintStyle: AppTStyle.secondaryStyle12),
                            ),
                          );
                        },
                      ),
                      GetBuilder<LocationController>(
                        builder: (LocationController controller) {
                          return controller.countryListModel != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppFormField(
                                      forTutor: true,
                                      title: "Services Provided Areas",
                                      isRequiredField: true,
                                      hintText: "Services Areas",
                                      hintStyle: AppTStyle.secondaryStyle12,
                                      readOnly: true,
                                      onTap: () async {
                                        Get.to(() => ServicesAreas());
                                      },
                                    ),
                                    controller.multiCitesID.isNotEmpty
                                        ? Text("${controller.multiCitesID.length} Areas Selected")
                                        : Text("Not Selected Yet"),
                                  ],
                                )
                              : const FormLoading();
                        },
                      ),
                      SizedBox(height: 20),
                      controller.qualificationList != null
                          ? DropdownSearch<Qualification>(
                              validator: (Qualification? qua) {
                                if (qua?.name?.en == null) return "Required";
                                if (qua!.name!.en!.isEmpty) return "Required";
                                return null;
                              },
                              isRequiredField: true,
                              title: "Qualifications",
                              items: controller.qualificationList?.data?.qualification ?? [],
                              onChanged: (Qualification? lan) {
                                controller.qualificationCtrl.text = lan?.name?.en ?? "";
                                controller.qualificationId = lan?.id;
                              },
                              itemAsString: (Qualification? qua) {
                                return qua?.name?.en ?? "";
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                    hintText: "Non Selected",
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
                          : const FormLoading(),
                      AppFormField(
                        isRequiredField: true,
                        title: "Pricing (Per Hour) in BD",
                        hintText: "None Selected",
                        controller: authController.pricingCtrl,
                        keyboardType: TextInputType.number,
                      ),

                      /// Services

                      DropdownSearch<ServicesType>(
                        items: controller.servicesTypeList,
                        isRequiredField: true,
                        title: "You Like to Offer Your Service?",
                        onChanged: (ServicesType? tc) {
                          controller.typeOfService = tc?.title;
                        },
                        itemAsString: (ServicesType? tc) {
                          return tc?.title ?? "";
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                              hintText: "Non Selected", hintStyle: AppTStyle.secondaryStyle12),
                        ),
                      ),

                      Text(
                        "Describe yourself. Anything else you would like a Students/Users to know?",
                        style: AppTStyle.primaryStyle12,
                      ),

                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Your Bio",
                          style: AppTStyle.primaryStyle12,
                        ),
                      ),
                      const SizedBox(height: 5),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: .8,
                            color: AppTheme.secondaryColor.withOpacity(.5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 30, left: 10, right: 10),
                          child: TextFormField(
                            validator: (String? v) {
                              return null;
                            },
                            controller: authController.bioCtrl,
                            decoration: InputDecoration(
                                label: Text(
                                  "Your Bio",
                                  style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14),
                                ),
                                hintStyle: AppTStyle.secondaryStyle12,
                                border: InputBorder.none),
                            style: AppTStyle.secondaryStyle12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "How can you teach?",
                            style: AppTStyle.secondaryStyle12,
                          )),
                      const SizedBox(height: 10),
                      Wrap(
                        children: List.generate(
                          AppConst.teachingWayList.length,
                          (index) => RadioListTile<TeachingsWay>(
                            dense: true,
                            value: AppConst.teachingWayList[index],
                            groupValue: controller.howToTeach,
                            onChanged: (TeachingsWay? v) {
                              logger.e(v?.value);
                              controller.howToTeach = v;
                              controller.update();
                            },
                            title: Text(
                              AppConst.teachingWayList[index].title,
                              style: AppTStyle.secondaryStyle12,
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          Text("Please refer to Daresni’s ", style: AppTStyle.secondaryStyle12),
                          Text("Pricing Policy ", style: AppTStyle.primaryStyle12),
                          Text("and ", style: AppTStyle.secondaryStyle12),
                          Text("Terms & Conditions", style: AppTStyle.primaryStyle12),
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
              "Next",
              onTap: () {

                if (authController.userType == UserType.tutor) {
                  Get.to(() => CertificatesPage());

                  return;
                }

                Get.offAll(() => const RegistrationFinalPage());
              },
            ),
          ],
        ),
      ),
    );
  }


}

class ServicesType {
  final String title;

  ServicesType(this.title);
}
