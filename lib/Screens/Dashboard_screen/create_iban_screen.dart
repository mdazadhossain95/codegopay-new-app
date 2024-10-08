import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/dashboard/iban_currency_model.dart';
import '../../constant_string/User.dart';
import '../../cutom_weidget/input_textform.dart';
import '../../utils/custom_style.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/main/currency_selector_widget.dart';
import '../../widgets/main/iban_selector_widget.dart';
import '../../widgets/toast/toast_util.dart';

class CreateIbanScreen extends StatefulWidget {
  const CreateIbanScreen({super.key});

  @override
  State<CreateIbanScreen> createState() => _CreateIbanScreenState();
}

class _CreateIbanScreenState extends State<CreateIbanScreen> {
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _ibanLabel = TextEditingController();

  String? selectedCurrency;
  String? selectedIban;

  List<Currency> currencies = [];
  List<Iban> iBans = [];
  bool allowIbanLabel = false;

  final DashboardBloc _dashboardBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    User.Screen = 'Create Iban Screen';
    _dashboardBloc.add(GetIbanCurrencyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      body: BlocListener(
          bloc: _dashboardBloc,
          listener: (context, DashboardState state) async {
            if (state.ibanKycCheckModel?.status == 0) {
              CustomToast.showError(
                  context, "Sorry!", state.ibanKycCheckModel!.message!);
            }

            if (state.statusModel?.status == 0) {
              CustomToast.showError(
                  context, "Sorry!", state.statusModel!.message!);
            }

            if (state.ibanKycCheckModel?.status == 1) {
              allowIbanLabel = true;
            }

            if (state.ibanKycCheckModel?.status == 2) {
              UserDataManager().userSumSubTokenSave(
                  state.ibanKycCheckModel!.sumsubtoken.toString());
              UserDataManager().statusMessageSave(
                  state.ibanKycCheckModel!.message.toString());

              Navigator.pushNamedAndRemoveUntil(
                  context, 'ibanKycScreen', (route) => true);
            }

            if (state.ibanCurrencyModel?.status == 1) {
              currencies = state.ibanCurrencyModel?.currency ?? [];
              iBans = state.ibanCurrencyModel?.iban ?? [];
            }
          },
          child: BlocBuilder(
              bloc: _dashboardBloc,
              builder: (context, DashboardState state) {
                return SafeArea(
                  child: ProgressHUD(
                    inAsyncCall: state.isloading,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Column(
                        children: [
                          appBarSection(context, state),
                          Expanded(
                            child: ListView(
                              children: [
                                Text(
                                  Strings.createIbanTitle,
                                  style: CustomStyle.loginTitleStyle,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(Strings.createIbanSubTitle,
                                      style: CustomStyle.loginSubTitleStyle),
                                ),
                                CurrencySelector(
                                  controller: _currencyController,
                                  label: "Select Currency",
                                  hint: 'Select Currency',
                                  currencies: currencies,
                                ),
                                IbanSelector(
                                  ibanController: _ibanController,
                                  label: 'Select IBAN',
                                  hint: 'Select IBAN',
                                  ibans: iBans,
                                ),
                                allowIbanLabel
                                    ? InputTextCustom(
                                        controller: _ibanLabel,
                                        hint: 'write label',
                                        label: 'Label',
                                        isEmail: false,
                                        isPassword: false,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10), // Space before buttons
                          allowIbanLabel
                              ? PrimaryButtonWidget(
                                  onPressed: () {
                                    _dashboardBloc.add(CreateibanEvent(
                                        Label: _ibanLabel.text,
                                        currency: _currencyController.text,
                                        iban: _ibanController.text));
                                    // _ibanLabel.text = '';
                                  },
                                  buttonText: 'Confirm',
                                )
                              : PrimaryButtonWidget(
                                  onPressed: () {
                                    _dashboardBloc.add(IbanSumSubVerified(
                                      currency: _currencyController.text,
                                      iban: _ibanController.text,
                                    ));
                                  },
                                  buttonText: 'Next',
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
      // bottomNavigationBar: CustomBottomBar(index: 0),
    );
  }

  appBarSection(BuildContext context, state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultBackButtonWidget(onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'dashboard', (route) => false);
          }),
          Text(
            'Create IBAN',
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
    );
  }
}
