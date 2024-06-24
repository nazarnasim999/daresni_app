import 'dart:convert';

SendOtp sendOtpFromJson(String str) => SendOtp.fromJson(json.decode(str));

class SendOtp {
  bool? status;
  Otp? otp;
  String? message;

  SendOtp({
    this.status,
    this.otp,
    this.message,
  });

  factory SendOtp.fromJson(Map<String, dynamic> json) => SendOtp(
        status: json["status"],
        otp: json["user_otp_generator_table"] != null
            ? Otp.fromJson(json["user_otp_generator_table"])
            : null,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user_otp_generator_table": otp?.toJson(),
        "message": message,
      };
}

class Otp {
  String? phone;
  String? code;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Otp({
    this.phone,
    this.code,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Otp.fromJson(Map<String, dynamic> json) => Otp(
        phone: json["phone"],
        code: json["code"],
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "code": code,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
