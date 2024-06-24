import 'dart:convert';

BankDetailModel bankDetailModelFromJson(String str) => BankDetailModel.fromJson(json.decode(str));

class BankDetailModel {
  int? code;
  bool? status;
  String? message;
  List<String>? errors;
  Bank? bank;

  BankDetailModel({
    this.code,
    this.status,
    this.message,
    this.bank,
    this.errors,
  });

  factory BankDetailModel.fromJson(Map<String, dynamic> json) => BankDetailModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        errors: json["errors"] != null ? List<String>.from(json["errors"].map((x) => x)) : null,
        bank: json["data"] != null ? Bank.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": bank?.toJson(),
      };
}

class Bank {
  int? tutorId;
  String? bankName;
  String? currency;
  String? accHolderName;
  String? accNumber;
  String? ibanCode;
  String? swiftCode;
  String? bankBranch;
  int? id;
  String? utilityBill;
  String? bankStatement;

  Bank(
      {this.tutorId,
      this.bankName,
      this.currency,
      this.accHolderName,
      this.accNumber,
      this.ibanCode,
      this.swiftCode,
      this.bankBranch,
      this.id,
      this.utilityBill,
      this.bankStatement});

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        tutorId: json["tutor_id"],
        bankName: json["name"] ?? json["bank_name"],
        currency: json["currency"],
        accHolderName: json["accHolderName"],
        accNumber: json["accNumber"],
        ibanCode: json["ibanCode"],
        swiftCode: json["swiftCode"],
        bankBranch: json["bank_branch"],
        bankStatement: json["bank_statement"],
        utilityBill: json["utility_bill"],
        id: json["id"] ?? json["bank_id"],
      );

  Map<String, dynamic> toJson() => {
        "tutor_id": tutorId,
        "bank_name": bankName,
        "currency": currency,
        "accHolderName": accHolderName,
        "accNumber": accNumber,
        "ibanCode": ibanCode,
        "swiftCode": swiftCode,
        "bank_branch": bankBranch,
        "id": id,
        "utility_bill": utilityBill,
        "bank_statement": bankStatement,
      };
}
