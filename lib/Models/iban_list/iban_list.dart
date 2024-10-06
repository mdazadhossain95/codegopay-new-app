// To parse this JSON data, do
//
//     final ibanlistModel = ibanlistModelFromJson(jsonString);

import 'dart:convert';

IbanlistModel ibanlistModelFromJson(String str) => IbanlistModel.fromJson(json.decode(str));


class IbanlistModel {
    int ?status;
    List<Ibaninfo> ? ibaninfo;
    String ? portbalance;

    IbanlistModel({
        this.status,
        this.ibaninfo,
        this.portbalance,
    });

    factory IbanlistModel.fromJson(Map<String, dynamic> json) => IbanlistModel(
        status: json["status"],
        ibaninfo: List<Ibaninfo>.from(json["ibaninfo"].map((x) => Ibaninfo.fromJson(x))) ,
        portbalance: json["portbalance"],
    );

  
}

class Ibaninfo {
    String ? ibanId;
    String  ?label;
    String ?currency;
    String ?balance;
    String ?iban;
    String ?bic;

    Ibaninfo({
        this.ibanId,
        this.label,
        this.currency,
        this.balance,
        this.iban,
        this.bic,
    });

    factory Ibaninfo.fromJson(Map<String, dynamic> json) => Ibaninfo(
        ibanId: json["iban_id"],
        label: json["label"],
        currency: json["currency"],
        balance: json["balance"],
        iban: json["iban"],
        bic: json["bic"],
    );

  
}
