import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/crypto_screen/bloc/crypto_bloc.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant_string/User.dart';
import '../../utils/custom_scroll_behavior.dart';
import '../../utils/input_fields/custom_color.dart';
import '../../widgets/buttons/primary_button_widget.dart';

// ignore: must_be_immutable
class DepositConfirmationScreen extends StatefulWidget {
  String title, body, uniqueId;

  DepositConfirmationScreen(
      {super.key,
      required this.title,
      required this.body,
      required this.uniqueId});

  @override
  State<DepositConfirmationScreen> createState() =>
      _DepositConfirmationScreenState();
}

class _DepositConfirmationScreenState extends State<DepositConfirmationScreen> {
  final CryptoBloc _cryptoBloc = CryptoBloc();

  @override
  void initState() {
    _cryptoBloc.add(getibanlistEvent());
    super.initState();
    User.Screen = 'Move Euro';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: BlocListener(
          bloc: _cryptoBloc,
          listener: (context, CryptoState state) async {
            if (state.ibanDepositEurToCryptoCancelModel?.status == 1) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                dismissOnTouchOutside: false,
                desc: state.ibanDepositEurToCryptoCancelModel?.message,
                btnCancelText: 'OK',
                btnCancelColor: Colors.green,
                buttonsTextStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                btnCancelOnPress: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ).show();
            } else if (state.ibanDepositEurToCryptoCancelModel?.status ==
                0) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                dismissOnTouchOutside: false,
                desc: state.ibanDepositEurToCryptoCancelModel?.message,
                btnCancelText: 'OK',
                buttonsTextStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                btnCancelOnPress: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
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
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ScrollConfiguration(
                                    behavior: CustomScrollBehavior(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18, right: 18),
                                      child: ListView(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 20),
                                          Text(
                                            widget.title,
                                            style: GoogleFonts.inter(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 40),
                                          Image.asset(
                                            'images/bell.png',
                                            color: CustomColor.primaryColor,
                                            width: 100,
                                            height: 100,
                                          ),
                                          const SizedBox(height: 40),
                                          Container(
                                            padding:
                                                const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 20),
                                                Text(
                                                  widget.body,
                                                  textAlign:
                                                      TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 100),

                                          PrimaryButtonWidget(
                                            onPressed:  () {
                                              _cryptoBloc.add(
                                                  ApproveEurotoCryptoEvent(
                                                    uniqueId: widget.uniqueId,
                                                    completed: 'Completed',
                                                  ));
                                            },
                                            buttonText: 'Continue',
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _cryptoBloc.add(
                                                  ApproveEurotoCryptoEvent(
                                                uniqueId: widget.uniqueId,
                                                completed: 'Canceled',
                                              ));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              height: 40,
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.inter(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  fontSize: 16,
                                                  decoration: TextDecoration
                                                      .underline,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
