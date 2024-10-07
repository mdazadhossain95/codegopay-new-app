// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Models/application.dart';
import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
import 'package:codegopay/Screens/Sign_up_screens/touchID_screen.dart';
import 'package:codegopay/Screens/login_screen/reset_password_screen.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/constant_string/constant_strings.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/location_serveci.dart';
import 'package:codegopay/utils/serves.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:codegopay/utils/validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/custom_style.dart';
import '../../utils/input_fields/custom_color.dart';
import '../../utils/input_fields/custom_pincode_input_field_widget.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../Dashboard_screen/bloc/dashboard_bloc.dart';
import 'forgot_password_face_verification_screen.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  ForgotPasswordOtpScreen(
      {super.key,
      required this.uniqueId,
      required this.userId,
      required this.message});

  String uniqueId, userId, message;

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final _formkey = new GlobalKey<FormState>();

  TextEditingController _pincontrol = TextEditingController();

  SignupBloc _signupBloc = new SignupBloc();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FocusNode focusNode = FocusNode();
  LocalAuthentication _localAuthentication = LocalAuthentication();

  String currunttext = '';

  // Userstates _userstates = new Userstates();

  getIsUsingBiometricAuth() async {
    String isBioMetric = await UserDataManager().getIsUsingBiometricAuth();

    if (isBioMetric == '1') {
      await _authorizeNow();
    }
  }

  getNewToken() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    UserDataManager().getPin().then((pin) {
      _signupBloc
          .add(GetUserPinEvent(userpin: pin, version: packageInfo.version));
    });
  }

  void firebaseCloudMessaging_Listeners(BuildContext context) {
    iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      User.deviceToken = token;
      print("_123firebaseMessaging.getToken:  " + token!);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        print('on Lunch');

        if (message.notification != null) {
          if (message.data['category'] == 'current-location') {
            if (await Permission.location.isGranted) {
              Locationservece().getCurrentLocation();
            }
          }

          // User.notification=1;
          // User.remoteMessage= message;
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // if(message.notification != null)
      //           {
      //             User.notification=1;
      //             User.remoteMessage= message;
      //           }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('dashboard screen on onResume $message');

      if (message.notification != null) {
        if (message.data['category'] == 'current-location') {
          if (await Permission.location.isGranted) {
            Locationservece().getCurrentLocation();
          }
        }

        // User.notification=1;
        // User.remoteMessage= message;
      }
    });

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  void iOS_Permission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true, badge: true, sound: true);

    print("123Settings registered: ${settings.authorizationStatus}");
  }

  // Map modifyIosJson(Map<String, dynamic> message) {
  //   message['data'] = Map.from(message);
  //   message['notification'] = message['aps']['alert'];
  //
  //   return message;
  // }
  bool completed = false;

  Future<void> _authorizeNow() async {
    final canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    FocusScope.of(context).requestFocus(new FocusNode());

    if (canCheckBiometrics) {
      List<BiometricType> availableBiometricTypes =
          await _localAuthentication.getAvailableBiometrics();

      if (Platform.isIOS) {
        print("ABABA **************** iOS");

        if (availableBiometricTypes.contains(BiometricType.face)) {
          final isAuthenticated = await _localAuthentication.authenticate(
              localizedReason: ConstantStrings.SCAN_TOUCH_ID,
              options: const AuthenticationOptions(
                  stickyAuth: true, useErrorDialogs: true));

          if (isAuthenticated) {
            getNewToken();

            print("store data in storage");
          } else {
            print("Not authenticated");
          }
          // Face ID.
        } else if (availableBiometricTypes
            .contains(BiometricType.fingerprint)) {
          final isAuthenticated = await _localAuthentication.authenticate(
              localizedReason: ConstantStrings.SCAN_TOUCH_ID,
              options: const AuthenticationOptions(
                  stickyAuth: true, useErrorDialogs: true));

          if (isAuthenticated) {
            getNewToken();
          } else {
            print("Not authenticated");
          }

          // Touch ID.
        }
      } else if (Platform.isAndroid) {
        print("ABABA **************** Android");

        if (availableBiometricTypes.contains(BiometricType.strong)) {
          final isAuthenticated = await _localAuthentication.authenticate(
              localizedReason: ConstantStrings.SCAN_TOUCH_ID,
              options: const AuthenticationOptions(
                  stickyAuth: true, useErrorDialogs: true));

          if (isAuthenticated) {
            getNewToken();
          } else {
            print("Not authenticated");
          }
          // Face ID.
        } else if (availableBiometricTypes
            .contains(BiometricType.fingerprint)) {
          final isAuthenticated = await _localAuthentication.authenticate(
              localizedReason: ConstantStrings.SCAN_TOUCH_ID,
              options: const AuthenticationOptions(
                  stickyAuth: true, useErrorDialogs: true));

          if (isAuthenticated) {
            getNewToken();
          } else {
            print("Not authenticated");
          }
          // Touch ID.
        }
      }
    }
  }

  @override
  void initState() {
    firebaseCloudMessaging_Listeners(context);

    super.initState();
    UserDataManager().clearUserIbanData();
    // _userstates.getuserstatus();
    User.Screen = "Getpin";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.scaffoldBg,
        resizeToAvoidBottomInset: false,
        body: BlocListener(
            bloc: _signupBloc,
            listener: (context, SignupState state) {
              if (state.forgotPasswordOtpModel?.status == 0) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  dismissOnTouchOutside: true,
                  desc: state.forgotPasswordOtpModel?.message,
                  btnCancelText: 'OK',
                  buttonsTextStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'pop',
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  btnCancelOnPress: () {
                    Navigator.pop(context);
                  },
                ).show();
              }

              if (state.forgotPasswordOtpModel?.isBiometric == 1) {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ForgotPasswordFaceVerificationScreen(
                      userId: widget.userId,
                      message: state.forgotPasswordOtpModel!.message!,
                      profileImage:
                          state.forgotPasswordOtpModel!.profileimage!,
                    ),
                    type: PageTransitionType.fade,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 200),
                  ),
                );
              } else  if (state.forgotPasswordOtpModel?.isBiometric == 0) {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ResetPasswordScreen(
                      userId: widget.userId,
                      message: state.forgotPasswordOtpModel!.message!,
                    ),
                    type: PageTransitionType.fade,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 200),
                  ),
                );
              }
            },
            child: BlocBuilder(
                bloc: _signupBloc,
                builder: (context, SignupState state) {
                  return SafeArea(
                    child: ProgressHUD(
                      inAsyncCall: state.isloading,
                      child: Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 40),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      DefaultBackButtonWidget(onTap: () {
                                        Navigator.pop(context);
                                      }),
                                      Container()
                                    ],
                                  ),
                                  const SizedBox(height: 50),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Get Your Code?',
                                      style:
                                      CustomStyle.loginVerifyTitleTextStyle,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),

                                  Form(
                                      key: _formkey,
                                      child: CustomPinCodeInputFieldWidget(
                                        appContext: context,
                                        controller: _pincontrol,
                                        onCompleted: (value) {
                                          setState(() {
                                            completed = true;
                                          });
                                          debugPrint('Completed: $value');
                                        },
                                        validator: (value) {
                                          return Validator.validateValues(
                                              value:
                                              value!); // Replace with your validation logic
                                        },
                                      )),

                                  Container(
                                    alignment: Alignment.center,
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 30),
                                    child: Text(
                                      widget.message,
                                      textAlign: TextAlign.center,
                                      style:
                                      CustomStyle.setPinSubTitleTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            PrimaryButtonWidget(
                              onPressed: completed
                                  ? () {
                                if (_formkey.currentState!
                                    .validate()) {
                                  _signupBloc.add(
                                      ForgotPasswordOtpEvent(
                                          uniqueId: widget.uniqueId,
                                          userId: widget.userId,
                                          code: _pincontrol.text));
                                }
                              }
                                  : null,
                              buttonText:  'Verify OTP',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })));
  }
}

Future myBackgroundMessageHandler(RemoteMessage message) async {
  if (message.data != null) {
    // Handle data message
    print('get pin screen on myBackgroundMessageHandler   $message');
    final dynamic data = message.data;
    if (message.data['category'] == 'current-location') {
      if (await Permission.location.isGranted) {
        Locationservece().getCurrentLocation();
      }
    }

    // User.notification=1;
    // User.remoteMessage= message;
  }

  if (message.notification != null) {
    // Handle notification message
    print('get pin on myBackgroundMessageHandler   $message');
    final dynamic notification = message.notification;

    if (message.data['category'] == 'current-location') {
      if (await Permission.location.isGranted) {
        Locationservece().getCurrentLocation();
      }
    }
  }

  // Or do other work.
}
