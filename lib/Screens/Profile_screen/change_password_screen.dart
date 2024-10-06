import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Profile_screen/bloc/profile_bloc.dart';
import 'package:codegopay/Screens/Profile_screen/change_password_otp_screen.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../cutom_weidget/input_textform.dart';
import '../../utils/input_fields/password_input_Field_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _changePasswordFormKey = GlobalKey<FormState>();
  final ProfileBloc _profileBloc = ProfileBloc();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  FocusNode myFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    _changePasswordFormKey.currentState?.validate();
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
    User.Screen = 'Login';
    passwordFocusNode.addListener(() {
      setState(() {});
    });
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
                  bloc: _profileBloc,
                  listener: (context, ProfileState state) {
                    if (state.changePasswordModel?.status == 1) {
                      String requestId = state.changePasswordModel!.requestId!;
                      String message = state.changePasswordModel!.message!;
                      Navigator.push(
                        context,
                        PageTransition(
                          child: ChangePasswordOtpScreen(
                            requestId: requestId,
                            message: message,
                          ),
                          type: PageTransitionType.fade,
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 200),
                        ),
                      );
                    } else if (state.changePasswordModel?.status == 0) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        desc: state.changePasswordModel?.message,
                        btnCancelText: 'OK',
                        buttonsTextStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'pop',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        btnCancelOnPress: () {},
                      ).show();
                    }
                  },
                  child: BlocBuilder(
                      bloc: _profileBloc,
                      builder: (context, ProfileState state) {
                        return ProgressHUD(
                          inAsyncCall: state.isloading,
                          child: SafeArea(
                            bottom: false,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 40),
                                  child: ListView(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          alignment: Alignment.topLeft,
                                          child: Image.asset(
                                            'images/backarrow.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        'Change Password',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'pop',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff2C2C2C)),
                                      ),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Form(
                                          key: _changePasswordFormKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              PasswordInputFieldWidget(
                                                controller:
                                                    _oldPasswordController,
                                                label: "Old Password",
                                                hint: "Enter your old password",
                                                onChange: () {
                                                  // Your change handler logic here
                                                },
                                              ),
                                              PasswordInputFieldWidget(
                                                controller:
                                                    _newPasswordController,
                                                label: "New Password",
                                                hint: "Enter new your password",
                                                onChange: () {},
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "New Password cannot be empty";
                                                  } else if (value.length < 6) {
                                                    return "New Password must be at least 6 characters long";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              PasswordInputFieldWidget(
                                                controller:
                                                    _confirmPasswordController,
                                                label: "Confirm Password",
                                                hint:
                                                    "Re-enter your new password",
                                                onChange: () {},
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Confirm Password cannot be empty";
                                                  } else if (value !=
                                                      _newPasswordController
                                                          .text) {
                                                    return "Passwords do not match";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          )),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 60,
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11)),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (_changePasswordFormKey
                                                  .currentState!
                                                  .validate()) {
                                                _profileBloc.add(ChangePasswordEvent(
                                                    oldPassword:
                                                        _oldPasswordController
                                                            .text,
                                                    newPassword:
                                                        _newPasswordController
                                                            .text,
                                                    confirmPassword:
                                                        _confirmPasswordController
                                                            .text));
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff10245C),
                                                elevation: 0,
                                                disabledBackgroundColor:
                                                    const Color(0xffC4C4C4),
                                                shadowColor: Colors.transparent,
                                                minimumSize:
                                                    const Size.fromHeight(40),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11))),
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: 'pop',
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }))),
        ));
  }
}
