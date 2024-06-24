import 'package:darasni/Widgets/app_button.dart';

import '/Controllers/Subjects/subjects_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/subject_list.dart';
import '/Utils/utils.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSubject extends StatelessWidget {
  final bool editSubjects;

  const SelectSubject({this.editSubjects = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      builder: (SubjectController controller) {
        return Scaffold(
          bottomNavigationBar: editSubjects
              ? AppButton(
                  "Done",
                  onTap: () {
                    Get.back();
                  },
                ).paddingSymmetric(vertical: 10, horizontal: 20)
              : null,
          appBar: AppBar(
            title: Text(
              "Select Subjects",
              style: AppTStyle.primaryStyle12.copyWith(fontSize: 16,color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: Get.height * .8,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    subjectController.subjectList?.subjects.length ?? 0,
                    (index) {
                      Subjects? subjects = subjectController.subjectList?.subjects[index];
                      return ExpansionTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Select All",
                            ),
                            Checkbox(
                              value: subjects?.selected ?? false,
                              onChanged: (bool? value) {
                                // if (editSubjects) {
                                //   authController.addSubjectToListForEdit(subjects!.id!);
                                // }

                                subjects?.selected = value ?? false;
                                if (value == true) {
                                  controller.selectedSubjects.add(subjects!.id!);

                                  controller.subjectList!.subjects.forEach((element) {
                                    element.subjectChild.forEach((element) {
                                      element.selected = true;
                                    });
                                  });
                                } else {
                                  controller.selectedSubjects.remove(subjects!.id!);
                                  controller.subjectList!.subjects.forEach((element) {
                                    element.subjectChild.forEach((element) {
                                      element.selected = false;
                                    });
                                  });
                                }

                                logger.i(
                                    "${controller.selectedSubjects}>>>${controller.selectedSubjects.length}");
                                controller.update();
                              },
                            ),
                          ],
                        ),
                        backgroundColor: AppTheme.greyColor,
                        onExpansionChanged: (bool expand) {
                          if (expand) {
                            subjects?.expand = true;
                          } else {
                            subjects?.expand = false;
                          }
                          controller.update();
                        },
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                subjects?.nameInEnglish ?? "",
                                style: TextStyle(color: AppTheme.primaryColor),
                              ),
                            ),
                            Icon(subjects?.expand == false
                                ? Icons.keyboard_arrow_down_sharp
                                : Icons.keyboard_arrow_up_sharp)
                          ],
                        ),
                        children: List.generate(subjects?.subjectChild.length ?? 0, (index) {
                          SubjectChild? subjectChild = subjects?.subjectChild[index];
                          return ExpansionTile(
                            backgroundColor: Colors.grey.withOpacity(.3),
                            onExpansionChanged: (bool expand) {
                              if (expand) {
                                subjectChild?.expand = true;
                              } else {
                                subjectChild?.expand = false;
                              }
                              controller.update();
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "select all",
                                ),
                                Checkbox(
                                  value: subjectChild?.selected ?? false,
                                  onChanged: (bool? value) {
                                    subjectChild?.selected = value ?? false;

                                    if (value == true) {
                                      controller.selectedSubjects.add(subjectChild!.id!);
                                    } else {
                                      controller.selectedSubjects.remove(subjectChild!.id!);
                                      controller.selectedSubjects.remove(subjects!.id!);
                                      controller.subjectList!.subjects.forEach((element) {
                                        element.selected = false;
                                      });
                                    }

                                    // if (value == true) {
                                    //   subjectChild!.subChild.forEach((subChild) {
                                    //     controller.selectedSubjects.add(subChild.id!);
                                    //   });
                                    // } else {
                                    //   subjectChild!.subChild.forEach((subChild) {
                                    //     controller.selectedSubjects.remove(subChild.id!);
                                    //   });
                                    // }
                                    logger.i(
                                        "${controller.selectedSubjects}>>>${controller.selectedSubjects.length}");

                                    controller.update();
                                  },
                                ),
                              ],
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    subjectChild?.name?.en ?? "",
                                    style: TextStyle(color: AppTheme.secondaryColor),
                                  ),
                                ),
                                Icon(subjectChild?.expand == false
                                    ? Icons.keyboard_arrow_down_sharp
                                    : Icons.keyboard_arrow_up_sharp)
                              ],
                            ),
                            children: List.generate(subjectChild?.subChild.length ?? 0, (index) {
                              SubChild? subChild = subjectChild?.subChild[index];
                              return ListTile(
                                onTap: () {
                                  subChild?.selected = !subChild.selected;
                                  if (subChild!.selected == true) {
                                    controller.selectedSubjects.add(subChild.id!);
                                  } else {
                                    controller.selectedSubjects.remove(subChild.id!);
                                  }
                                  logger.i(
                                      "${controller.selectedSubjects}>>>${controller.selectedSubjects.length}");
                                  controller.update();
                                },
                                dense: true,
                                selected: true,
                                selectedColor: AppTheme.primaryColor.withOpacity(.3),
                                title: Text(
                                  subChild?.name?.en ?? "",
                                  style: AppTStyle.secondaryStyle12
                                      .copyWith(color: AppTheme.secondaryColor.withOpacity(.5)),
                                ),
                                trailing: Checkbox(
                                  value: subChild?.selected ?? false,
                                  onChanged: (bool? value) {
                                    subChild?.selected = !subChild.selected;
                                    if (subChild!.selected == true) {
                                      controller.selectedSubjects.add(subChild.id!);
                                    } else {
                                      controller.selectedSubjects.remove(subChild.id!);
                                    }
                                    logger.i(
                                        "${controller.selectedSubjects}>>>${controller.selectedSubjects.length}");
                                    controller.update();
                                  },
                                ),
                              );
                            }),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String truncateString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength) + '...';
    }
  }
}
