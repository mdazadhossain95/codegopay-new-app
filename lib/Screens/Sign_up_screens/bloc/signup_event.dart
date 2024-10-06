part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class sendemailotpEvent extends SignupEvent {
  String email;

  sendemailotpEvent({required this.email});
}

class otpVerifyEvent extends SignupEvent {
  String otp, email, deviceType;

  otpVerifyEvent(
      {required this.otp, required this.email, required this.deviceType});
}

class incomesourceEvent extends SignupEvent {
  incomesourceEvent();
}

class SourcefundEvent extends SignupEvent {
  SourcefundEvent();
}

class resendotpVerifyEvent extends SignupEvent {
  resendotpVerifyEvent();
}

class getCurruncyEvent extends SignupEvent {
  getCurruncyEvent();
}

class SignupPersonalDataEvent extends SignupEvent {
  SignupPersonalDataEvent();
}

class addProfileEvent extends SignupEvent {
  String photo;

  addProfileEvent({required this.photo});
}

class UpdatesourceEvent extends SignupEvent {
  String? photo, source, occupation, signature;

  UpdatesourceEvent(
      {required this.photo, this.occupation, this.source, this.signature});
}

class SendkyclinkEvent extends SignupEvent {
  SendkyclinkEvent();
}

class GetplanlistEvent extends SignupEvent {
  GetplanlistEvent();
}

class PlanLinkEvent extends SignupEvent {
  PlanLinkEvent();
}

class UpgradeplanEvent extends SignupEvent {
  String? uniqueid;

  UpgradeplanEvent({this.uniqueid});
}

class uploadidphotosEvent extends SignupEvent {
  String front, back;

  uploadidphotosEvent({required this.front, required this.back});
}

class uploadpassportphotosEvent extends SignupEvent {
  String front;

  uploadpassportphotosEvent({required this.front});
}

class uploadproffadressEvent extends SignupEvent {
  String front;

  uploadproffadressEvent({required this.front});
}

class setPinEvent extends SignupEvent {
  String pin;

  setPinEvent({required this.pin});
}

class getstripekeyspuublic extends SignupEvent {
  getstripekeyspuublic();
}

class GetUserPinEvent extends SignupEvent {
  String userpin, version;

  GetUserPinEvent({required this.userpin, required this.version});
}

class siginInEvent extends SignupEvent {
  String email, password, devictype, seonSession;

  siginInEvent(
      {required this.email,
      required this.password,
      required this.devictype,
      required this.seonSession});
}

class LoginRequestVerifyEvent extends SignupEvent {
  String token, verificationCode, userId;

  LoginRequestVerifyEvent({
    required this.token,
    required this.verificationCode,
    required this.userId,
  });
}

//kyc section

class KycStatusCheckEvent extends SignupEvent {}

class KycGetUserStatusEvent extends SignupEvent {}

class KycCreateEvent extends SignupEvent {}

class KycDocumentTypeEvent extends SignupEvent {}

class KycIdVerifyEvent extends SignupEvent {}

class KycAddressVerifyEvent extends SignupEvent {
  KycAddressVerifyEvent();
}

class KycGetUserImageEvent extends SignupEvent {}

class KycFaceVerifyEvent extends SignupEvent {
  String image;
  KycFaceVerifyEvent({required this.image});
}

class KycSubmitEvent extends SignupEvent {}

/*🚧🚧🚧🚧new signup section with seon & sumsub🚧🚧🚧🚧*/

class UserSignupEvent extends SignupEvent {
  String name, surname, email, password, devictype, seonSession;

  UserSignupEvent(
      {required this.name,
      required this.surname,
      required this.email,
      required this.password,
      required this.devictype,
      required this.seonSession});
}

class RefreshSumSubTokenEvent extends SignupEvent {}

class LoginBioStatusEvent extends SignupEvent {
  String userId, status;

  LoginBioStatusEvent({
    required this.userId,
    required this.status,
  });
}

class UserKycCheckStatusEvent extends SignupEvent {}

/*forgot password section*/
class ForgotPasswordEvent extends SignupEvent {
  String email;

  ForgotPasswordEvent({required this.email});
}

class ForgotPasswordOtpEvent extends SignupEvent {
  String uniqueId, userId, code;

  ForgotPasswordOtpEvent(
      {required this.uniqueId, required this.userId, required this.code});
}

class ForgotPasswordBiometricEvent extends SignupEvent {
  String userId, status;

  ForgotPasswordBiometricEvent({required this.userId, required this.status});
}

class ResetPasswordEvent extends SignupEvent {
  String userId, password, confirmPassword;

  ResetPasswordEvent(
      {required this.userId,
      required this.password,
      required this.confirmPassword});
}
