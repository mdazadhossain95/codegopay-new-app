// To parse this JSON data, do
//
//     final transactiondetailsmodel = transactiondetailsmodelFromJson(jsonString);

import 'dart:convert';

Transactiondetailsmodel transactiondetailsmodelFromJson(String str) => Transactiondetailsmodel.fromJson(json.decode(str));


class Transactiondetailsmodel {
    int ?status;
    Trxdata ?trxdata;

    Transactiondetailsmodel({
        this.status,
        this.trxdata,
    });

    factory Transactiondetailsmodel.fromJson(Map<String, dynamic> json) => Transactiondetailsmodel(
        status: json["status"],
        trxdata: Trxdata.fromJson(json["trxdata"]),
    );

   
}

class Trxdata {
    String ?mode;
    String ?beneficiaryName;
    String ?transactionDate;
    String ?reference;
    String ?status;
    String ?amount;
    String ?fee;
    String ?currency;
    String ?label;
    String ?afterBalance;
    String ?beforeBalance;
    String ? accountholder;
    String ? receiver_iban ;
    String ? receiver_bic;

    Trxdata({
        this.mode,
        this.beneficiaryName,
        this.transactionDate,
        this.reference,
        this.status,
        this.amount,
        this.fee,
        this.currency,
        this.label,
        this.afterBalance,
        this.accountholder,
        this.beforeBalance,
        this.receiver_bic,
        this.receiver_iban,
    });

    factory Trxdata.fromJson(Map<String, dynamic> json) => Trxdata(
        mode: json["mode"],
        accountholder: json['account_holder'] ?? '', 
        beneficiaryName: json["beneficiary_name"],
        transactionDate: json["transaction_date"],
        receiver_bic: json['receiver_bic'] ?? '',
        receiver_iban: json['receiver_iban'] ?? '', 

        reference: json["reference"],
        status: json["status"],
        amount: json["amount"],
        fee: json["fee"],
        currency: json["currency"],
        label: json["label"],
        afterBalance: json["after_balance"],
        beforeBalance: json["before_balance"],
    );

    Map<String, dynamic> toJson() => {
        "mode": mode,
        "beneficiary_name": beneficiaryName,
        "transaction_date": transactionDate,
        "reference": reference,
        "status": status,
        "amount": amount,
        "fee": fee,
        "currency": currency,
        "label": label,
        "after_balance": afterBalance,
        "before_balance": beforeBalance,
    };
}
