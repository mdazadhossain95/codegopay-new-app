part of 'dashboard_bloc.dart';

@immutable
class DashboardState {
  bool? isloading;
  UpdateModel? updateModel;
  bool? open;
  DebitFees? debitFees;
  DashboardModel? dashboardModel;
  Pdfmodel? pdfmodel;
  Cardordermodel? cardordermodel;
  Transactiondetailsmodel? transactiondetailsmodel;
  StatusModel? statusModel;

  CardDetails? cardDetails;
  Debitcardinfo? debitcardinfo;
  GiftCardListModel? giftCardListModel;
  GiftCardGetFeeTypeModel? giftCardGetFeeTypeModel;
  GiftCardGetFeeDataModel? giftCardGetFeeDataModel;
  BuyGiftCardConfirmModel? buyGiftCardConfirmModel;
  GiftCardDetailsModel? giftCardDetailsModel;
  GiftCardDeleteModel? giftCardDeleteModel;
  GiftCardShareModel? giftCardShareModel;
  CardListModel? cardListModel;
  CardOrderTypeModel? cardOrderTypeModel;
  CardTypeModel? cardTypeModel;
  CardOderDetailsModel? cardOderDetailsModel;
  CardOrderConfirmModel? cardOrderConfirmModel;
  UserCardDetailsModel? userCardDetailsModel;
  CardSettingsModel? cardSettingsModel;
  CardActiveModel? cardActiveModel;
  CardBlockUnblockModel? cardBlockUnblockModel;
  CardReplaceModel? cardReplaceModel;
  CardIbanListModel? cardIbanListModel;
  CardTopUpFeeModel? cardTopUpFeeModel;
  CardTopUpConfirmModel? cardTopUpConfirmModel;
  TrxBiometricConfirmationNotificationsModel?
      trxBiometricConfirmationNotificationsModel;
  CardBeneficiaryListModel? cardBeneficiaryListModel;
  AddCardBeneficiaryModel? addCardBeneficiaryModel;
  DeleteCardBeneficiaryModel? deleteCardBeneficiaryModel;
  CardToCardTransferFeeModel? cardToCardTransferFeeModel;
  CardToCardTransferConfirmModel? cardToCardTransferConfirmModel;
  DownloadTransactionModel? downloadTransactionModel;
  TransactionApprovedModel? transactionApprovedModel;
  IbanlistModel? ibanlistModel;
  IbanCurrencyModel? ibanCurrencyModel;
  IbanKycCheckModel? ibanKycCheckModel;

  DashboardState({
    this.isloading,
    this.ibanlistModel,
    this.updateModel,
    this.dashboardModel,
    this.statusModel,
    this.open,
    this.cardordermodel,
    this.debitFees,
    this.debitcardinfo,
    this.cardDetails,
    this.transactiondetailsmodel,
    this.pdfmodel,
    this.giftCardListModel,
    this.giftCardGetFeeTypeModel,
    this.giftCardGetFeeDataModel,
    this.buyGiftCardConfirmModel,
    this.giftCardDetailsModel,
    this.giftCardDeleteModel,
    this.giftCardShareModel,
    this.cardListModel,
    this.cardOrderTypeModel,
    this.cardTypeModel,
    this.cardOderDetailsModel,
    this.cardOrderConfirmModel,
    this.userCardDetailsModel,
    this.cardSettingsModel,
    this.cardActiveModel,
    this.cardBlockUnblockModel,
    this.cardReplaceModel,
    this.cardIbanListModel,
    this.cardTopUpFeeModel,
    this.cardTopUpConfirmModel,
    this.trxBiometricConfirmationNotificationsModel,
    this.cardBeneficiaryListModel,
    this.addCardBeneficiaryModel,
    this.deleteCardBeneficiaryModel,
    this.cardToCardTransferFeeModel,
    this.cardToCardTransferConfirmModel,
    this.downloadTransactionModel,
    this.transactionApprovedModel,
    this.ibanCurrencyModel,
    this.ibanKycCheckModel,
  });

