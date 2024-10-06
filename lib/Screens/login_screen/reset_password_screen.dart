import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/input_fields/password_input_Field_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key, required this.userId, required this.message});

  String userId;
  String message;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  final SignupBloc _signupBloc = SignupBloc();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
    User.Screen = 'Login';
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true, // Important for handling keyboard
          body: BlocListener(
            bloc: _signupBloc,
            listener: (context, SignupState state) {
              // Handle different states based on your loginResponse
              if (state.statusModel?.status == 0) {
                AwesomeDialog(
                  context: context,
                  dismissOnTouchOutside: true,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  desc: state.statusModel?.message,
                  btnCancelText: 'ok',
                  buttonsTextStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'pop',
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  btnCancelOnPress: () {},
                ).show();
              }

              if (state.statusModel?.status == 1) {
                AwesomeDialog(
                  context: context,
                  dismissOnTouchOutside: false,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  desc: state.statusModel?.message,
                  btnCancelText: 'ok',
                  btnCancelColor: Colors.green,
                  buttonsTextStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'pop',
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  btnCancelOnPress: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', (route) => false);
                  },
                ).show();
              }
            },
            child: BlocBuilder(
              bloc: _signupBloc,
              builder: (context, SignupState state) {
                return ProgressHUD(
                  inAsyncCall: state.isloading,
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 40),
                      child: ListView(
                        // reverse: true,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'login', (route) => false);
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'images/applogo.png',
                              height: 150,
                            ),
                          ),
                          // const SizedBox(height: 100),
                          const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'pop',
                              fontWeight: FontWeight.w500,
                              color: Color(0xff2C2C2C),
                            ),
                          ),
                          const Text(
                            'your identity has been verified set your new password',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'pop',
                              fontWeight: FontWeight.w500,
                              color: Color(0xff2C2C2C),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Form(
                            key: _forgotPasswordFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PasswordInputFieldWidget(
                                  controller: _password,
                                  label: "Password",
                                  hint: "Enter your password",
                                  onChange: () {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be empty";
                                    } else if (value.length < 6) {
                                      return "Password must be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                ),
                                PasswordInputFieldWidget(
                                  controller: _confirmPassword,
                                  label: "Confirm Password",
                                  hint: "Re-enter your password",
                                  onChange: () {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Confirm Password cannot be empty";
                                    } else if (value != _password.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_forgotPasswordFormKey.currentState!
                                    .validate()) {
                                  // Add your forgot password logic here

                                  _signupBloc.add(ResetPasswordEvent(
                                      userId: widget.userId,
                                      password: _password.text,
                                      confirmPassword: _confirmPassword.text));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff10245C),
                                elevation: 0,
                                disabledBackgroundColor:
                                    const Color(0xffC4C4C4),
                                shadowColor: Colors.transparent,
                                minimumSize: const Size.fromHeight(40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'pop',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 200),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
