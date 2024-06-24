import 'dart:convert';

MyWalletModel myWalletModelFromJson(String str) => MyWalletModel.fromJson(json.decode(str));

class MyWalletModel {
  int? code;
  bool? status;
  Wallet? wallet;
  String? message;

  MyWalletModel({
    this.code,
    this.status,
    this.wallet,
    this.message,
  });

  factory MyWalletModel.fromJson(Map<String, dynamic> json) => MyWalletModel(
        code: json["code"],
        status: json["status"],
        wallet: Wallet.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": wallet!.toJson(),
        "message": message,
      };
}

class Wallet {
  int? id;
  int? tutorId;
  String? balance;
  DateTime? createdAt;
  DateTime? updatedAt;

  Wallet({
    this.id,
    this.tutorId,
    this.balance,
    this.createdAt,
    this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        tutorId: json["tutor_id"],
        balance: json["balance"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tutor_id": tutorId,
        "balance": balance,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