  factory DashboardState.init() {
    return DashboardState(
      isloading: false,
      open: false,
      pdfmodel: Pdfmodel(),
      ibanlistModel: IbanlistModel(ibaninfo: [], portbalance: '', status: 222),
      updateModel: UpdateModel(
        message: '',
      ),
      transactiondetailsmodel: Transactiondetailsmodel(),
      cardordermodel:
          Cardordermodel(isCardOrder: 222, message: '', status: 222),
      debitcardinfo: Debitcardinfo(
          cardDetails: CardinfoDetails(cardNumber: '', cvv: '', expiryDate: ''),
          message: '',
          status: 222),
      cardDetails: CardDetails(
          cardImage: '',
          debitbalance: '',
          transactions: [],
          cardDetails: CardDetailsClass(cardLock: '', balance: '')),
      debitFees: DebitFees(
          isShipping: 222,
          symbol: '',
          message: '',
          serviceFee: "",
          bankBalance: '',
          cardType: '',
          currencyName: '',
          label: '',
          planName: '',
          shippingCost: '',
          status: 222),
      statusModel: StatusModel(message: '', page: '', status: 222),
      dashboardModel: DashboardModel(
        balance: '',
        iban: '',
        beneficary: [],
        bic: '',
        currency: '',
        notifications: [],
        transaction: Transaction(today: [], past: [], yesterday: []),
        the3Dsconf: The3Dsconf(status: 222, uniqueId: "", body: ""),
        sof: Sof(sourceOfWealth: 0, sourceOfWealthMsg: ""),
        profileimage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRp0xKoXUryp0JZ1Sxp-99eQiQcFrmA1M1qbQ&usqp=CAU',
      ),
      giftCardListModel: GiftCardListModel(status: 0, cardList: []),
      giftCardGetFeeTypeModel:
          GiftCardGetFeeTypeModel(image: '', cardType: [], iban: []),
      giftCardGetFeeDataModel: GiftCardGetFeeDataModel(
          image: '', cardType: [], plan: [], status: 222),
      buyGiftCardConfirmModel:
          BuyGiftCardConfirmModel(status: 222, message: ''),
      giftCardDetailsModel: GiftCardDetailsModel(
          status: 222,
          image: "",
          card: Card(
              uniqueId: '',
              loadedAmount: '',
              fee: '',
              totalPay: '',
              description: '',
              cardNumber: '',
              expiryDate: '',
              cvv: '',
              cardStatus: '',
              created: DateTime(01, 01, 2024),
              balance: '',
              trx: [])),
      giftCardDeleteModel: GiftCardDeleteModel(status: 222, message: ''),
      giftCardShareModel: GiftCardShareModel(status: 222, message: ''),
      cardListModel: CardListModel(status: 222, card: []),
      cardOrderTypeModel: CardOrderTypeModel(
        status: 222,
        prepaid: Prepaid(image: ""),
        debit: Debit(image: ""),
      ),
      cardTypeModel: CardTypeModel(
          shipping: Shipping(country: []),
          status: 222,
          cardWithCardHolder: 0,
          cardWithoutCardHolder: 0,
          cardImage: ""),
      cardOderDetailsModel: CardOderDetailsModel(
        status: 222,
        card: Cardv(
          fee: "0.00",
          shippingCost: "0.00",
          total: "0.00",
        ),
        symbol: "",
      ),
      cardOrderConfirmModel: CardOrderConfirmModel(status: 222, message: ""),
      userCardDetailsModel: UserCardDetailsModel(
          status: 222,
          userCardDetails: UserCardDetails(
            cardHolderName: "",
            isActive: 0,
            cardnumber: "",
            fullcardnumber: "",
            expiry: "",
            cvv: "",
            cardImage: "",
            cardType: "",
            balance: "",
            cardMaterial: "",
            textStatus: "",
            status: "",
            isPrepaidDebit: "",
            symbol: "",
            cardTrx: [],
            cid: "",
            cardSetting: CardSetting(
                online: '0',
                contactless: '0',
                recurring: '0',
                dailyLimit: '0.00',
                contactlessLimit: '0.00',
                atmlBlock: "0"),
          )),
      cardSettingsModel: CardSettingsModel(status: 222, message: ""),
      cardActiveModel: CardActiveModel(status: 222, message: ""),
      cardBlockUnblockModel: CardBlockUnblockModel(status: 222, message: ""),
      cardReplaceModel: CardReplaceModel(status: 222, message: ""),
      cardIbanListModel: CardIbanListModel(status: 222, ibaninfo: []),
      cardTopUpFeeModel: CardTopUpFeeModel(
          status: 222, loadAmount: "", totalFee: "", totalPay: "", symbol: ""),
      cardTopUpConfirmModel: CardTopUpConfirmModel(status: 222, message: ""),
      trxBiometricConfirmationNotificationsModel:
          TrxBiometricConfirmationNotificationsModel(
              status: 222,
              data: Data(
                  title: "", image: "", challengeExpiresAfter: "", body: "")),
      cardBeneficiaryListModel: CardBeneficiaryListModel(
        status: 222,
        data: [],
      ),
      addCardBeneficiaryModel:
          AddCardBeneficiaryModel(status: 222, message: ""),
      deleteCardBeneficiaryModel:
          DeleteCardBeneficiaryModel(status: 222, message: ""),
      cardToCardTransferFeeModel: CardToCardTransferFeeModel(
          status: 222, currecny: "", loadCardFee: "", totalPay: ""),
      cardToCardTransferConfirmModel:
          CardToCardTransferConfirmModel(status: 222, message: ""),
      downloadTransactionModel:
          DownloadTransactionModel(status: 222, filelink: ""),
      transactionApprovedModel:
          TransactionApprovedModel(status: 222, message: ""),
      ibanCurrencyModel: IbanCurrencyModel(status: 222, currency: [], iban: []),
      ibanKycCheckModel:
      IbanKycCheckModel(status: 222, sumsubtoken: "", message: ""),
    );
  }

