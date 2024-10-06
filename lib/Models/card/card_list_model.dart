import 'dart:convert';

CardListModel cardListModelFromJson(String str) =>
    CardListModel.fromJson(json.decode(str));

String cardListModelToJson(CardListModel data) => json.encode(data.toJson());

class CardListModel {
  int? status;
  List<CardList>? card;

  CardListModel({
    this.status,
    this.card,
  });

  factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
        status: json["status"],
        card: json["card"] == null
            ? []
            : List<CardList>.from(json["card"]!.map((x) => CardList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "card": card == null
            ? []
            : List<dynamic>.from(card!.map((x) => x.toJson())),
      };
}

class CardList {
  String? status;
  String? cid;
  String? cardType;
  String? pan;
  String? cardImage;
  String? cardMaterial;

  CardList({
    this.status,
    this.cid,
    this.cardType,
    this.pan,
    this.cardImage,
    this.cardMaterial,
  });

  factory CardList.fromJson(Map<String, dynamic> json) => CardList(
        status: json["status"],
        cid: json["cid"],
        cardType: json["cardType"],
        pan: json["pan"],
        cardImage: json["cardImage"],
        cardMaterial: json["cardMaterial"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cid": cid,
        "cardType": cardType,
        "pan": pan,
        "cardImage": cardImage,
        "cardMaterial": cardMaterial,
      };
}
