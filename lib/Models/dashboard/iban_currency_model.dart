// To parse this JSON data, do
//
//     final ibanCurrencyModel = ibanCurrencyModelFromJson(jsonString);

import 'dart:convert';

IbanCurrencyModel ibanCurrencyModelFromJson(String str) => IbanCurrencyModel.fromJson(json.decode(str));

String ibanCurrencyModelToJson(IbanCurrencyModel data) => json.encode(data.toJson());

class IbanCurrencyModel {
  int? status;
  List<Currency>? currency;
  List<Iban>? iban;

  IbanCurrencyModel({
    this.status,
    this.currency,
    this.iban,
  });

  factory IbanCurrencyModel.fromJson(Map<String, dynamic> json) => IbanCurrencyModel(
    status: json["status"],
    currency: json["currency"] == null ? [] : List<Currency>.from(json["currency"]!.map((x) => Currency.fromJson(x))),
    iban: json["iban"] == null ? [] : List<Iban>.from(json["iban"]!.map((x) => Iban.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "currency": currency == null ? [] : List<dynamic>.from(currency!.map((x) => x.toJson())),
    "iban": iban == null ? [] : List<dynamic>.from(iban!.map((x) => x.toJson())),
  };
}

class Currency {
  String? image;
  String? name;

  Currency({
    this.image,
    this.name,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
  };
}

class Iban {
  String? name;

  Iban({
    this.name,
  });

  factory Iban.fromJson(Map<String, dynamic> json) => Iban(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}