import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/crypto_screen/bloc/crypto_bloc.dart';
import 'package:codegopay/Screens/crypto_screen/deposit_confirmation_screen.dart';
import 'package:codegopay/Screens/crypto_screen/withdraw_confirmation_screen.dart';
import 'package:codegopay/cutom_weidget/custom_keyboard.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../constant_string/User.dart';
import '../../utils/assets.dart';
import '../../utils/custom_scroll_behavior.dart';
import '../../utils/input_fields/custom_color.dart';
import '../../widgets/buttons/custom_icon_button_widget.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/input_fields/amount_input_field_widget.dart';

// ignore: must_be_immutable
class WithdrawEuro extends StatefulWidget {
  String symbol, image;
  bool isBuy;

  WithdrawEuro(
      {super.key,
      required this.symbol,
      required this.isBuy,
      required this.image});

  @override
  State<WithdrawEuro> createState() => _WithdrawEuroState();
}

class _WithdrawEuroState extends State<WithdrawEuro> {
  final CryptoBloc _cryptoBloc = CryptoBloc();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _cryptoBloc.add(getibanlistEvent());
    super.initState();
    User.Screen = 'Move Euro';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      body: BlocListener(
          bloc: _cryptoBloc,
          listener: (context, CryptoState state) async {
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
            } else if (state.convertModel?.status == 1) {}

            if (state.ibanDepositEurToCryptoModel?.status == 1) {
              String body = state.ibanDepositEurToCryptoModel!.body!;
              String title = state.ibanDepositEurToCryptoModel!.title!;
              String uniqueId = state.ibanDepositEurToCryptoModel!.uniqueId!;

              debugPrint("check iban deposit check");

              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  isIos: true,
                  duration: const Duration(microseconds: 500),
                  child: DepositConfirmationScreen(
                    title: title,
                    body: body,
                    uniqueId: uniqueId,
                  ),
                ),
              );
            } else if (state.ibanDepositEurToCryptoModel?.status == 0) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                desc: state.ibanDepositEurToCryptoModel?.message,
                btnCancelText: 'OK',
                buttonsTextStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                btnCancelOnPress: () {},
              ).show();
            }

            if (state.eurWithdrawModel?.status == 1) {
              String body = state.eurWithdrawModel!.body!;
              String title = state.eurWithdrawModel!.title!;
              String uniqueId = state.eurWithdrawModel!.uniqueId!;

              debugPrint("check iban deposit check");

              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  isIos: true,
                  duration: const Duration(microseconds: 500),
                  child: WithdrawConfirmationScreen(
                    title: title,
                    body: body,
                    uniqueId: uniqueId,
                  ),
                ),
              );
            } else if (state.eurWithdrawModel?.status == 0) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                desc: state.eurWithdrawModel?.message,
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
              bloc: _cryptoBloc,
              builder: (context, CryptoState state) {
                return SafeArea(
                  child: ProgressHUD(
                    inAsyncCall: state.isloading,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Padding(
                            padding:
                                const EdgeInsets.only( top: 10),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultBackButtonWidget(onTap: () {
                                  Navigator.pop(context);
                                }),
                                Text(
                                  widget.isBuy
                                      ? 'Deposit'
                                      : 'Withdraw',
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
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),

                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16),
                          child: AmountInputField(
                            controller: _textEditingController,
                            label:  widget.isBuy
                                ? 'Deposit Amount'
                                : 'Withdraw Amount',
                            currencySymbol:  widget.symbol.toUpperCase(),
                            autofocus: false,
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _textEditingController.text = '25';
                                  });
                                },
                                child: Container(
                                  height: 43,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: CustomColor.hubContainerBgColor),
                                  child:  Text(
                                    '€25',
                                    style: GoogleFonts.inter(
                                        color: CustomColor.inputFieldTitleTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _textEditingController.text = '50';
                                  });
                                },
                                child: Container(
                                  height: 43,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: CustomColor.hubContainerBgColor),
                                  child:  Text(
                                    '€50',
                                    style: GoogleFonts.inter(
                                        color: CustomColor.inputFieldTitleTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _textEditingController.text = '100';
                                  });
                                },
                                child: Container(
                                  height: 43,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: CustomColor.hubContainerBgColor),
                                  child:  Text(
                                    '€100',
                                    style: GoogleFonts.inter(
                                        color: CustomColor.inputFieldTitleTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _textEditingController.text = '250';
                                  });
                                },
                                child: Container(
                                  height: 43,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: CustomColor.hubContainerBgColor),
                                  child:  Text(
                                    '€250',
                                    style: GoogleFonts.inter(
                                        color: CustomColor.inputFieldTitleTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // Container(
                        //   margin: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: ElevatedButton(
                        //     // onPressed: () {
                        //     //   widget.isBuy == false
                        //     //       ? _cryptoBloc.add(MovetoIbanEvent(
                        //     //           amount:
                        //     //               _textEditingController.text))
                        //     //       : _cryptoBloc.add(MoveEurotocryptoEvent(
                        //     //           amount:
                        //     //               _textEditingController.text));
                        //     // },
                        //       onPressed: () {
                        //         showModalBottomSheet(
                        //             context: context,
                        //             isDismissible: true,
                        //             enableDrag: true,
                        //             isScrollControlled: true,
                        //             backgroundColor: Colors.transparent,
                        //             barrierColor: Colors.black.withOpacity(0.7),
                        //             useRootNavigator: true,
                        //             builder: (context) {
                        //               return StatefulBuilder(builder: (buildContext,
                        //                   StateSetter
                        //                   setStater /*You can rename this!*/) {
                        //                 return Container(
                        //                     height: MediaQuery.of(context)
                        //                         .size
                        //                         .height /
                        //                         2,
                        //                     padding: EdgeInsets.only(
                        //                         top: 10,
                        //                         right: 10,
                        //                         left: 10,
                        //                         bottom: MediaQuery.of(context)
                        //                             .viewInsets
                        //                             .bottom),
                        //                     margin: const EdgeInsets.only(
                        //                         right: 16, left: 16, bottom: 0),
                        //                     decoration: const BoxDecoration(
                        //                       color: Color(0xffC4C4C4),
                        //                       borderRadius: BorderRadius.only(
                        //                           topLeft: Radius.circular(11),
                        //                           topRight:
                        //                           Radius.circular(11)),
                        //                     ),
                        //                     child: Column(
                        //                         mainAxisSize: MainAxisSize.max,
                        //                         children: [
                        //                           Container(
                        //                             alignment: Alignment.center,
                        //                             child: Container(
                        //                               width: 130,
                        //                               color: const Color(
                        //                                   0xff10245C),
                        //                               height: 2,
                        //                             ),
                        //                           ),
                        //                           const SizedBox(
                        //                             height: 20,
                        //                           ),
                        //                           Container(
                        //                             child: const Text(
                        //                               'Select Iban',
                        //                               style: TextStyle(
                        //                                 color:
                        //                                 Color(0xff10245C),
                        //                                 fontFamily: 'pop',
                        //                                 fontSize: 14,
                        //                                 fontWeight:
                        //                                 FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                           const SizedBox(
                        //                             height: 20,
                        //                           ),
                        //                           Expanded(
                        //                             child: ListView.builder(
                        //                               itemCount: state
                        //                                   .ibanlistModel!
                        //                                   .ibaninfo!
                        //                                   .length,
                        //                               itemBuilder:
                        //                                   (BuildContext context,
                        //                                   int index) {
                        //                                 return InkWell(
                        //                                   onTap: () {
                        //                                     Navigator.pop(
                        //                                         context);
                        //
                        //                                     widget.isBuy == false
                        //                                         ? _cryptoBloc.add(MovetoIbanEvent(
                        //                                         ibanid: state
                        //                                             .ibanlistModel!
                        //                                             .ibaninfo![
                        //                                         index]
                        //                                             .ibanId,
                        //                                         amount:
                        //                                         _textEditingController
                        //                                             .text))
                        //                                         : _cryptoBloc.add(MoveEurotocryptoEvent(
                        //                                         ibanid: state
                        //                                             .ibanlistModel!
                        //                                             .ibaninfo![
                        //                                         index]
                        //                                             .ibanId,
                        //                                         amount: _textEditingController
                        //                                             .text));
                        //                                   },
                        //                                   child: Container(
                        //                                     padding:
                        //                                     const EdgeInsets
                        //                                         .symmetric(
                        //                                         horizontal:
                        //                                         20,
                        //                                         vertical:
                        //                                         20),
                        //                                     decoration: const BoxDecoration(
                        //                                         border: Border(
                        //                                             bottom: BorderSide(
                        //                                                 color: Colors
                        //                                                     .white,
                        //                                                 width:
                        //                                                 1))),
                        //                                     child: Text(
                        //                                       state
                        //                                           .ibanlistModel!
                        //                                           .ibaninfo![
                        //                                       index]
                        //                                           .label!,
                        //                                       style: const TextStyle(
                        //                                           color: Colors
                        //                                               .white,
                        //                                           fontFamily:
                        //                                           'pop',
                        //                                           fontSize: 14,
                        //                                           fontWeight:
                        //                                           FontWeight
                        //                                               .w600),
                        //                                     ),
                        //                                   ),
                        //                                 );
                        //                               },
                        //                             ),
                        //                           )
                        //                         ]));
                        //               });
                        //             });
                        //       },
                        //       style: ElevatedButton.styleFrom(
                        //         shadowColor: const Color(0xff191C32),
                        //         elevation: 5,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(40)),
                        //         backgroundColor: CustomColor.primaryColor,
                        //         minimumSize: const Size.fromHeight(55),
                        //       ),
                        //       child: const Text(
                        //         'Next',
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 15,
                        //             fontWeight: FontWeight.w600,
                        //             fontFamily: 'pop'),
                        //       )),
                        // ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: PrimaryButtonWidget(
                            onPressed:  () {
                              showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  enableDrag: true,
                                  isScrollControlled: true,
                                  backgroundColor: CustomColor.whiteColor,
                                  barrierColor: Colors.black.withOpacity(0.7),
                                  useRootNavigator: true,
                                  builder: (context) {
                                    return StatefulBuilder(builder: (buildContext,
                                        StateSetter
                                        setStater /*You can rename this!*/) {
                                      return Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height * 0.5,
                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                          // margin: const EdgeInsets.only(
                                          //     right: 16, left: 16, bottom: 0),
                                          decoration: const BoxDecoration(
                                            color: CustomColor.whiteColor,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight:
                                                Radius.circular(12)),
                                          ),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    CustomIconButtonWidget(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      svgAssetPath: StaticAssets.closeBlack, // Replace with your asset path
                                                    ),
                                                    Text(
                                                      'Select IBAN',
                                                      style: GoogleFonts.inter(
                                                        color: CustomColor.primaryColor,
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: state
                                                        .ibanlistModel!
                                                        .ibaninfo!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        int index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);

                                                          widget.isBuy == false
                                                              ? _cryptoBloc.add(MovetoIbanEvent(
                                                              ibanid: state
                                                                  .ibanlistModel!
                                                                  .ibaninfo![
                                                              index]
                                                                  .ibanId,
                                                              amount:
                                                              _textEditingController
                                                                  .text))
                                                              : _cryptoBloc.add(MoveEurotocryptoEvent(
                                                              ibanid: state
                                                                  .ibanlistModel!
                                                                  .ibaninfo![
                                                              index]
                                                                  .ibanId,
                                                              amount: _textEditingController
                                                                  .text));
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                                                          decoration: const BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(
                                                                color: CustomColor.primaryInputHintBorderColor,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            state
                                                                .ibanlistModel!
                                                                .ibaninfo![
                                                            index]
                                                                .label!,
                                                            style: GoogleFonts.inter(
                                                              color: CustomColor.black,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ]));
                                    });
                                  });
                            },
                            buttonText: 'Next',
                          ),
                        ),

                        Expanded(
                            child: Container(
                          color: const Color(0xffF7F9FD),
                          child: KeyPad2(
                            pinController: _textEditingController,
                            onChange: (String pin) {
                              _textEditingController.text = pin;
                            },
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              })),
    );
  }

