import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Config/bloc/app_bloc.dart';
import '../../../Config/bloc/app_respotary.dart';
import '../../utils/custom_style.dart';
import '../../utils/input_fields/custom_color.dart';
import '../../utils/input_fields/custom_pincode_input_field_widget.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons/custom_icon_button_widget.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import 'bloc/profile_bloc.dart';

class ChangePasswordOtpScreen extends StatefulWidget {
  ChangePasswordOtpScreen(
      {super.key, required this.message, required this.requestId});

  String message;
  String requestId;

  @override
  State<ChangePasswordOtpScreen> createState() =>
      _ChangePasswordOtpScreenState();
}

class _ChangePasswordOtpScreenState extends State<ChangePasswordOtpScreen> {
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _pinControl = TextEditingController();

  bool completed = false;
  final ProfileBloc _profileBloc = ProfileBloc();

  AppRespo appRepo = AppRespo();
  final AppBloc _appBloc = AppBloc();

  @override
  void initState() {
    appRepo.getUserStatus();
    _appBloc.add(UserstatusEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _profileBloc,
        listener: (context, ProfileState state) {
          if (state.statusModel?.status == 0) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              desc: state.statusModel?.message,
              btnCancelText: 'OK',
              buttonsTextStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'pop',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              btnCancelOnPress: () {},
            ).show();
          } else if (state.statusModel?.status == 1) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              dismissOnTouchOutside: false,
              desc: state.statusModel?.message,
              btnCancelText: 'OK',
              btnCancelColor: Colors.green,
              buttonsTextStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'pop',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              btnCancelOnPress: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'dashboard', (route) => false);
              },
            ).show();
          }
        },
        child: Scaffold(
          backgroundColor: CustomColor.scaffoldBg,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            bottom: false,
            child: BlocBuilder(
                bloc: _profileBloc,
                builder: (context, ProfileState state) {
                  return ProgressHUD(
                    inAsyncCall: state.isloading,
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      padding:
                      const EdgeInsets.only(left: 16, right: 16, top: 30),
                      child: Column(
                        children: [

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                    Container(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "What's the code?",
                                    style:
                                    CustomStyle.loginVerifyTitleTextStyle,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),

                                Form(
                                    key: _formKey,
                                    child: CustomPinCodeInputFieldWidget(
                                      appContext: context,
                                      controller: _pinControl,
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
                                const SizedBox(
                                  height: 72,
                                ),
                              ],
                            ),
                          ),

                          PrimaryButtonWidget(
                            onPressed: completed
                                ? () {
                              if (_formKey.currentState!.validate()) {
                                _profileBloc.add(
                                    ChangePasswordOtpEvent(
                                        requestId: widget.requestId,
                                        otp: _pinControl.text));
                              }
                            }
                                : null,
                            buttonText: 'Verify',
                          ),

                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ));
  }
}
