import '/Controllers/BankDetailController/bank_detail_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Models/BankDetail/bank_detail.dart';
import '/Plugins/DropDownSearch/dropdown_search.dart';
import '/Utils/utils.dart';
import '/Widgets/app_button.dart';
import '/Widgets/custom_form_field.dart';
import '/Widgets/form_loading.dart';
import '/Widgets/show_image.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view_bank_detail_page.dart';

class TutorBankDetailPage extends StatefulWidget {
  const TutorBankDetailPage({super.key});

  @override
  State<TutorBankDetailPage> createState() => _TutorBankDetailPageState();
}

class _TutorBankDetailPageState extends State<TutorBankDetailPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    bankController.clearCtrl();
    bankController.isUpdate = false;

    super.dispose();
  }

  @override
  void initState() {
    bankController.getAllBanks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.i(bankController.isUpdate);
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: GetBuilder(
            builder: (BankDetailController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppButton(
                    "Save Bank Detail",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (controller.isUpdate) {
                          controller.updateBankDetail().then((value) {
                            if (value) {
                              bankController.isUpdate = false;
                              return Get.to(() => const ViewBankDetailPage());
                            }

                            return null;
                          });
                          return;
                        }
                        controller.saveBankDetail().then((value) {
                          if (value) return Get.to(() => const ViewBankDetailPage());

                          return null;
                        });
                      }
                    },
                  ),
                ],
              );
            },
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: GetBuilder(
              builder: (BankDetailController controller) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Get.to(const ViewBankDetailPage());
                      },
                      child: Row(
                        children: [
                          Text("Bank Details",
                              style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16)),
                          const Expanded(child: SizedBox.shrink()),
                          Text(
                            "View Banks",
                            style: AppTStyle.primaryStyle12,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.remove_red_eye,
                            color: AppTheme.secondaryColor,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    controller.banksList != null
                        ? DropdownSearch<Bank>(
                            validator: (Bank? bank) {
                              if (bank?.bankName == null) return "Required";
                              if (bank!.bankName!.isEmpty) return "Required";
                              return null;
                            },
                            isRequiredField: true,
                            title: "Select Bank",
                            items: controller.banksList?.data?.data ?? [],
                            onChanged: (Bank? bank) {
                              controller.bankNameCtrl.text = bank?.bankName ?? "";
                            },
                            itemAsString: (Bank? bank) {
                              return "${bank?.bankName ?? ""}";
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                  hintText: "Not Selected", hintStyle: AppTStyle.secondaryStyle12),
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
                      forTutor: true,
                      title: "Branch",
                      isRequiredField: true,
                      hintText: "Branch",
                      controller: controller.branchCtrl,
                      validator: (v) {
                        if (v!.isEmpty) return "required";
                        return null;
                      },
                    ),
                    AppFormField(
                      forTutor: true,
                      title: "Currency",
                      isRequiredField: true,
                      hintText: "Select Currency",
                      controller: controller.currencyCtrl,
                      validator: (v) {
                        if (v!.isEmpty) return "required";
                        return null;
                      },
                    ),
                    AppFormField(
                      forTutor: true,
                      title: "Account Holder Name",
                      isRequiredField: true,
                      hintText: "Type here",
                      controller: controller.accHolderName,
                      validator: (v) {
                        if (v!.isEmpty) return "required";
                        return null;
                      },
                    ),
                    AppFormField(
                      forTutor: true,
                      title: "Account Number",
                      isRequiredField: true,
                      hintText: "xxx-xxxx-xxx",
                      controller: controller.accNumCtrl,
                    ),
                    AppFormField(
                      forTutor: true,
                      title: "IBAN Code",
                      isRequiredField: true,
                      hintText: "xxx-xxxx-xxx",
                      controller: controller.ibanCtrl,
                      validator: (v) {
                        if (v!.isEmpty) return "required";
                        return null;
                      },
                    ),
                    AppFormField(
                      forTutor: true,
                      title: "(BIC) Swift Code*",
                      isRequiredField: true,
                      hintText: "xxx-xxxx-xxx",
                      controller: controller.swiftCtrl,
                      validator: (v) {
                        if (v!.isEmpty) return "required";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        controller.bankStatement == null
                            ? AppButton(
                                "Upload Bank Statement",
                                onTap: () {
                                  controller.getStatementImage();
                                },
                              )
                            : ShowImage(
                                imageUrl: controller.bankStatement,
                                onDelete: () {
                                  controller.deleteImage(true);
                                }),
                        const Expanded(child: SizedBox.shrink()),
                        // controller.utilityBill == null
                        //     ? AppButton(
                        //         "Upload Utility Bill",
                        //         onTap: () {
                        //           controller.getBillImage();
                        //         },
                        //       )
                        //     : ShowImage(
                        //         imageUrl: controller.utilityBill,
                        //         onDelete: () {
                        //           controller.deleteImage(false);
                        //         }),
                      ],
                    ),
                    const SizedBox(height: 50)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
