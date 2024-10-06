// To parse this JSON data, do
//
//     final binficaryModel = binficaryModelFromJson(jsonString);

import 'dart:convert';

BinficaryModel binficaryModelFromJson(String str) => BinficaryModel.fromJson(json.decode(str));


class BinficaryModel {
    int ? status;
    List<Datum> ? data;
    String ?message;

    BinficaryModel({
        this.status,
        this.data,
        this.message
    });

    factory BinficaryModel.fromJson(Map<String, dynamic> json) => BinficaryModel(
        status: json["status"],
        data: json["data"]== null ? []:  List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) ,

        message: json['message'] ?? ''
    );

 
}

class Datum {
    String ?uniqueId;
    String ?name;
    String ?account;
    String ?status;
    String ?created;
    String ?country;
    String ?accountType;
    String ?profileimage;

    Datum({
        this.uniqueId,
        this.name,
        this.account,
        this.status,
        this.created,
        this.country,
        this.accountType,
        this.profileimage,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uniqueId: json["unique_id"] ??"",
        name: json["name"] ??"",
        account: json["account"] ?? "",
        status: json["status"] ?? "",
        created: json["created"] ?? '',
        country: json["country"] ?? '',
        accountType: json["account_type"] ?? '',
        profileimage: json["profileimage"] ?? '',
    );

  
}
