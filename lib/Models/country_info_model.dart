class CountryInfoModel {
  String ? countryId, phoneNameCode, countryName, countryCode, status, isIban;

  CountryInfoModel({
    this.countryId,
    this.phoneNameCode,
    this.countryName,
    this.countryCode,
    this.status,
    this.isIban,
  });

  factory CountryInfoModel.fromJson(Map<String, dynamic> json) {
    return CountryInfoModel(
      countryId: json['id'] ?? '',
      phoneNameCode: json['country_code'] ?? '',
      countryName: json['country_name'] ?? '',
      countryCode: json['phonecode'] == null ? '' : '+' + json['phonecode'],
      status: json['status'] ?? '',
      isIban: json['is_iban'] ?? '',
    );
  }
}
