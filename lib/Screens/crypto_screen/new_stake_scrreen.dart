import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Models/crypto/stake_custom_period_model.dart';
import 'package:codegopay/Screens/crypto_screen/bloc/crypto_bloc.dart';
import 'package:codegopay/Screens/crypto_screen/staking_overivew.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/assets.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:codegopay/widgets/custom_image_widget.dart';
import 'package:codegopay/widgets/input_fields/amount_input_field_widget.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/main/default_dropdown_field_with_title_widget.dart';
import '../../widgets/toast/toast_util.dart';
import 'Crypto_screen.dart';

// ignore: must_be_immutable
class NewStakingScreen extends StatefulWidget {
  String symbol;

  NewStakingScreen({super.key, required this.symbol});

  @override
  State<NewStakingScreen> createState() => _NewStakingScreenState();
}

class _NewStakingScreenState extends State<NewStakingScreen> {
  final CryptoBloc _cryptoBloc = CryptoBloc();
  final TextEditingController _amountController = TextEditingController();
  SingleValueDropDownController _dropDownController =
      SingleValueDropDownController();

  final _formKey = GlobalKey<FormState>();
  bool active = false;

  bool bordershoww = false;
  String selectedPeriod = '';
  double userProfit = 0.00;
  double amount = 0.00;
  double? profitPercentage;

  StreamController<Object> streamController =
      StreamController<Object>.broadcast();
  final GlobalKey<FormState> _newStakingformKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _cryptoBloc.add(StakeFeeEvent(symbol: widget.symbol));
    _cryptoBloc.add(StakePeriodEvent());
    _amountController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _cryptoBloc.close(); // Close the bloc
    streamController.close();
    _amountController.removeListener(_updateButtonState);
    _amountController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        active = _formKey.currentState!.validate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      body: BlocListener(
          bloc: _cryptoBloc,
          listener: (context, CryptoState state) async {
            if (state.statusModel != null && state.statusModel!.status == 0) {
              CustomToast.showError(
                  context, "Sorry!!", state.statusModel!.message!);
            }

            if (state.newStakeRequestModel != null &&
                state.newStakeRequestModel!.status == 1) {
              CustomToast.showSuccess(
                  context, "Thank You!!", state.newStakeRequestModel!.message!);

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment.center,
                      isIos: true,
                      duration: const Duration(microseconds: 500),
                      child: StakingOverviewScreen(symbol: widget.symbol)),
                  (route) => false);
            }
          },
          child: BlocBuilder(
              bloc: _cryptoBloc,
              builder: (context, CryptoState state) {
                return SafeArea(
                  child: ProgressHUD(
                    inAsyncCall: state.isloading,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Form(
                        key: _newStakingformKey,
                        child: ListView(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 30, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultBackButtonWidget(onTap: () {
                                    Navigator.pop(context);
                                  }),
                                  Text(
                                    "New Staking Request",
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
                            ),
                            Form(
                              key: _formKey,
                              child: AmountInputField(
                                label: "Request Amount",
                                controller: _amountController,
                                currencySymbol: state
                                    .stakeFeeBalanceModel!.coin!
                                    .toUpperCase(),
                                minAmount: 0,
                                onChanged: (value) {
                                  amount = double.parse(_amountController.text);
                                  profitPercentage ??= 0.00;

                                  if (amount > 0 && profitPercentage! > 0) {
                                    setState(() {
                                      userProfit =
                                          amount * (profitPercentage! / 100);
                                    });
                                  } else {
                                    setState(() {
                                      userProfit = 0.0;
                                    });
                                  }
                                  _updateButtonState();
                                },
                              ),
                            ),
                            if (state
                                .stakeCustomPeriodModel!.period!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: DefaultDropDownFieldWithTitleWidget(
                                  controller: _dropDownController,
                                  title: "Duration",
                                  hint: "Select Period",
                                  dropDownItemCount: state
                                          .stakeCustomPeriodModel
                                          ?.period
                                          ?.length ??
                                      0,
                                  dropDownList: state
                                          .stakeCustomPeriodModel?.period
                                          ?.map<DropDownValueModel>(
                                              (Period period) {
                                        return DropDownValueModel(
                                          name:
                                              "${period.month} Month (Profit ${period.profit}% Per Month)",
                                          value: period,
                                        );
                                      }).toList() ??
                                      [],
                                  onChanged: (val) {
                                    setState(() {
                                      selectedPeriod =
                                          (val as DropDownValueModel)
                                              .value
                                              ?.month;
                                      profitPercentage =
                                          double.parse((val).value?.profit);
                                      bordershoww = val != null;
                                    });

                                    amount =
                                        double.parse(_amountController.text);

                                    if (amount > 0 && profitPercentage! > 0) {
                                      setState(() {
                                        userProfit =
                                            amount * (profitPercentage! / 100);
                                      });
                                    } else {
                                      setState(() {
                                        userProfit = 0.0;
                                      });
                                    }
                                  },
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "Your Monthly Profit: ${userProfit.toStringAsFixed(2)} ${widget.symbol.toLowerCase()}",
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.black.withOpacity(0.4)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (state
                                .stakeCustomPeriodModel!.period!.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    color: CustomColor.noteContainerColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, top: 3),
                                      child: CustomImageWidget(
                                        imagePath: StaticAssets.info,
                                        imageType: 'svg',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Note: ${state.stakeCustomPeriodModel!.message!}",
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColor.black
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (state
                                .stakeCustomPeriodModel!.period!.isNotEmpty)
                            const SizedBox(height: 30),
                            PrimaryButtonWidget(
                              onPressed: active? () {
                                active = false;
                                if (_newStakingformKey.currentState!
                                    .validate()) {
                                  _cryptoBloc.add(StakeRequestEvent(
                                    symbol: state.stakeFeeBalanceModel!.coin,
                                    amount: _amountController.text,
                                    period: selectedPeriod.toString(),
                                    isCustom: "1",
                                  ));
                                }
                              } : null,
                              buttonText: 'Send Request',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })),
      // bottomNavigationBar: CustomBottomBar(index: 1),
    );
  }
}
