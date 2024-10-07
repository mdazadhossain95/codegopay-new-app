import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Profile_screen/bloc/profile_bloc.dart';
import 'package:codegopay/Screens/Profile_screen/change_password_otp_screen.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/assets.dart';
import '../../utils/input_fields/password_input_Field_widget.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/custom_image_widget.dart';
import '../../widgets/input_fields/password_input_field_with_title_widget.dart';

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
    return Scaffold(
      backgroundColor: CustomColor.notificationBgColor,
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
                      child: Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 30),
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: CustomImageWidget(
                                      imagePath: StaticAssets.arrowNarrowLeft,
                                      imageType: 'svg',
                                      height: 20,
                                    )),
                                Text(
                                  'Change Password',
                                  style: GoogleFonts.inter(
                                      color: CustomColor.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width: 20,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
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

                                    PasswordInputFieldWithTitleWidget(
                                      controller: _oldPasswordController,
                                      hint: 'Enter your old password',
                                      title: 'Old Password',
                                      // Title above the password field
                                      onChange: () {
                                      },
                                    ),
                                    PasswordInputFieldWithTitleWidget(
                                      controller: _newPasswordController,
                                      hint: 'Enter your new password',
                                      title: 'New Password',
                                      // Title above the password field
                                      onChange: () {
                                      },
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
                                    PasswordInputFieldWithTitleWidget(
                                      controller: _confirmPasswordController,
                                      hint: 'Re-enter your new password',
                                      title: 'Confirm Password',
                                      // Title above the password field
                                      onChange: () {
                                      },
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 30,
                            ),

                            PrimaryButtonWidget(
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
                              buttonText: 'Submit',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })));
  }
}
