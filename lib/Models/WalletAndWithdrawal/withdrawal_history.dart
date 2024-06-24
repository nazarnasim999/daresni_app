import 'dart:convert';

WithdrawalHistoryModel withdrawalHistoryModelFromJson(String str) =>
    WithdrawalHistoryModel.fromJson(json.decode(str));

String withdrawalHistoryModelToJson(WithdrawalHistoryModel data) => json.encode(data.toJson());

class WithdrawalHistoryModel {
  bool status;
  List<WithDrawal>? data;
  String message;
  List<dynamic> errors;

  WithdrawalHistoryModel({
    this.status = false,
    this.data,
    this.message = "",
    this.errors = const [],
  });

  factory WithdrawalHistoryModel.fromJson(Map<String, dynamic> json) => WithdrawalHistoryModel(
        status: json["status"],
        data: List<WithDrawal>.from(json["data"].map((x) => WithDrawal.fromJson(x))),
        message: json["message"],
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class WithDrawal {
  int? id;
  int? tutorId;
  int? bankId;
  int? amount;
  String? currency;
  int? status;
  String? remarks;
  String? paymentProof;
  DateTime? createdAt;
  DateTime? updatedAt;

  WithDrawal({
    this.id,
    this.tutorId,
    this.bankId,
    this.amount,
    this.currency,
    this.status,
    this.remarks,
    this.paymentProof,
    this.createdAt,
    this.updatedAt,
  });

  factory WithDrawal.fromJson(Map<String, dynamic> json) => WithDrawal(
        id: json["id"],
        tutorId: json["tutor_id"],
        bankId: json["bank_id"],
        amount: json["amount"],
        currency: json["currency"],
        status: json["status"],
        remarks: json["remarks"],
        paymentProof: json["payment_proof"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor_id": tutorId,
        "bank_id": bankId,
        "amount": amount,
        "currency": currency,
        "status": status,
        "remarks": remarks,
        "payment_proof": paymentProof,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
