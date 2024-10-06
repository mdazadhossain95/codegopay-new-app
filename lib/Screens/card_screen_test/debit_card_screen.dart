import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Models/card/card_iban_list_model.dart';
import 'package:codegopay/Models/card/card_topup_confirm_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../Models/card/card_details_model.dart';
import '../../constant_string/User.dart';
import '../../cutom_weidget/custom_navigationBar.dart';
import '../../cutom_weidget/cutom_progress_bar.dart';
import '../../cutom_weidget/input_textform.dart';
import '../../utils/get_ip_address.dart';
import '../../utils/user_data_manager.dart';
import '../../utils/webview_screen.dart';
import '../Dashboard_screen/bloc/dashboard_bloc.dart';
import '../Profile_screen/Profile_screen.dart';

class DebitCardScreen extends StatefulWidget {
  const DebitCardScreen({super.key});

  @override
  State<DebitCardScreen> createState() => _DebitCardScreenState();
}

class _DebitCardScreenState extends State<DebitCardScreen> {
  bool active = false;
  bool isInstant = false;

  bool isInstantPhysical = false;
  bool isInstantVirtual = false;
  int? cardActive;
  String? isPrepaidCard;
  String? isVirtualCard;
  String? isPrepaidDebit;
  String? showNumber;
  String? textStatus;
  int iframe = 0;
  String iframeUrl = "";

  final TextEditingController _searchController = TextEditingController();
  List<CardTrx> _filteredTransactions = [];

  List empList = [];
  List filteredList = [];

  bool showNotification = true;
  final DashboardBloc _cardDetailsBloc = DashboardBloc();

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');

