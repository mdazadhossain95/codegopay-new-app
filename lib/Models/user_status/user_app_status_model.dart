// To parse this JSON data, do
//
//     final userAppStatusModel = userAppStatusModelFromJson(jsonString);

import 'dart:convert';

UserAppStatusModel userAppStatusModelFromJson(String str) => UserAppStatusModel.fromJson(json.decode(str));

String userAppStatusModelToJson(UserAppStatusModel data) => json.encode(data.toJson());

class UserAppStatusModel {
  int? status;
  String? email;
  String? version;
  dynamic locationhide;
  String? message;

  UserAppStatusModel({
    this.status,
    this.email,
    this.version,
    this.locationhide,
    this.message,
  });

  factory UserAppStatusModel.fromJson(Map<String, dynamic> json) => UserAppStatusModel(
    status: json["status"],
    email: json["email"],
    version: json["version"],
    locationhide: json["locationhide"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "email": email,
    "version": version,
    "locationhide": locationhide,
    "message": message,
  };
}
