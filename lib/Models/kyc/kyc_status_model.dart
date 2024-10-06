// To parse this JSON data, do
//
//     final kycStatusModel = kycStatusModelFromJson(jsonString);

import 'dart:convert';

KycStatusModel kycStatusModelFromJson(String str) => KycStatusModel.fromJson(json.decode(str));

String kycStatusModelToJson(KycStatusModel data) => json.encode(data.toJson());

class KycStatusModel {
  int? status;
  String? version;
  int? locationhide;
  int? isSetpin;
  int? sendlink;
  int? isIdproof;
  int? isAddressproof;
  int? isSelfie;
  // int? isSubmitForm;
  String? message;

  KycStatusModel({
    this.status,
    this.version,
    this.locationhide,
    this.isSetpin,
    this.sendlink,
    this.isIdproof,
    this.isAddressproof,
    this.isSelfie,
    // this.isSubmitForm,
    this.message,
  });

  factory KycStatusModel.fromJson(Map<String, dynamic> json) => KycStatusModel(
    status: json["status"],
    version: json["version"],
    locationhide: json["locationhide"],
    isSetpin: json["is_setpin"],
    sendlink: json["sendlink"],
    isIdproof: json["is_idproof"],
    isAddressproof: json["is_addressproof"],
    isSelfie: json["is_selfie"],
    // isSubmitForm: json["is_submit_form"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "version": version,
    "locationhide": locationhide,
    "is_setpin": isSetpin,
    "sendlink": sendlink,
    "is_idproof": isIdproof,
    "is_addressproof": isAddressproof,
    "is_selfie": isSelfie,
    // "is_submit_form": isSubmitForm,
    "message": message,
  };
}
