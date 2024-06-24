import 'package:cached_network_image/cached_network_image.dart';
import 'package:darasni/Controllers/BankDetailController/bank_detail_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/BankDetail/bank_detail.dart';
import 'package:darasni/Widgets/full_screen_image.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ViewBankDetailPage extends StatefulWidget {
  const ViewBankDetailPage({super.key});

  @override
  State<ViewBankDetailPage> createState() => _ViewBankDetailPageState();
}

class _ViewBankDetailPageState extends State<ViewBankDetailPage> {
  @override
  void initState() {
    bankController.getTutorBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text(
          "Bank Details",
          style: AppTStyle.primaryStyle12.copyWith(color: Colors.white, fontSize: 16),
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back,color: Colors.white,));
        }),
        backgroundColor: AppTheme.secondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GetBuilder<BankDetailController>(
        builder: (BankDetailController controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bank Detail",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GetBuilder(
                  builder: (BankDetailController controller) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.getTutorBanksModel?.banksList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final Bank? bank = controller.getTutorBanksModel?.banksList?[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.appGreyColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Bank : ",
                                            style:
                                                AppTStyle.secondaryStyle12.copyWith(fontSize: 14)),
                                        Expanded(
                                          child: Text(bank?.bankName ?? "",
                                              style: AppTStyle.primaryStyle12.copyWith(
                                                  fontWeight: FontWeight.bold, fontSize: 14)),
                                        ),
                                        const Expanded(child: SizedBox.shrink()),
                                        GestureDetector(
                                          onTap: () {
                                            controller.editBankDetail(bank);
                                            controller.isUpdate = true;

                                            Get.back();
                                          },
                                          child: Text(
                                            "Edit",
                                            style: AppTStyle.primaryStyle12
                                                .copyWith(color: Colors.blue),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text("Branch : ",
                                            style:
                                                AppTStyle.secondaryStyle12.copyWith(fontSize: 14)),
                                        Text(bank?.bankBranch ?? "",
                                            style: AppTStyle.primaryStyle12.copyWith(
                                                fontWeight: FontWeight.bold, fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text("Currency : ",
                                            style:
                                                AppTStyle.secondaryStyle12.copyWith(fontSize: 14)),
                                        Text(bank?.currency ?? "",
                                            style: AppTStyle.primaryStyle12.copyWith(
                                                fontWeight: FontWeight.bold, fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text("Account Holder Name : ",
                                            style:
                                                AppTStyle.secondaryStyle12.copyWith(fontSize: 14)),
                                        Text(bank?.accHolderName ?? "",
                                            style: AppTStyle.primaryStyle12.copyWith(
                                                fontWeight: FontWeight.bold, fontSize: 14)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Account Number : ",
                                            style:
                                                AppTStyle.secondaryStyle12.copyWith(fontSize: 14)),
                                        Text(bank?.accNumber ?? "",
                                            style: AppTStyle.primaryStyle12.copyWith(
                                                fontWeight: FontWeight.bold, fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text("IBAN Number : ",
                                            style:
                                                AppTStyle.secondaryStyle12.copyWith(fontSize: 14)),
                                        Text(bank?.ibanCode ?? "",
                                            style: AppTStyle.primaryStyle12.copyWith(
                                                fontWeight: FontWeight.bold, fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text("(BIC) Swift Code : ",
                                            style:
                                                AppTStyle.secondaryStyle12.copyWith(fontSize: 14)),
                                        Text(bank?.swiftCode ?? "",
                                            style: AppTStyle.primaryStyle12.copyWith(
                                                fontWeight: FontWeight.bold, fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          bool result = await showAlertDialog();
                                          if (result) {
                                            controller.removeBankDetail(bank?.id);
                                          }
                                        },
                                        child: Text(
                                          "Remove",
                                          style: AppTStyle.secondaryStyle12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    // Row(
                                    //   children: [
                                    //     if (bank?.utilityBill != null)
                                    //       imageView(bank!.utilityBill!, "Utility Bills"),
                                    //     if (bank?.bankStatement != null)
                                    //       imageView(bank!.bankStatement!, "Bank Statement"),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget imageView(String image, String title) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FullScreenImageView(image: image));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTStyle.primaryStyle12),
          CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: Get.height * .2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: AppTheme.secondaryColor),
                  image: DecorationImage(image: imageProvider)),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: Container(
                  height: Get.height * .2,
                )),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor: AppTheme.appGreyColor,
              radius: 50,
              child: Icon(Icons.error, color: AppTheme.primaryColor),
            ),
          ),
        ],
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
              title: Row(
                children: [
                  Text("Are you sure you want to ",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16)),
                  const SizedBox(height: 5),
                  Text("Delete?",
                      style: AppTStyle.primaryStyle12
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold))
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
