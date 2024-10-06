part of 'dashboard_bloc.dart';

@immutable
class DashboardEvent {}

class DashboarddataEvent extends DashboardEvent {}

class opendialog extends DashboardEvent {
  bool? open;

  opendialog({this.open});
}

class ShareibanEvent extends DashboardEvent {
  String? email, iban;

  ShareibanEvent({this.email, this.iban});
}

class closenotificationEvent extends DashboardEvent {
  String? notifId;

  closenotificationEvent({this.notifId});
}

class OrdercardEvent extends DashboardEvent {
  String? type;

  OrdercardEvent({this.type});
}

class confirmdebitorder extends DashboardEvent {}

class debitcardfees extends DashboardEvent {
  String? type;

  debitcardfees({this.type});
}

class activateDebitwithcodeEvent extends DashboardEvent {
  String? lastdigit, code;

  activateDebitwithcodeEvent({this.lastdigit, this.code});
}

class ActivateDebutcardEvent extends DashboardEvent {
  String? cardnumber, mm, yy, cvv;

  ActivateDebutcardEvent({this.cardnumber, this.mm, this.yy, this.cvv});
}

class DebitcarddetailsEvent extends DashboardEvent {}

class debitcardinfoevent extends DashboardEvent {
  String? cardid, pin;

  debitcardinfoevent({this.cardid, this.pin});
}

class transactiondetailsEvent extends DashboardEvent {
  String? uniqueId;

  transactiondetailsEvent({this.uniqueId});
}

class DawnloadEvent extends DashboardEvent {
  String? uniqueId;

  DawnloadEvent({this.uniqueId});
}

class ResetCardPinEvent extends DashboardEvent {
  String? cardPin, cardId;

  ResetCardPinEvent({this.cardPin, this.cardId});
}

class UpdateCardSettingEvent extends DashboardEvent {
  String? cardId, settingName, settingValue;

  UpdateCardSettingEvent({
    this.cardId,
    this.settingName,
    this.settingValue,
  });
}

class Movebalancetodebit extends DashboardEvent {
  String? amount, ibanid;

  Movebalancetodebit({this.amount, this.ibanid});
}

class checkcardEvent extends DashboardEvent {}

class ApproveMoveWalletsEvent extends DashboardEvent {
  String? uniqueId, completed;

  ApproveMoveWalletsEvent({
    this.uniqueId,
    this.completed,
  });
}

class ApproveTransactionEvent extends DashboardEvent {
  String? uniqueId, completed;

  ApproveTransactionEvent({
    this.uniqueId,
    this.completed,
  });
}

class ApproveEurotoIbanEvent extends DashboardEvent {
  String? uniqueId, completed;

  ApproveEurotoIbanEvent({
    this.uniqueId,
    this.completed,
  });
}

class ApproveEurotoCryptoEvent extends DashboardEvent {
  String? uniqueId, completed;

  ApproveEurotoCryptoEvent({
    this.uniqueId,
    this.completed,
  });
}

class ApproveBrowserLoginEvent extends DashboardEvent {
  String? uniqueId;
  int? loginStatus;

  ApproveBrowserLoginEvent({this.uniqueId, this.loginStatus});
}

class TrxBiometricDetailsEvent extends DashboardEvent {
  String? uniqueId;

  TrxBiometricDetailsEvent({this.uniqueId});
}

class TrxBiometricConfirmOrCancelEvent extends DashboardEvent {
  String? uniqueId;
  String? loginStatus;

  TrxBiometricConfirmOrCancelEvent({this.uniqueId, this.loginStatus});
}

class checkupdate extends DashboardEvent {}

//gift card section

class GiftCardListEvent extends DashboardEvent {}

class GiftCardGetFeeTypeEvent extends DashboardEvent {}

class GiftCardGetFeeDataEvent extends DashboardEvent {
  String amount;
  GiftCardGetFeeDataEvent({required this.amount});
}

class GiftCardGetOrderConfirmEvent extends DashboardEvent {}

class GiftCardGetDetailsEvent extends DashboardEvent {}

class GiftCardDeleteEvent extends DashboardEvent {}

class GiftCardShareEvent extends DashboardEvent {}

//card section

class CardListEvent extends DashboardEvent {}

class CardOrderTypeEvent extends DashboardEvent {}

class CardTypeEvent extends DashboardEvent {}

class CardGetTypeEvent extends DashboardEvent {}

class CardFeeEvent extends DashboardEvent {}

class CardOrderConfirmEvent extends DashboardEvent {}

class CardDetailsEvent extends DashboardEvent {}

class CardActiveEvent extends DashboardEvent {}

class CardSettingsEvent extends DashboardEvent {}

class CardBlockUnblockEvent extends DashboardEvent {}

class CardReplaceEvent extends DashboardEvent {}

class CardIbanListEvent extends DashboardEvent {}

class CardTopupAmountEvent extends DashboardEvent {}

class CardTopupConfirmEvent extends DashboardEvent {}

//virtual card section

class CardBeneficiaryListEvent extends DashboardEvent {}

class AddCardBeneficiaryEvent extends DashboardEvent {}

class DeleteCardBeneficiaryEvent extends DashboardEvent {}

class CardToCardTransferFeesEvent extends DashboardEvent {}

class CardToCardTransferConfirmEvent extends DashboardEvent {}

class DownloadTransactionStatementEvent extends DashboardEvent {}

//iban
class getibanlistEvent extends DashboardEvent {
  getibanlistEvent();
}

class CreateibanEvent extends DashboardEvent {
  String? Label, currency, iban;

  CreateibanEvent({this.Label, this.currency, this.iban});
}

class GetIbanCurrencyEvent extends DashboardEvent {}


class IbanSumSubVerified extends DashboardEvent {
  String? currency, iban;

  IbanSumSubVerified({this.currency, this.iban});
}