  DashboardState update({
    bool? isloading,
    IbanlistModel? ibanlistModel,
    DashboardModel? dashboardModel,
    Transactiondetailsmodel? transactiondetailsmodel,
    bool? open,
    Pdfmodel? pdfmodel,
    DebitFees? debitFees,
    UpdateModel? updateModel,
    StatusModel? statusModel,
    Cardordermodel? cardordermodel,
    CardDetails? cardDetails,
    Debitcardinfo? debitcardinfo,
    GiftCardListModel? giftCardListModel,
    GiftCardGetFeeTypeModel? giftCardGetFeeTypeModel,
    GiftCardGetFeeDataModel? giftCardGetFeeDataModel,
    BuyGiftCardConfirmModel? buyGiftCardConfirmModel,
    GiftCardDetailsModel? giftCardDetailsModel,
    GiftCardDeleteModel? giftCardDeleteModel,
    GiftCardShareModel? giftCardShareModel,
    CardListModel? cardListModel,
    CardOrderTypeModel? cardOrderTypeModel,
    CardTypeModel? cardTypeModel,
    CardOderDetailsModel? cardOderDetailsModel,
    CardOrderConfirmModel? cardOrderConfirmModel,
    UserCardDetailsModel? userCardDetailsModel,
    CardSettingsModel? cardSettingsModel,
    CardActiveModel? cardActiveModel,
    CardBlockUnblockModel? cardBlockUnblockModel,
    CardReplaceModel? cardReplaceModel,
    CardIbanListModel? cardIbanListModel,
    CardTopUpFeeModel? cardTopUpFeeModel,
    CardTopUpConfirmModel? cardTopUpConfirmModel,
    TrxBiometricConfirmationNotificationsModel?
        trxBiometricConfirmationNotificationsModel,
    CardBeneficiaryListModel? cardBeneficiaryListModel,
    AddCardBeneficiaryModel? addCardBeneficiaryModel,
    DeleteCardBeneficiaryModel? deleteCardBeneficiaryModel,
    CardToCardTransferFeeModel? cardToCardTransferFeeModel,
    CardToCardTransferConfirmModel? cardToCardTransferConfirmModel,
    DownloadTransactionModel? downloadTransactionModel,
    TransactionApprovedModel? transactionApprovedModel,
    IbanCurrencyModel? ibanCurrencyModel,
    IbanKycCheckModel? ibanKycCheckModel,
  }) {
    return DashboardState(
      isloading: isloading,
      open: open,
      ibanlistModel: ibanlistModel,
      updateModel: updateModel,
      transactiondetailsmodel: transactiondetailsmodel,
      debitFees: debitFees,
      cardordermodel: cardordermodel,
      pdfmodel: pdfmodel,
      debitcardinfo: debitcardinfo ?? this.debitcardinfo,
      statusModel: statusModel,
      cardDetails: cardDetails ?? this.cardDetails,
      dashboardModel: dashboardModel ?? this.dashboardModel,
      giftCardListModel: giftCardListModel ?? this.giftCardListModel,
      giftCardGetFeeTypeModel:
          giftCardGetFeeTypeModel ?? this.giftCardGetFeeTypeModel,
      giftCardGetFeeDataModel:
          giftCardGetFeeDataModel ?? this.giftCardGetFeeDataModel,
      buyGiftCardConfirmModel:
          buyGiftCardConfirmModel ?? this.buyGiftCardConfirmModel,
      giftCardDetailsModel: giftCardDetailsModel ?? this.giftCardDetailsModel,
      giftCardDeleteModel: giftCardDeleteModel ?? this.giftCardDeleteModel,
      giftCardShareModel: giftCardShareModel,
      cardListModel: cardListModel ?? this.cardListModel,
      cardOrderTypeModel: cardOrderTypeModel ?? this.cardOrderTypeModel,
      cardTypeModel: cardTypeModel ?? this.cardTypeModel,
      cardOderDetailsModel: cardOderDetailsModel ?? this.cardOderDetailsModel,
      cardOrderConfirmModel:
          cardOrderConfirmModel ?? this.cardOrderConfirmModel,
      userCardDetailsModel: userCardDetailsModel ?? this.userCardDetailsModel,
      cardSettingsModel: cardSettingsModel ?? this.cardSettingsModel,
      cardActiveModel: cardActiveModel ?? this.cardActiveModel,
      cardBlockUnblockModel:
          cardBlockUnblockModel ?? this.cardBlockUnblockModel,
      cardReplaceModel: cardReplaceModel ?? this.cardReplaceModel,
      cardIbanListModel: cardIbanListModel ?? this.cardIbanListModel,
      cardTopUpFeeModel: cardTopUpFeeModel ?? this.cardTopUpFeeModel,
      cardTopUpConfirmModel:
          cardTopUpConfirmModel ?? this.cardTopUpConfirmModel,
      trxBiometricConfirmationNotificationsModel:
          trxBiometricConfirmationNotificationsModel ??
              this.trxBiometricConfirmationNotificationsModel,
      cardBeneficiaryListModel:
          cardBeneficiaryListModel ?? this.cardBeneficiaryListModel,
      addCardBeneficiaryModel:
          addCardBeneficiaryModel ?? this.addCardBeneficiaryModel,
      deleteCardBeneficiaryModel:
          deleteCardBeneficiaryModel ?? this.deleteCardBeneficiaryModel,
      cardToCardTransferFeeModel:
          cardToCardTransferFeeModel ?? this.cardToCardTransferFeeModel,
      cardToCardTransferConfirmModel:
          cardToCardTransferConfirmModel ?? this.cardToCardTransferConfirmModel,
      downloadTransactionModel:
          downloadTransactionModel ?? this.downloadTransactionModel,
      transactionApprovedModel:
          transactionApprovedModel ?? this.transactionApprovedModel,
      ibanCurrencyModel: ibanCurrencyModel ?? this.ibanCurrencyModel,
      ibanKycCheckModel: ibanKycCheckModel ?? this.ibanKycCheckModel,
    );
  }
}