    _cardDetailsBloc.add(DashboarddataEvent());
    _cardDetailsBloc.add(CardDetailsEvent());
  }

  @override
  void initState() {
    super.initState();
    User.Screen = 'card Details screen';

    _cardDetailsBloc.add(DashboarddataEvent());
    _cardDetailsBloc.add(CardDetailsEvent());
    numberShow();
    // GetIPAddress().getIps();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  numberShow() async {
    showNumber = await UserDataManager().getCardNumberShow();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: Color(0xffFAFAFA),
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xffFAFAFA)),
        child: Scaffold(
          backgroundColor: const Color(0xffFAFAFA),
          body: BlocListener(
              bloc: _cardDetailsBloc,
              listener: (context, DashboardState state) {
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
                }

                if (state.userCardDetailsModel?.status == 1) {
                  cardActive =
                      state.userCardDetailsModel!.userCardDetails!.isActive;
                  _filteredTransactions =
                      state.userCardDetailsModel!.userCardDetails!.cardTrx!;
                  print(_filteredTransactions.toString());

                  // "cardType":"Prepaid Card"
                  isPrepaidCard = state
                      .userCardDetailsModel!.userCardDetails!.cardType
                      .toString();
                  isVirtualCard = state
                      .userCardDetailsModel!.userCardDetails!.cardMaterial
                      .toString();
                  isPrepaidDebit = state
                      .userCardDetailsModel!.userCardDetails!.isPrepaidDebit
                      .toString();
                  textStatus = state
                      .userCardDetailsModel!.userCardDetails!.textStatus
                      .toString();
                  print(textStatus);

                  UserDataManager().cardToCardTransferSenderIdSave(state
                      .userCardDetailsModel!.userCardDetails!.cid
                      .toString());

                  // _filteredTransactions = _transactions;
                }

                if (state.cardActiveModel?.status == 1) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'debitCardScreen', (route) => false);
                }

                if (state.cardBlockUnblockModel?.status == 1) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'debitCardScreen', (route) => false);
                }
              },
              child: BlocBuilder(
                  bloc: _cardDetailsBloc,
                  builder: (context, DashboardState state) {
                    return SafeArea(
                      child: ProgressHUD(
                        inAsyncCall: state.isloading,
                        child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                appBarSection(context, state),
                                cardSection(context, state),
                                cardActive ==
                                        null // Check if data is still loading
                                    ? Container() // Show loading indicator if data is loading
                                    : cardActive == 2
                                        ? cardTemporarilyBlockedSection(context)
                                        : Container(),
                                cardActive ==
                                        null // Check if data is still loading
                                    ? Container() // Show loading indicator if data is loading
                                    : cardActive == 0
                                        ? cardActiveSection(context)
                                        : Container(),
                                const SizedBox(height: 20),
                                // payFrom(context),

                                textStatus == "Requested"
                                    ? Container()
                                    : topUpWidget(context, state),

                                textStatus == "Requested"
                                    ? Container()
                                    : cardToCardTransferWidget(context, state),

                                virtualCardDetailsSection(context, state),
                                transaction(context, state),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
          bottomNavigationBar: CustomBottomBar(index: 3),
        ));
  }

  appBarSection(BuildContext context, DashboardState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'DASHBOARD CARDS',
                style: TextStyle(
                    color: Color(0xffC4C4C4),
                    fontFamily: 'pop',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 90,
            width: 80,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                InkWell(
                  onTap: () {
                    UserDataManager().cardNumberShowSave("false");
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        alignment: Alignment.center,
                        isIos: true,
                        duration: const Duration(microseconds: 500),
                        child: const ProfileScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(state.dashboardModel!.profileimage!),
                      radius: 35,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  alignment: Alignment.topLeft,
                  child: Image.asset('images/message-question.png'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  cardSection(BuildContext context, DashboardState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              UserDataManager().cardNumberShowSave("false");
              Navigator.pushNamedAndRemoveUntil(
                  context, 'cardScreen', (route) => false);
            },
            child: Image.asset(
              "images/backarrow.png",
              color: const Color(0xff373737),
              height: 24,
              width: 24,
            ),
          ),
          Center(
            child: Image.network(
              state.userCardDetailsModel!.userCardDetails!.cardImage.toString(),
              width: MediaQuery.of(context).size.width * 0.65,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                print('Error loading image: $error');
                return const Center(
                  child:
                      CircularProgressIndicator(), // Show a loading indicator in case of an error
                );
              },
            ),
          ),
          textStatus == "Requested"
              ? GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "images/settings.png",
                    color: Colors.transparent,
                    height: 35,
                    width: 35,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    UserDataManager().cardNumberShowSave("false");
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'cardSettingsScreen', (route) => true);
                  },
                  child: Image.asset(
                    "images/settings.png",
                    color: const Color(0xff090B78),
                    height: 35,
                    width: 35,
                  ),
                ),
        ],
      ),
    );
  }

  cardTemporarilyBlockedSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffFFD058),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'Card Temporarily Blocked',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFF6B00),
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'You’ve temporarily blocked your card, so it can’t be used by anyone for payments or withdrawal',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFFFF6B00),
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1),
            ),
          ),
          InkWell(
            onTap: () {
              UserDataManager().cardBlockUnblockStatusSave("unblock");
              _cardDetailsBloc.add(CardBlockUnblockEvent());
            },
            child: Container(
              // width: 263,
              height: 37,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: const Color(0xffFF8A00),
                border: Border.all(
                  color: const Color(0xffFF8A00),
                  width: 1,
                ),
              ),
              child: const Text(
                'Reactivated Card',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
          )
        ],
      ),
    );
  }

  cardActiveSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xff58EBFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'Have you received your card?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0A7BCD),
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              'Your card has been assigned and shipped, if you have received the card, activate withdrawals and payments',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xfff0a7bcd),
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1),
            ),
          ),
          InkWell(
            onTap: () {
              showBottomSheet(
                context: context,
                elevation: 5,
                builder: (context) {
                  return const ActiveCardScreen();
                },
              );
            },
            child: Container(
              // width: 263,
              height: 37,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: const Color(0xff0A7BCD),
                border: Border.all(
                  color: const Color(0xff0A7BCD),
                  width: 1,
                ),
              ),
              child: const Text(
                'Activate Card',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            // padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'I didn\'t receive the card after 2 week',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0A7BCD),
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  payFrom(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: const Color(0xffEDEBEB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/card/card_demo.png"),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2.0, bottom: 7, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pay from',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Label (MAIN)',
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 9,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'BE123456789012345',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 9,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  topUpWidget(BuildContext context, DashboardState state) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: const Color(0xffEDEBEB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  state.userCardDetailsModel!.userCardDetails!.cardImage
                      .toString(),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    print('Error loading image: $error');
                    return const Center(
                      child:
                          CircularProgressIndicator(), // Show a loading indicator in case of an error
                    );
                  },
                ),
              ),
              cardActive == 2
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            elevation: 5,
                            builder: (context) {
                              return const PrepaidCardTopUpScreen();
                            },
                          );
                        },
                        child: Image.asset(
                          "images/add_square_new.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
              cardActive == 2
                  ? Container()
                  : const Text(
                      'Topup',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Balance',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.userCardDetailsModel!.userCardDetails!.symbol
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.userCardDetailsModel!.userCardDetails!.balance
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  cardToCardTransferWidget(BuildContext context, DashboardState state) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
            context, 'prepaidCardBeneficiaryScreen', (route) => true);
      },
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xffEDEBEB),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    state.userCardDetailsModel!.userCardDetails!.cardImage
                        .toString(),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      print('Error loading image: $error');
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Show a loading indicator in case of an error
                      );
                    },
                  ),
                ),
                const Text(
                  'Card To Card Transfer',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset(
                "images/card/card-to-card-transfer.png",
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // cardDetailsSection(BuildContext context, DashboardState state) {
  //   return Center(
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: const Color(0xffEDEBEB),
  //       ),
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Text(
  //                 'Card Number',
  //                 textAlign: TextAlign.left,
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontFamily: 'Poppins',
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.normal,
  //                     height: 1),
  //               ),
  //               Row(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 5),
  //                     child: showNumber == "true"
  //                         ? Text(
  //                             state.userCardDetailsModel!.userCardDetails!
  //                                 .fullcardnumber
  //                                 .toString(),
  //                             style: const TextStyle(
  //                               color: Colors.black,
  //                               fontFamily: 'Poppins',
  //                               fontSize: 10,
  //                               fontWeight: FontWeight.normal,
  //                               height: 1,
  //                             ),
  //                           )
  //                         : Text(
  //                             state.userCardDetailsModel!.userCardDetails!
  //                                 .cardnumber
  //                                 .toString(), // Masked number
  //                             style: const TextStyle(
  //                               color: Colors.black,
  //                               fontFamily: 'Poppins',
  //                               fontSize: 10,
  //                               fontWeight: FontWeight.normal,
  //                               height: 1,
  //                             ),
  //                           ),
  //                   ),
  //                   GestureDetector(
  //                     onTap: () async {
  //                       final result = await Navigator.pushNamedAndRemoveUntil(
  //                           context, 'cardVerifyGetPinScreen', (route) => true);
  //
  //                       if (result == true) {
  //                         Navigator.pushNamedAndRemoveUntil(
  //                             context, 'debitCardScreen', (route) => false);
  //                       }
  //                     },
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       width: 57,
  //                       height: 28,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(11),
  //                         color: const Color(0xff1C3C79),
  //                         border: Border.all(
  //                           color: const Color(0xffC4C4C4),
  //                           width: 1,
  //                         ),
  //                       ),
  //                       child: const Text(
  //                         'Show',
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontFamily: 'Poppins',
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.normal,
  //                             height: 1),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ),
  //           Container(
  //             margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
  //             child: const Divider(
  //               color: Color(0xffB6B6B6),
  //               height: 1,
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Text(
  //                 'Expiry',
  //                 textAlign: TextAlign.left,
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontFamily: 'Poppins',
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.normal,
  //                     height: 1),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 10),
  //                 child: Text(
  //                   state.userCardDetailsModel!.userCardDetails!.expiry
  //                       .toString(), //
  //                   style: const TextStyle(
  //                       color: Colors.black,
  //                       fontFamily: 'Poppins',
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.normal,
  //                       height: 1),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Container(
  //             margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
  //             child: const Divider(
  //               color: Color(0xffB6B6B6),
  //               height: 1,
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Text(
  //                 'CVV',
  //                 textAlign: TextAlign.left,
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontFamily: 'Poppins',
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.normal,
  //                     height: 1),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 10),
  //                 child: Text(
  //                   state.userCardDetailsModel!.userCardDetails!.cvv.toString(),
  //                   style: const TextStyle(
  //                       color: Colors.black,
  //                       fontFamily: 'Poppins',
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.normal,
  //                       height: 1),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Container(
  //             margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
  //             child: const Divider(
  //               color: Color(0xffB6B6B6),
  //               height: 1,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  virtualCardDetailsSection(BuildContext context, DashboardState state) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffEDEBEB),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Card Number',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          state
                              .userCardDetailsModel!.userCardDetails!.cardnumber
                              .toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                        )),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamedAndRemoveUntil(
                            context, 'cardVerifyGetPinScreen', (route) => true);
                        iframe = state
                            .userCardDetailsModel!.userCardDetails!.isiframe!;
                        iframeUrl = state
                            .userCardDetailsModel!.userCardDetails!.iframeurl!;

                        if (result == true) {
                          if (iframe == 0) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 240,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: const BoxDecoration(
                                      // borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/card/virtual_card_demo.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Text(
                                                  state.userCardDetailsModel!
                                                      .userCardDetails!.cvv
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.copy,
                                                      color: Colors.white),
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                      text: state
                                                          .userCardDetailsModel!
                                                          .userCardDetails!
                                                          .cvv
                                                          .toString(),
                                                    ));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Copied to clipboard')),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                state
                                                    .userCardDetailsModel!
                                                    .userCardDetails!
                                                    .fullcardnumber
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.copy,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                    text: state
                                                        .userCardDetailsModel!
                                                        .userCardDetails!
                                                        .fullcardnumber
                                                        .toString(),
                                                  ));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Copied to clipboard')),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                state.userCardDetailsModel!
                                                    .userCardDetails!.expiry
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.copy,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                    text: state
                                                        .userCardDetailsModel!
                                                        .userCardDetails!
                                                        .expiry
                                                        .toString(),
                                                  ));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Copied to clipboard')),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              state
                                                          .userCardDetailsModel!
                                                          .userCardDetails!
                                                          .cardHolderName
                                                          .toString() ==
                                                      "null"
                                                  ? ""
                                                  : state
                                                      .userCardDetailsModel!
                                                      .userCardDetails!
                                                      .cardHolderName
                                                      .toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (iframe == 1) {
                            print(iframeUrl);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WebViewScreen(url: iframeUrl),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 57,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: const Color(0xff1C3C79),
                          border: Border.all(
                            color: const Color(0xffC4C4C4),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'Show',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              child: const Divider(
                color: Color(0xffB6B6B6),
                height: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Expiry',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    state.userCardDetailsModel!.userCardDetails!.expiry
                        .toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              child: const Divider(
                color: Color(0xffB6B6B6),
                height: 1,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CVV',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "***",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              child: const Divider(
                color: Color(0xffB6B6B6),
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  transaction(BuildContext context, DashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: const Text(
            'Transactions',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
        Container(
          height: 42,
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFEEF0F9),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              value = value.toLowerCase();
              setState(() {
                _filteredTransactions = state
                    .userCardDetailsModel!.userCardDetails!.cardTrx!
                    .where((element) {
                  var name = element.merchNameDe43!.toLowerCase();
                  return name.contains(value);
                }).toList();
              });
            },
            cursorColor: const Color(0xff888888),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: 'search transaction...',
              hintStyle: const TextStyle(
                color: Color(0xffB2B1B1),
                fontSize: 15,
                fontFamily: 'pop',
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xff888888),
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    width: 1.2,
                    color: Color(0xff888888),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    width: 1.2,
                    color: Color(0xff888888),
                  )),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: const Text(
            'Today',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
        SizedBox(
          height: 300,
          child: _filteredTransactions.isEmpty
              ? const Center(
                  child: Text(
                    "No Transaction yet",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'pop',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                )
              : ListView.builder(
                  itemCount: _filteredTransactions.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 65,
                                        width: 65,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          border: Border.all(
                                            width: 1,
                                            color: const Color(0xffE3E3E3),
                                            // color: Colors.black,
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 40,
                                          child: ClipOval(
                                            child: CircleAvatar(
                                              radius: 30,
                                              // Adjust the radius as needed
                                              backgroundColor: Colors.grey[300],
                                              // Placeholder color
                                              backgroundImage: NetworkImage(
                                                _filteredTransactions[index]
                                                        .image
                                                        .toString() ??
                                                    '',
                                              ),
                                              child:
                                                  _filteredTransactions[index]
                                                              .image !=
                                                          null
                                                      ? null
                                                      : const Icon(
                                                          Icons
                                                              .error_outline_rounded,
                                                          color: Colors
                                                              .grey, // Error icon color
                                                        ),
                                            ),
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _filteredTransactions[index]
                                                .merchNameDe43!.toString() ?? " ",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'pop',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Date: ${_filteredTransactions[index].created!.toString() ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'pop',
                                                color: Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Status: ",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'pop',
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xffC4C4C4)),
                                              ),
                                              Text(
                                                _filteredTransactions[index]
                                                    .status!
                                                    .toString() ?? "",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'pop',
                                                    fontWeight: FontWeight.w500,
                                                    color: _filteredTransactions[
                                                                    index]
                                                                .status!
                                                                .toString() ==
                                                            "completed"
                                                        ? Colors.green
                                                        : Colors.red),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _filteredTransactions[index].symbol! +
                                        _filteredTransactions[index].totalPay!,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red),
                                  ),
                                  Text(
                                    _filteredTransactions[index].type!,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'pop',
                                        color: _filteredTransactions[index]
                                                    .type! ==
                                                "debit"
                                            ? Colors.red
                                            : Colors.green),
                                  )
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                ),
        )
      ],
    );
  }
}

