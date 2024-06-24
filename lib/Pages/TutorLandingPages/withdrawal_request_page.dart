import 'package:darasni/Controllers/BankDetailController/bank_detail_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Controllers/withdrawal_controller.dart';
import 'package:darasni/Models/BankDetail/bank_detail.dart';
import 'package:darasni/Pages/TutorLandingPages/view_with_drawal_history.dart';
import 'package:darasni/Plugins/DropDownSearch/dropdown_search.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/custom_form_field.dart';
import 'package:darasni/Widgets/form_loading.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestWithdrawal extends StatefulWidget {
  const RequestWithdrawal({super.key});

  @override
  State<RequestWithdrawal> createState() => _RequestWithdrawalState();
}

class _RequestWithdrawalState extends State<RequestWithdrawal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    withdrawalController.getWalletInfo();
    bankController.getTutorBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: AppButton(
          "With Drawl",
          onTap: () {
            if (formKey.currentState!.validate()) {
              bool res = withdrawalController.validateForWithdrawal();

              if (res) {
                withdrawalController.requestForWithdrawal();
              }
            }
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppTheme.secondaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Withdrawal",
          style: AppTStyle.primaryStyle12.copyWith(color: Colors.white, fontSize: 14),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => WithdrawalHistory());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Text(
                    "View History",
                    style: AppTStyle.primaryStyle12.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GetBuilder<WithdrawalController>(
          builder: (WithdrawalController controller) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Wallet Balance",
                        style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16),
                      ),
                      Text(
                        "${controller.walletModel?.wallet?.balance ?? 0} BHD",
                        style: AppTStyle.primaryStyle12.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(height: 1, color: AppTheme.greyColor),
                  SizedBox(height: 20),
                  AppFormField(
                    validator: (String? v) {
                      if (v!.isEmpty)
                        return "Required";
                      else if (!v.isNumericOnly) return "Invalid Amount";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    title: "Amount",
                    isRequiredField: true,
                    controller: controller.amountCtrl,
                    hintText: "Enter Amount",
                  ),
                  GetBuilder(
                    builder: (BankDetailController bankCtrl) {
                      return bankCtrl.getTutorBanksModel?.banksList != null
                          ? DropdownSearch<Bank>(
                              validator: (Bank? bank) {
                                if (bank?.bankName == null) return "Required";
                                if (bank!.bankName!.isEmpty) return "Required";
                                return null;
                              },
                              isRequiredField: true,
                              title: "Select Bank",
                              items: bankCtrl.getTutorBanksModel?.banksList ?? [],
                              onChanged: (Bank? bank) {
                                controller.bankID = bank?.id;
                              },
                              itemAsString: (Bank? bank) {
                                return "${bank?.bankName ?? ""}";
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: dropdownSearchDecoration.copyWith(
                                    hintText: "Not Selected",
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
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
