import '/Models/BankDetail/all_banks_list.dart';
import '/Models/BankDetail/bank_detail.dart';
import '/Models/BankDetail/get_all_banks.dart';
import '/Services/HttpServices/api_services.dart';
import '/Services/HttpServices/api_urls.dart';
import '/Utils/get_image.dart';
import '/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BankDetailController extends GetxController {
  TextEditingController bankNameCtrl = TextEditingController();
  TextEditingController currencyCtrl = TextEditingController();
  TextEditingController accHolderName = TextEditingController();
  TextEditingController accNumCtrl = TextEditingController();
  TextEditingController ibanCtrl = TextEditingController();
  TextEditingController swiftCtrl = TextEditingController();
  TextEditingController branchCtrl = TextEditingController();
  TextEditingController bankID = TextEditingController();

  BankDetailModel? bankDetailModel;
  String? bankStatement;
  String? utilityBill;

  AllBanksList? banksList;

  void getAllBanks() async {
    final response = await ApiService.getMethod(url: ApiUrls.GET_ALL_BANKS);
    if (response == null || response.statusCode != 200) return;
    banksList = allBanksListFromJson(response.body);
    logger.i(response.body);
    update();
  }

  void getStatementImage() async {
    bankStatement = await GetImage.getImage();
    update();
  }

  void getBillImage() async {
    utilityBill = await GetImage.getImage();
    update();
  }

  void deleteImage(bool statement) {
    if (statement) {
      bankStatement = null;
    } else {
      utilityBill = null;
    }
    update();
  }

  Future<bool> saveBankDetail() async {
    showProgress();
    Map<String, String> body = {
      'bank_name': bankNameCtrl.text,
      'currency': currencyCtrl.text,
      'accHolderName': accHolderName.text,
      'accNumber': accNumCtrl.text,
      'ibanCode': ibanCtrl.text,
      'swiftCode': swiftCtrl.text,
      'bank_branch': branchCtrl.text
    };

    /// TODO:
    Map<String, String> files = {
      "bank_statement": bankStatement ?? "",
      "utility_bill": utilityBill ?? "",
    };

    final res =
        await ApiService.postMultiPartQuery(ApiUrls.SAVE_BANK_DETAIL, fields: body, files: files);
    stopProgress();

    if (res == null) return false;
    bankDetailModel = bankDetailModelFromJson(res);
    if (bankDetailModel?.bank == null) {
      AppAlerts.showSnack(
        bankDetailModel?.errors?.first ?? "Something Went Wrong",
        error: true,
      );
      return false;
    }
    clearCtrl();
    return true;
  }

  GetAllBanksModel? getTutorBanksModel;

  Future<void> getTutorBanks() async {
    // Future.delayed(Duration.zero, () => showProgress());
    final res = await ApiService.getMethod(url: ApiUrls.GET_ALL_TUTOR_BANK);
    // stopProgress();
    if (res == null || res.statusCode != 200) return;
    getTutorBanksModel = getAllBanksModelFromJson(res.body);

    update();
  }

  Future<bool> removeBankDetail(bankID) async {
    Map<String, String> body = {"bank_id": bankID.toString()};

    showProgress();
    final res = await ApiService.postMethod(url: ApiUrls.REMOVE_BANK_DETAIL, body: body);

    if (res == null || res.statusCode != 200) {
      AppAlerts.showSnack("Unable to Remove", error: true);
      return false;
    }
    logger.i(res.body);
    stopProgress();
    getTutorBanksModel?.banksList?.removeWhere((element) => element.id == bankID);
    AppAlerts.showSnack("Removed Successfully");

    update();
    return true;
  }

  void editBankDetail(Bank? bankDetail) {
    bankNameCtrl = TextEditingController(text: bankDetail?.bankName);
    currencyCtrl = TextEditingController(text: bankDetail?.currency);
    accHolderName = TextEditingController(text: bankDetail?.accHolderName);
    accNumCtrl = TextEditingController(text: bankDetail?.accNumber);
    ibanCtrl = TextEditingController(text: bankDetail?.ibanCode);
    swiftCtrl = TextEditingController(text: bankDetail?.swiftCode);
    branchCtrl = TextEditingController(text: bankDetail?.bankBranch);
    bankID = TextEditingController(text: bankDetail?.id.toString());
    update();
  }

  bool isUpdate = false;

  Future<bool> updateBankDetail() async {
    Map<String, String> body = {
      "bank_id": bankID.text,
      'bank_name': bankNameCtrl.text,
      'currency': currencyCtrl.text,
      'accHolderName': accHolderName.text,
      'accNumber': accNumCtrl.text,
      'ibanCode': ibanCtrl.text,
      'swiftCode': swiftCtrl.text,
      'bank_branch': branchCtrl.text
    };

    showProgress();
    final res = await ApiService.postMethod(url: ApiUrls.UPDATE_BANK_DETAIL, body: body);

    if (res == null || res.statusCode != 200) {
      AppAlerts.showSnack("Unable to Update", error: true);
      return false;
    }
    stopProgress();
    clearCtrl();
    await getTutorBanks();

    update();
    return true;
  }

  void clearCtrl() {
    bankNameCtrl.clear();
    currencyCtrl.clear();
    accHolderName.clear();
    accNumCtrl.clear();
    ibanCtrl.clear();
    swiftCtrl.clear();
    branchCtrl.clear();
    bankStatement = null;
    utilityBill = null;
  }
}
