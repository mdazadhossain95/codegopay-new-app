part of 'profile_bloc.dart';

class ProfileState {
  bool? isloading;

  StatusModel? statusModel;
  LogoutModel? logoutModel;

  ProfileModel? profileModel;
  ChangePasswordModel? changePasswordModel;

  ProfileState(
      {this.profileModel,
      this.isloading,
      this.statusModel,
      this.logoutModel,
      this.changePasswordModel});

  factory ProfileState.init() {
    return ProfileState(
      isloading: false,
      profileModel: ProfileModel(
          accountStatus: '',
          address: '',
          balance: '',
          bic: '',
          city: '',
          countryName: '',
          planName: '',
          contactUs: '',
          currency: '',
          email: '',
          helpFaq: '',
          iban: '',
          name: '',
          planurl: '',
          profileimage:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRp0xKoXUryp0JZ1Sxp-99eQiQcFrmA1M1qbQ&usqp=CAU',
          risk: '',
          status: 222,
          surname: '',
          upgradePlan: 222,
          sof: Sof(sourceOfWealthMsg: "", label: "", sourceOfWealth: 0)),
      statusModel: StatusModel(message: '', status: 222),
      logoutModel: LogoutModel(status: 222, message: ""),
      changePasswordModel: ChangePasswordModel(status: 222, message: "", requestId: ""),
    );
  }

  ProfileState update({
    ProfileModel? profileModel,
    bool? isloading,
    StatusModel? statusModel,
    LogoutModel? logoutModel,
    ChangePasswordModel? changePasswordModel,
  }) {
    return ProfileState(
        isloading: isloading,
        statusModel: statusModel,
        logoutModel: logoutModel,
        changePasswordModel: changePasswordModel ?? this.changePasswordModel,
        profileModel: profileModel ?? this.profileModel);
  }
}
