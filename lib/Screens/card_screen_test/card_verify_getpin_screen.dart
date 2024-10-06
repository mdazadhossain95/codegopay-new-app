// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Models/application.dart';
import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
import 'package:codegopay/Screens/Sign_up_screens/touchID_screen.dart';
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
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CardVerifyGetPinScreen extends StatefulWidget {
  const CardVerifyGetPinScreen({super.key});

  @override
  State<CardVerifyGetPinScreen> createState() => _CardVerifyGetPinScreenState();
}

class _CardVerifyGetPinScreenState extends State<CardVerifyGetPinScreen> {
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
    // _userstates.getuserstatus();
    User.Screen = "cardVerifyGetPinScreen";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: BlocListener(
                  bloc: _signupBloc,
                  listener: (context, SignupState state) {
                    debugPrint(
                        "------------------------------------testing ap-------------------");
                    debugPrint(state.userGetPinModel?.status.toString());
                    debugPrint(
                        "------------------------------------testing ap-------------------");
                    if (state.userGetPinModel?.status == 1) {
                      User.isIban = state.userGetPinModel?.isIban;
                      User.hidepage = state.userGetPinModel!.hidepage!;
                      debugPrint(
                          "------------------------------------testing ap-------------------");
                      // debugPrint(_userstates.user.toString());
                      debugPrint(
                          "------------------------------------testing ap-------------------");
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, 'debitCardScreen', (route) => false);
                      Navigator.of(context).pop(true);
                    } else if (state.userGetPinModel?.status == 0) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        desc: state.userGetPinModel?.message,
                        btnCancelText: 'OK',
                        buttonsTextStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'pop',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        btnCancelOnPress: () {},
                      ).show();
                    }
                    // TODO: implement listener
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
                                  left: 25, right: 25, top: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Enter 4-digit Pin',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'pop',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff2C2C2C)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Form(
                                      key: _formkey,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: PinCodeTextField(
                                          appContext: context,
                                          pastedTextStyle: const TextStyle(
                                              color: Color(0xff090B78),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              fontFamily: 'pop'),
                                          length: 4,
                                          obscureText: true,
                                          textStyle: const TextStyle(
                                              color: Color(0xff090B78),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              fontFamily: 'pop'),

                                          blinkWhenObscuring: true,
                                          backgroundColor: Colors.transparent,

                                          animationType: AnimationType.fade,
                                          autoUnfocus: true,
                                          autoFocus: true,
                                          validator: (value) {
                                            return Validator.validateValues(
                                              value: value!,
                                            );
                                          },
                                          pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            disabledColor: Colors.transparent,
                                            activeColor:
                                                const Color(0xff090B78),
                                            selectedColor:
                                                const Color(0xff090B78),
                                            inactiveColor:
                                                const Color(0xff090B78),
                                            inactiveFillColor:
                                                Colors.transparent,
                                            selectedFillColor:
                                                Colors.transparent,
                                            fieldOuterPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4),
                                            borderWidth: 1,
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            fieldHeight: 43,
                                            fieldWidth: 43,
                                            activeFillColor: Colors.transparent,
                                          ),
                                          cursorColor: Colors.white,
                                          animationDuration:
                                              const Duration(milliseconds: 300),
                                          enableActiveFill: true,
                                          controller: _pincontrol,
                                          keyboardType: TextInputType.number,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,

                                          onCompleted: (v) async {
                                            debugPrint("Completed");
                                            PackageInfo packageInfo =
                                                await PackageInfo
                                                    .fromPlatform();

                                            String showNumber =
                                                await UserDataManager()
                                                    .getCardNumberShow();

                                            showNumber == "false"
                                                ? UserDataManager()
                                                    .cardNumberShowSave("true")
                                                : UserDataManager()
                                                    .cardNumberShowSave(
                                                        "false");

                                            _signupBloc.add(GetUserPinEvent(
                                                userpin: _pincontrol.text,
                                                version: packageInfo.version));
                                          },
                                          // onTap: () {
                                          //   print("Pressed");
                                          // },
                                          onChanged: (value) {},
                                          enablePinAutofill: false,
                                          errorTextMargin:
                                              const EdgeInsets.only(top: 10),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 72,
                                  ),
                                  Application.isBiometricsSupported
                                      ? InkWell(
                                          onTap: () {
                                            Application.isBioMetric == '1'
                                                ? getIsUsingBiometricAuth()
                                                : UserDataManager()
                                                    .getPin()
                                                    .then(
                                                        (pin) => Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TouchidScreen(
                                                                  userPin: pin,
                                                                ),
                                                              ),
                                                            ));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              'images/fingerprint.png',
                                              width: 46,
                                              height: 46,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Application.isBiometricsSupported
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Use Finger Print or Face ID',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'pop',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff2C2C2C)),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        );
                      }))),
        ));
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