class ActiveCardScreen extends StatefulWidget {
  const ActiveCardScreen({super.key});

  @override
  State<ActiveCardScreen> createState() => _ActiveCardScreenState();
}

class _ActiveCardScreenState extends State<ActiveCardScreen> {
  final DashboardBloc _activeCardScreenBloc = DashboardBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _activeCardScreenBloc,
      listener: (context, DashboardState state) {
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
        }

        if (state.cardActiveModel?.status == 1) {
          Navigator.pushNamedAndRemoveUntil(
              context, 'debitCardScreen', (route) => false);
        }
      },
      child: BlocBuilder(
          bloc: _activeCardScreenBloc,
          builder: (context, DashboardState state) {
            return Material(
              color: Colors.white, // Set the background color to white
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)), // Rounded top corners
              child: Container(
                height: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: ProgressHUD(
                  inAsyncCall: state.isloading,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Close",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Active your card",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                width: 45,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          InputTextCustom(
                              controller: _cardNumberController,
                              hint: 'Card Number',
                              label: 'Card Number',
                              keyboardType: TextInputType.number,
                              isEmail: false,
                              isPassword: false,
                              isSixteenDigits: true,
                              onChanged: () {}),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11)),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    UserDataManager().activeCardNumberSave(
                                        _cardNumberController.text);

                                    _activeCardScreenBloc
                                        .add(CardActiveEvent());
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
                                        borderRadius:
                                            BorderRadius.circular(11))),
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'pop',
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class PrepaidCardTopUpScreen extends StatefulWidget {
  const PrepaidCardTopUpScreen({super.key});

  @override
  State<PrepaidCardTopUpScreen> createState() => _PrepaidCardTopUpScreenState();
}

