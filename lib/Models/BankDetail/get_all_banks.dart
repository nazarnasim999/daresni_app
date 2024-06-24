import 'dart:convert';

import 'package:darasni/Models/BankDetail/bank_detail.dart';

GetAllBanksModel getAllBanksModelFromJson(String str) =>
    GetAllBanksModel.fromJson(json.decode(str));

class GetAllBanksModel {
  int? code;
  bool? status;
  List<Bank>? banksList;

  GetAllBanksModel({
    this.code,
    this.status,
    this.banksList,
  });

  factory GetAllBanksModel.fromJson(Map<String, dynamic> json) => GetAllBanksModel(
        code: json["code"],
        status: json["status"],
        banksList: json["data"] != null
            ? List<Bank>.from(json["data"].map((x) => Bank.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": banksList != null ? List<dynamic>.from(banksList!.map((x) => x.toJson())) : null,
      };
}
