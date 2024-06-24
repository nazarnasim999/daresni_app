import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/WalletAndWithdrawal/withdrawal_history.dart';
import 'package:darasni/extensions.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/withdrawal_controller.dart';

class WithdrawalHistory extends StatefulWidget {
  const WithdrawalHistory({super.key});

  @override
  State<WithdrawalHistory> createState() => _WithdrawalHistoryState();
}

class _WithdrawalHistoryState extends State<WithdrawalHistory> {
  @override
  void initState() {
    withdrawalController.getWithdrawalHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.secondaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Withdrawal History",
          style: AppTStyle.primaryStyle12.copyWith(color: Colors.white, fontSize: 14),
        ),
      ),
      body: GetBuilder<WithdrawalController>(
        builder: (WithdrawalController controller) {
          return ListView.builder(
            itemCount: controller.historyModel?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final WithDrawal? withDrawal = controller.historyModel?.data?[index];
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.greyColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "CREATED",
                              style: AppTStyle.primaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              withDrawal?.createdAt?.toFormattedDateAndTime() ?? "",
                              style: AppTStyle.secondaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SNO",
                              style: AppTStyle.primaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${index + 1}",
                              style: AppTStyle.secondaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TUTOR",
                              style: AppTStyle.primaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              authController.getUser()?.user?.name ?? "",
                              style: AppTStyle.secondaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status",
                              style: AppTStyle.primaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              withDrawal?.status == 1 ? "Approved" : "Pending",
                              style: AppTStyle.secondaryStyle12.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: withDrawal?.status == 1 ? Colors.green : Colors.redAccent),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount",
                              style: AppTStyle.primaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${withDrawal?.amount ?? ""} ${withDrawal?.currency ?? ""}",
                              style: AppTStyle.secondaryStyle12.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PAYMENT PROOF",
                              style: AppTStyle.primaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              withDrawal?.paymentProof == null ? "Not Uploaded " : 'Uploaded',
                              style: AppTStyle.secondaryStyle12.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: withDrawal?.paymentProof == null
                                    ? Colors.redAccent
                                    : Colors.green,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "REMARKS",
                              style: AppTStyle.primaryStyle12
                                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                withDrawal?.remarks ?? "",
                                style: AppTStyle.secondaryStyle12
                                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