class _PrepaidCardTopUpScreenState extends State<PrepaidCardTopUpScreen> {
  final DashboardBloc _prepaidCardTopUpBloc = DashboardBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _prepaidCardTopUpBloc.add(CardIbanListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _prepaidCardTopUpBloc,
      listener: (context, DashboardState state) {
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
        }

        if (state.cardTopUpFeeModel?.status == 1) {
          showBottomSheet(
            context: context,
            elevation: 5,
            builder: (context) {
              return const PrepaidCardTotalCostScreen();
            },
          );
        }
      },
      child: BlocBuilder(
          bloc: _prepaidCardTopUpBloc,
          builder: (context, DashboardState state) {
            return Material(
              color: Colors.white, // Set the background color to white
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)), // Rounded top corners
              child: Container(
                height: 350,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: ProgressHUD(
                  inAsyncCall: state.isloading,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Topup",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                width: 45,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _selectIBANWidget(
                              context,
                              state.cardIbanListModel!.ibaninfo!,
                              _ibanController),
                          InputTextCustom(
                              controller: _amountController,
                              hint: 'Amount',
                              label: 'Topup Amount',
                              keyboardType: TextInputType.number,
                              isEmail: false,
                              isPassword: false,
                              onChanged: () {}),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11)),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    UserDataManager().prepaidCardAmountSave(
                                        _amountController.text);
                                    _prepaidCardTopUpBloc
                                        .add(CardTopupAmountEvent());
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
                                        borderRadius:
                                            BorderRadius.circular(11))),
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'pop',
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  _selectIBANWidget(BuildContext context, List<Ibaninfo> ibanList,
      TextEditingController controller) {
    String? selectedLabel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select IBAN",
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'pop',
            color: Color(0xff10245C),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          value: controller.text.isNotEmpty
              ? controller.text
              : ibanList.isNotEmpty
                  ? ibanList.first.ibanId!
                  : null,
          iconEnabledColor: const Color(0xff10245C),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xff10245C)),
            ),
          ),
          onChanged: (selectedValue) {
            if (selectedValue != null) {
              final selectedIban = ibanList.isNotEmpty
                  ? ibanList.firstWhere((iban) => iban.ibanId == selectedValue)
                  : null;
              if (selectedIban != null) {
                controller.text = selectedIban.ibanId!;
                UserDataManager()
                    .cardIbanSelectSave(selectedIban.ibanId.toString());
              }
            }
          },
          items: ibanList.map<DropdownMenuItem<String>>((Ibaninfo iban) {
            return DropdownMenuItem<String>(
              value: iban.ibanId!,
              child: Text(
                "${iban.label!} (${iban.balance})",
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'pop',
                  color: Color(0xff10245C),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class PrepaidCardTotalCostScreen extends StatefulWidget {
  const PrepaidCardTotalCostScreen({super.key});

  @override
  State<PrepaidCardTotalCostScreen> createState() =>
      _PrepaidCardTotalCostScreenState();
}

class _PrepaidCardTotalCostScreenState
    extends State<PrepaidCardTotalCostScreen> {
  final DashboardBloc _prepaidCardCostBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    _prepaidCardCostBloc.add(CardTopupAmountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _prepaidCardCostBloc,
      listener: (context, DashboardState state) {
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
        }

        if (state.cardTopUpConfirmModel?.status == 1) {
          AwesomeDialog(
            context: context,
            dismissOnTouchOutside: false,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            desc: state.cardTopUpConfirmModel?.message,
            btnCancelColor: Colors.green,
            btnCancelText: 'OK',
            buttonsTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'pop',
                fontWeight: FontWeight.w600,
                color: Colors.white),
            btnCancelOnPress: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'debitCardScreen', (route) => false);
            },
          ).show();
        }
      },
      child: BlocBuilder(
          bloc: _prepaidCardCostBloc,
          builder: (context, DashboardState state) {
            String loadAmount = state.cardTopUpFeeModel!.loadAmount.toString();
            String totalFee = state.cardTopUpFeeModel!.totalFee.toString();
            String totalPay = state.cardTopUpFeeModel!.totalPay.toString();
            String symbol = state.cardTopUpFeeModel!.symbol.toString();

            return Material(
              color: Colors.white, // Set the background color to white
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)), // Rounded top corners
              child: Container(
                height: 350,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: ProgressHUD(
                  inAsyncCall: state.isloading,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'pop',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Confirm your Topup",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 45,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 30),
                          child: const Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Topup Amount',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            Text(
                              "$symbol $loadAmount",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Fee',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            Text(
                              "$symbol $totalFee",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 30),
                          child: const Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Pay',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            Text(
                              "$symbol $totalPay",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11)),
                          child: ElevatedButton(
                              onPressed: () {
                                _prepaidCardCostBloc
                                    .add(CardTopupConfirmEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff10245C),
                                  elevation: 0,
                                  disabledBackgroundColor:
                                      const Color(0xffC4C4C4),
                                  shadowColor: Colors.transparent,
                                  minimumSize: const Size.fromHeight(40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11))),
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'pop',
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
