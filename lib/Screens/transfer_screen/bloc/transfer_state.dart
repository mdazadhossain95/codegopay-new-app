part of 'transfer_bloc.dart';

@immutable
class TransferState {
  SendmoneyModel? sendmoneyModel;
  PushModel? pushModel;
  bool? isloading;
  RegulaModel? regulaModel;

  BinficaryModel? binficaryModel;
  StatusModel? statusModel;
  IbanlistModel? ibanlistModel;

  Sepatypesmodel? sepatypesmodel;

  BeneficiaryCountriesModel? beneficiaryCountriesModel;

  TransferState(
      {this.isloading,
        this.ibanlistModel,
      this.regulaModel,
      this.pushModel,
      this.sepatypesmodel,
      this.binficaryModel,
      this.statusModel,
      this.sendmoneyModel,
      this.beneficiaryCountriesModel});

  factory TransferState.init() {
    return TransferState(
      isloading: false,
      regulaModel: RegulaModel(message: '', status: 222),
      ibanlistModel: IbanlistModel(ibaninfo: [], portbalance: '', status: 222),
      pushModel: PushModel(message: '', status: 222),
      sepatypesmodel:
          Sepatypesmodel(status: 222, types: Types(instant: '', sepa: '')),
      sendmoneyModel: SendmoneyModel(),
      beneficiaryCountriesModel: BeneficiaryCountriesModel(
          status: 222, message: '', beneficiaryCountriesList: []),
      binficaryModel: BinficaryModel(data: [], status: 222, message: ''),
      statusModel: StatusModel(message: '', status: 222),
    );
  }

  TransferState update({
    bool? isloading,
    IbanlistModel? ibanlistModel,
    BinficaryModel? binficaryModel,
    StatusModel? statusModel,
    PushModel? pushModel,
    RegulaModel? regulaModel,
    SendmoneyModel? sendmoneyModel,
    BeneficiaryCountriesModel? beneficiaryCountriesModel,
    Sepatypesmodel? sepatypesmodel,
  }) {
    return TransferState(
        isloading: isloading,
        binficaryModel: binficaryModel ?? this.binficaryModel,
        regulaModel: regulaModel,
        statusModel: statusModel,
        pushModel: pushModel,
        sendmoneyModel: sendmoneyModel,
        ibanlistModel: ibanlistModel ?? this.ibanlistModel,
        sepatypesmodel: sepatypesmodel ?? this.sepatypesmodel,
        beneficiaryCountriesModel:
            beneficiaryCountriesModel ?? this.beneficiaryCountriesModel);
  }
}
