class User {
  static String? Name,
      LastName,
      urlweb,
      dob,
      address,
      city,
      postcode,
      email,
      deviceToken,
      Nationality,
      Country,
      TaxCountry,
      Phonenumber,
      icomesource,
      Gender,
      sameshipping,
      Reciving_country,
      taxCountry,
      Reciving_card_address,
      Reciving_card_city,
      Reciving_zipcode,
      password,
      deviceType,
      taxincome,
      planlink,
      purpose,
      planuniquid,
      profileimage;

  static int planpage = 0;
  static int hidepage = 0;
  static int investmentHidepage = 0;

  static String EuroBlamce = '';
  static String Screen = 'Main';

  static String Phonecode = '1';
  static String kycmessage = '';

  static List rejectedaddress = [];
  static List rejectedproffid = [];

  static int? isIban, cardexits;

  static String uniqueIdNotification = '';

  static bool resendkyc = false;
}