// ApproveEurotocrypto(
//     {required String title, required String body, required String uniqueId}) {
//   try {
//     showGeneralDialog(
//       context: context,
//       pageBuilder: (BuildContext buildContext, Animation<double> animation,
//           Animation<double> secondaryAnimation) {
//         return Container(
//           color: Colors.white,
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Center(
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Material(
//                 color: Colors.transparent,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: ScrollConfiguration(
//                         behavior: CustomScrollBehavior(),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 18, right: 18),
//                           child: ListView(
//                             // crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const SizedBox(height: 20),
//                               Text(
//                                 title,
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: 'pop',
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(height: 40),
//                               Image.asset(
//                                 'images/bell.png',
//                                 color: const Color(0xff090B78),
//                                 width: 100,
//                                 height: 100,
//                               ),
//                               const SizedBox(height: 40),
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const SizedBox(height: 20),
//                                     Text(
//                                       body,
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500,
//                                         fontFamily: 'pop',
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 100),
//                               Container(
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 10),
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(100),
//                                     gradient: const LinearGradient(colors: [
//                                       Color(0xff090B78),
//                                       Color(0xff090B78)
//                                     ])),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     _cryptoBloc.add(ApproveEurotoCryptoEvent(
//                                       uniqueId: uniqueId,
//                                       completed: 'Completed',
//                                     ));
//                                     // Navigator.popUntil(
//                                     //     context, (route) => route.isFirst);
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0)),
//                                       backgroundColor: Colors.transparent,
//                                       elevation: 0,
//                                       shadowColor: Colors.transparent,
//                                       minimumSize: const Size.fromHeight(50)),
//                                   child: const Text(
//                                     "Confirm",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         fontFamily: 'pop',
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 50),
//                               InkWell(
//                                 onTap: () {
//                                   // Navigator.pop(context);
//                                   _cryptoBloc.add(ApproveEurotoCryptoEvent(
//                                     uniqueId: uniqueId,
//                                     completed: 'Canceled',
//                                   ));
//                                   // Navigator.popUntil(
//                                   //     context, (route) => route.isFirst);
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   width: double.infinity,
//                                   height: 40,
//                                   child: Text(
//                                     'Cancel',
//                                     style: TextStyle(
//                                       color: Colors.black.withOpacity(0.7),
//                                       fontSize: 16,
//                                       decoration: TextDecoration.underline,
//                                       fontFamily: 'pop',
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       barrierDismissible: true,
//       barrierLabel:
//           MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierColor: Colors.black.withOpacity(0.1),
//       transitionDuration: const Duration(milliseconds: 0),
//     );
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }

