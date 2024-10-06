import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Models/crypto/stake_custom_period_model.dart';
import 'package:codegopay/Screens/crypto_screen/bloc/crypto_bloc.dart';
import 'package:codegopay/Screens/crypto_screen/stake_confirm_screen.dart';
import 'package:codegopay/cutom_weidget/custom_navigationBar.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/assets.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:codegopay/widgets/custom_image_widget.dart';
import 'package:codegopay/widgets/input_fields/amount_input_field_widget.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:screenshot/screenshot.dart';

import '../../utils/validator.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/input_fields/defult_input_field_with_title_widget.dart';
import '../../widgets/main/default_dropdown_field_with_title_widget.dart';
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
  }

  @override
  void dispose() {
    _cryptoBloc.close(); // Close the bloc
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      body: BlocListener(
          bloc: _cryptoBloc,
          listener: (context, CryptoState state) async {
            if (state.statusModel != null && state.statusModel!.status == 0) {
              return AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                desc: state.statusModel!.message,
                btnCancelText: 'Okay',
                btnCancelColor: Colors.green,
                buttonsTextStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                btnCancelOnPress: () {},
              ).show();
            }

            if (state.newStakeRequestModel != null &&
                state.newStakeRequestModel!.status == 1) {
              return AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                desc: state.newStakeRequestModel!.message,
                btnCancelText: 'Okay',
                btnCancelColor: Colors.green,
                buttonsTextStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                btnCancelOnPress: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment.center,
                      isIos: true,
                      duration: const Duration(microseconds: 500),
                      child: const CryptoScreen(),
                    ),
                  );
                },
              ).show();
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
                            AmountInputField(
                              label: "Request Amount",
                              controller: _amountController,
                              currencySymbol: state.stakeFeeBalanceModel!.coin!
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
                              },
                            ),
                            // Container(
                            //   height: 140,
                            //   margin: const EdgeInsets.symmetric(horizontal: 5),
                            //   decoration: BoxDecoration(
                            //     borderRadius: const BorderRadius.all(
                            //       Radius.circular(10),
                            //     ),
                            //     color:
                            //         const Color(0xFF263159).withOpacity(0.05),
                            //   ),
                            //   child: Column(
                            //     // mainAxisAlignment:
                            //     // MainAxisAlignment.center,
                            //     children: [
                            //       const Padding(
                            //         padding: EdgeInsets.all(10.0),
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Text(
                            //               "Amount",
                            //               style: TextStyle(
                            //                   color: Colors.black,
                            //                   fontSize: 14,
                            //                   fontFamily: 'pop',
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //             Text(
                            //               " ",
                            //               style: TextStyle(
                            //                   color: Colors.black,
                            //                   fontSize: 14,
                            //                   fontFamily: 'pop',
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding: const EdgeInsets.all(10.0),
                            //         child: TextFormField(
                            //           autofocus: true,
                            //           controller: _amountController,
                            //           keyboardType: TextInputType.number,
                            //           onChanged: (value) {
                            //             amount = double.parse(
                            //                 _amountController.text);
                            //             profitPercentage ??= 0.00;
                            //
                            //             if (amount > 0 &&
                            //                 profitPercentage! > 0) {
                            //               setState(() {
                            //                 userProfit = amount *
                            //                     (profitPercentage! / 100);
                            //               });
                            //             } else {
                            //               setState(() {
                            //                 userProfit = 0.0;
                            //               });
                            //             }
                            //           },
                            //           style: const TextStyle(
                            //               fontSize: 30,
                            //               fontWeight: FontWeight.bold),
                            //           decoration: InputDecoration(
                            //               contentPadding:
                            //                   const EdgeInsets.all(0),
                            //               hintText: '000.00',
                            //               hintStyle: const TextStyle(
                            //                   fontFamily: 'pop',
                            //                   fontSize: 30,
                            //                   height: 2,
                            //                   fontWeight: FontWeight.w900,
                            //                   color: Color(0xffC4C4C4)),
                            //               enabledBorder:
                            //                   const OutlineInputBorder(
                            //                 borderSide: BorderSide(
                            //                   color: Colors.transparent,
                            //                   width: 0,
                            //                 ),
                            //               ),
                            //               errorBorder: const OutlineInputBorder(
                            //                 borderSide: BorderSide(
                            //                   color: Colors.transparent,
                            //                   width: 0,
                            //                 ),
                            //               ),
                            //               errorMaxLines: 1,
                            //               errorStyle: const TextStyle(
                            //                 fontFamily: 'pop',
                            //                 fontSize: 12,
                            //                 color: Colors.transparent,
                            //               ),
                            //               focusedBorder:
                            //                   const OutlineInputBorder(
                            //                 borderSide: BorderSide(
                            //                   color: Colors.transparent,
                            //                   width: 0,
                            //                 ),
                            //               ),
                            //               suffixText:
                            //                   state.stakeFeeBalanceModel!.coin!,
                            //               suffixStyle: const TextStyle(
                            //                   color: Colors.black,
                            //                   fontSize: 12,
                            //                   fontWeight: FontWeight.bold)),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            state.stakeCustomPeriodModel!.period!.isNotEmpty
                                ? Padding(
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

                                        amount = double.parse(
                                            _amountController.text);

                                        if (amount > 0 &&
                                            profitPercentage! > 0) {
                                          setState(() {
                                            userProfit = amount *
                                                (profitPercentage! / 100);
                                          });
                                        } else {
                                          setState(() {
                                            userProfit = 0.0;
                                          });
                                        }
                                      },
                                    ),
                                  )
                                : Container(),

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
                            state.stakeCustomPeriodModel!.period!.isNotEmpty
                                ? Container(
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
                                  )
                                : Container(),
                            const SizedBox(height: 30),

                            PrimaryButtonWidget(
                              onPressed: () {
                                if (_newStakingformKey.currentState!
                                    .validate()) {
                                  _cryptoBloc.add(StakeRequestEvent(
                                    symbol: state.stakeFeeBalanceModel!.coin,
                                    amount: _amountController.text,
                                    period: selectedPeriod.toString(),
                                    isCustom: "1",
                                  ));
                                }
                              },
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
