// To parse this JSON data, do
//
//     final userGetPinModel = userGetPinModelFromJson(jsonString);

import 'dart:convert';

UserGetPinModel userGetPinModelFromJson(String str) =>
    UserGetPinModel.fromJson(json.decode(str));

String userGetPinModelToJson(UserGetPinModel data) =>
    json.encode(data.toJson());

class UserGetPinModel {
  int? status;
  String? token;
  String? defaultWallet;
  String? symbol;
  dynamic hidepage;
  String? risk;
  int? isIban;
  String? message;

  UserGetPinModel({
    this.status,
    this.token,
    this.defaultWallet,
    this.symbol,
    this.hidepage,
    this.risk,
    this.isIban,
    this.message,
  });

  factory UserGetPinModel.fromJson(Map<String, dynamic> json) =>
      UserGetPinModel(
        status: json["status"],
        token: json["token"],
        defaultWallet: json["default_wallet"],
        symbol: json["symbol"],
        hidepage: json["hidepage"],
        risk: json["risk"],
        isIban: json["is_iban"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "default_wallet": defaultWallet,
        "symbol": symbol,
        "hidepage": hidepage,
        "risk": risk,
        "is_iban": isIban,
        "message": message,
      };
}
