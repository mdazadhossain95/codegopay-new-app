// To parse this JSON data, do
//
//     final cardOrderTypeModel = cardOrderTypeModelFromJson(jsonString);

import 'dart:convert';

CardOrderTypeModel cardOrderTypeModelFromJson(String str) =>
    CardOrderTypeModel.fromJson(json.decode(str));

String cardOrderTypeModelToJson(CardOrderTypeModel data) =>
    json.encode(data.toJson());

class CardOrderTypeModel {
  int? status;
  Prepaid? prepaid;
  Debit? debit;

  CardOrderTypeModel({
    this.status,
    this.prepaid,
    this.debit,
  });

  factory CardOrderTypeModel.fromJson(Map<String, dynamic> json) =>
      CardOrderTypeModel(
        status: json["status"],
        prepaid:
            json["prepaid"] == null ? null : Prepaid.fromJson(json["prepaid"]),
        debit: json["debit"] == null ? null : Debit.fromJson(json["debit"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "prepaid": prepaid?.toJson(),
        "debit": debit?.toJson(),
      };
}

class Debit {
  String? isDebitcard;
  String image;

  Debit({
    this.isDebitcard,
    required this.image,
  });

  factory Debit.fromJson(Map<String, dynamic> json) => Debit(
        isDebitcard: json["is_debitcard"] ?? "",
        image: json["image"] ?? "image.png",
      );

  Map<String, dynamic> toJson() => {
        "is_debitcard": isDebitcard,
        "image": image,
      };
}

class Prepaid {
  String? isPrepaid;
  String? image;

  Prepaid({
    this.isPrepaid,
    this.image,
  });

  factory Prepaid.fromJson(Map<String, dynamic> json) => Prepaid(
        isPrepaid: json["is_prepaid"] ?? "",
        image: json["image"] ?? "image.png",
      );

  Map<String, dynamic> toJson() => {
        "is_prepaid": isPrepaid,
        "image": image,
      };
}
