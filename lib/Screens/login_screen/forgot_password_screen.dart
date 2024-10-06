import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../cutom_weidget/input_textform.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  final SignupBloc _signupBloc = SignupBloc();
  final TextEditingController _emailController = TextEditingController();
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

              if (state.forgotPasswordModel?.status == 0) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  dismissOnTouchOutside: true,
                  desc: state.forgotPasswordModel?.message,
                  btnCancelText: 'OK',
                  buttonsTextStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'pop',
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  btnCancelOnPress: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'forgotPasswordScreen', (route) => false);
                  },
                ).show();
              }

              if (state.forgotPasswordModel?.status == 1) {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ForgotPasswordOtpScreen(
                      uniqueId: state.forgotPasswordModel!.uniqueId!,
                      userId: state.forgotPasswordModel!.userId!,
                      message: state.forgotPasswordModel!.message!,
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
                return ProgressHUD(
                  inAsyncCall: state.isloading,
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 40),
                      child: ListView(
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
                          const SizedBox(height: 15),
                          Image.asset(
                            'images/forgot-password.png',
                            height: 300,
                          ),
                          const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'pop',
                              fontWeight: FontWeight.w500,
                              color: Color(0xff2C2C2C),
                            ),
                          ),
                          const Text(
                            'Don\'t worry, it happens. We\'ll help you get back into your account. Please enter your email address below.',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'pop',
                              fontWeight: FontWeight.w500,
                              color: Color(0xff2C2C2C),
                            ),
                          ),
                          const SizedBox(height: 22),
                          Form(
                            key: _forgotPasswordFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InputTextCustom(
                                  controller: _emailController,
                                  hint: 'Enter your email id',
                                  label: 'Email account',
                                  isEmail: true,
                                  isPassword: false,
                                  onChanged: () {},
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
                                  _signupBloc.add(ForgotPasswordEvent(
                                      email: _emailController.text));
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
                                'Submit',
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
