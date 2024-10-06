part of 'transfer_bloc.dart';

@immutable
class TransferEvent {}

class binficarylistEvent extends TransferEvent {}

class AddExternalbenficaryEvent extends TransferEvent {
  String? firstname, lastname, bic, image, email, iban, companyname, type;

  AddExternalbenficaryEvent(
      {this.email,
      this.iban,
      this.image,
      this.firstname,
      this.bic,
      this.lastname,
      this.companyname,
      this.type});
}

class SendmoneyEvent extends TransferEvent {
  String? refrence, uniquid, amount, paymentoption, iban;

  SendmoneyEvent(
      {this.amount, this.refrence, this.uniquid, this.paymentoption, this.iban});
}

class SwipconfirmEvent extends TransferEvent {
  String? unique_id;

  SwipconfirmEvent({this.unique_id});
}

class DeleteBeneficiaryEvent extends TransferEvent {
  String? uniqueId;

  DeleteBeneficiaryEvent({this.uniqueId});
}

class ApproveibanTransactionEvent extends TransferEvent {
  String completed, lat, long, uniqueId;

  ApproveibanTransactionEvent(
      {required this.completed, required this.lat, required this.long, required this.uniqueId});
}

class SepatypesEvent extends TransferEvent {}

class RegulaupdateBiometric extends TransferEvent {
  String? facematch, kycid, userimage;

  RegulaupdateBiometric({this.facematch, this.kycid, this.userimage});
}

class getibanlistEvent extends TransferEvent {
  getibanlistEvent();
}
