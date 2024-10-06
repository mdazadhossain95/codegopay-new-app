import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/input_textform.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/base_model.dart';
import '../../../cutom_weidget/cutom_progress_bar.dart';
import '../../../cutom_weidget/select_funds.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/input_fields/custom_color.dart';
import '../../../utils/input_fields/tax_country_selector_widget.dart';
import '../../../utils/strings.dart';
import '../../../widgets/buttons/default_back_button_widget.dart';
import '../../../widgets/buttons/primary_button_widget.dart';
import '../bloc/signup_bloc.dart';

class SignupUserInfoPage3Screen extends StatefulWidget {
  const SignupUserInfoPage3Screen({super.key});

  @override
  State<SignupUserInfoPage3Screen> createState() =>
      _SignupUserInfoPage3ScreenState();
}

class _SignupUserInfoPage3ScreenState extends State<SignupUserInfoPage3Screen> {
  final _signupUserInfoPage3Key = GlobalKey<FormState>();

  final TextEditingController _taxCountry = TextEditingController();
  final TextEditingController _taxNumberController = TextEditingController();
  final TextEditingController _sourceOfFundsController =
      TextEditingController();
  final TextEditingController _purposeOfAccountController =
      TextEditingController();

  bool active = false;

  final SignupBloc _signupBloc = SignupBloc();

  @override
  void initState() {
    _signupUserInfoPage3Key.currentState?.validate();
    super.initState();

    _signupBloc.add(incomesourceEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      resizeToAvoidBottomInset: true,
      body: BlocListener(
        bloc: _signupBloc,
        listener: (context, SignupState state) {
          if (state.signUpResponseModel?.status == 1) {
            UserDataManager().statusMessageSave(
                state.signUpResponseModel!.message.toString());

            Navigator.pushNamedAndRemoveUntil(
                context, 'kycWelcomeScreen', (route) => false);
          } else if (state.signUpResponseModel?.status == 0) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              desc: state.signUpResponseModel?.message,
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
            bloc: _signupBloc,
            builder: (context, SignupState state) {
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: ProgressHUD(
                  inAsyncCall: state.isloading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultBackButtonWidget(onTap: () {
                            Navigator.pop(context);
                          }),
                          Text("Step 3/3",
                              style: CustomStyle.loginSubTitleStyle)
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        Strings.signUpTitleStep3,
                        style: CustomStyle.loginTitleStyle,
                      ),
                      Text(Strings.signUpSubTitleStep3,
                          style: CustomStyle.loginSubTitleStyle),
                      Form(
                          key: _signupUserInfoPage3Key,
                          child: Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                TextCountrySelectorWidget(
                                  controller: _taxCountry,
                                  hint: 'Select Country',
                                  label: 'Country',
                                  nationality: true,
                                  listitems: BaseModel.availableCountriesList,
                                  selectString: 'Select Country',
                                ),
                                InputTextCustom(
                                    controller: _taxNumberController,
                                    hint: 'Tax Number',
                                    label:
                                        'Tax number (If you don\'t have write "N/A")',
                                    isEmail: false,
                                    isPassword: false,
                                    onChanged: () {
                                      if (_signupUserInfoPage3Key.currentState!
                                          .validate()) {
                                        setState(() {
                                          active = true;
                                        });
                                      }
                                    }),
                                InputSelectFunds(
                                  controller: _sourceOfFundsController,
                                  hint: 'Source of funds',
                                  label: 'Source of funds',
                                  listItems: state.incomeModel!.incomeSource!,
                                  selectString: 'Source of funds',
                                ),
                                InputTextCustom(
                                    controller: _purposeOfAccountController,
                                    hint: 'Why you opening this account ?',
                                    label: 'purpose of account',
                                    isEmail: false,
                                    isPassword: false,
                                    onChanged: () {
                                      if (_signupUserInfoPage3Key.currentState!
                                          .validate()) {
                                        setState(() {
                                          active = true;
                                        });
                                      }
                                    }),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: PrimaryButtonWidget(
                                    onPressed: () {
                                            if (_signupUserInfoPage3Key
                                                .currentState!
                                                .validate()) {
                                              User.taxincome =
                                                  _taxNumberController.text;
                                              User.icomesource =
                                                  _sourceOfFundsController.text;
                                              User.purpose =
                                                  _purposeOfAccountController
                                                      .text;

                                              _signupBloc.add(
                                                  SignupPersonalDataEvent());
                                            }
                                          },
                                    buttonText: 'Continue',
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