// ApprovetransferEurotoiban(
//     {required String body, required String title, required String uniqueId}) {
//   try {
//     showGeneralDialog(
//       context: context,
//       pageBuilder: (BuildContext buildContext, Animation<double> animation,
//           Animation<double> secondaryAnimation) {
//         return Container(
//           color: Colors.white,
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Center(
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Material(
//                 color: Colors.transparent,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: ScrollConfiguration(
//                         behavior: CustomScrollBehavior(),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 18, right: 18),
//                           child: ListView(
//                             // crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const SizedBox(height: 20),
//                               Text(
//                                 title,
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: 'pop',
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(height: 40),
//                               Image.asset(
//                                 'images/bell.png',
//                                 color: const Color(0xff090B78),
//                                 width: 100,
//                                 height: 100,
//                               ),
//                               const SizedBox(height: 40),
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const SizedBox(height: 20),
//                                     Text(
//                                       body,
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500,
//                                         fontFamily: 'pop',
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 100),
//                               Container(
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 10),
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(100),
//                                     gradient: const LinearGradient(colors: [
//                                       Color(0xff090B78),
//                                       Color(0xff090B78)
//                                     ])),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     _cryptoBloc.add(ApproveEurotoIbanEvent(
//                                       uniqueId: uniqueId,
//                                       completed: 'Completed',
//                                     ));
//                                     // Navigator.popUntil(
//                                     //     context, (route) => route.isFirst);
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0)),
//                                       elevation: 0,
//                                       shadowColor: Colors.transparent,
//                                       // : Colorprimarys.transparent,
//                                       backgroundColor:
//                                           const Color(0xff191C32),
//                                       minimumSize: const Size.fromHeight(50)),
//                                   child: const Text(
//                                     "Confirm",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         fontFamily: 'pop',
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 50),
//                               InkWell(
//                                 onTap: () {
//                                   // Navigator.popUntil(
//                                   //     context, (route) => route.isFirst);
//                                   _cryptoBloc.add(ApproveEurotoIbanEvent(
//                                     uniqueId: uniqueId,
//                                     completed: 'Canceled',
//                                   ));
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   width: double.infinity,
//                                   height: 40,
//                                   child: Text(
//                                     'Cancel',
//                                     style: TextStyle(
//                                       color: Colors.black.withOpacity(0.7),
//                                       fontSize: 16,
//                                       decoration: TextDecoration.underline,
//                                       fontFamily: 'pop',
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       barrierDismissible: true,
//       barrierLabel:
//           MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierColor: Colors.black.withOpacity(0.1),
//       transitionDuration: const Duration(milliseconds: 0),
//     );
//   } catch (e) {
//     debugPrint(e.toString());
//   }
//   ;
// }
}
