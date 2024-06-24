import 'dart:convert';

import 'package:darasni/Models/WalletAndWithdrawal/wallet.dart';
import 'package:darasni/Models/WalletAndWithdrawal/withdrawal_history.dart';
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawalController extends GetxController {
  final TextEditingController amountCtrl = TextEditingController();
  int? bankID;

  MyWalletModel? walletModel;

  void getWalletInfo() async {
    // Future.delayed(Duration.zero, () {
    //   showProgress();
    // });
    final response = await ApiService.postMethod(url: ApiUrls.GET_WALLET);
    // stopProgress();
    if (response == null || response.statusCode != 200) return;

    walletModel = myWalletModelFromJson(response.body);

    update();
  }

  WithdrawalHistoryModel? historyModel;

  void getWithdrawalHistory() async {
    Future.delayed(Duration.zero, () {
      showProgress();
    });
    final response = await ApiService.postMethod(url: ApiUrls.LIST_OF_WITHDRAWAL);
    stopProgress();
    if (response == null || response.statusCode != 200) return;
    historyModel = withdrawalHistoryModelFromJson(response.body);
    update();
  }

  void requestForWithdrawal() async {
    Map<String, String> body = <String, String>{
      "amount": amountCtrl.text,
      "bank_id": bankID.toString(),
    };
    Future.delayed(Duration.zero, () {
      showProgress();
    });
    final response = await ApiService.postMethod(url: ApiUrls.REQUEST_FOR_WITHDRAWAL, body: body);
    stopProgress();
    if (response == null || response.statusCode != 200) return;

    final jd = json.decode(response.body);

    AppAlerts.showSnack(jd["message"] ?? "Something Went Wrong");
    amountCtrl.clear();
    bankID = null;

    getWalletInfo();
  }

  bool validateForWithdrawal() {
    if (walletModel?.wallet?.balance == null) return false;
    final double amount = double.parse(walletModel!.wallet!.balance!);

    if (amount == 1) {
      AppAlerts.showSnack("Wallet is Empty");
      return false;
    } else if (amount < double.parse(amountCtrl.text)) {
      AppAlerts.showSnack("Amount should be less then ${walletModel?.wallet?.balance}");
      return false;
    }

    return true;
  }
}
