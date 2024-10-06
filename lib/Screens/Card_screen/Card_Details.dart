import 'package:awesome_card/awesome_card.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/Screens/Profile_screen/Profile_screen.dart';
import 'package:codegopay/Screens/pin_verify/Pin_Verify_Screen.dart';
import 'package:codegopay/constant_string/User.dart';

import 'package:codegopay/cutom_weidget/custom_navigationBar.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  bool cardback = false;
  final DashboardBloc _dashboardBloc = DashboardBloc();

  double initialValue = 0;
  double max = 20000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User.Screen = 'card Details';

    _dashboardBloc.add(DebitcarddetailsEvent());

    _dashboardBloc.add(DashboarddataEvent());
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
              bloc: _dashboardBloc,
              listener: (context, DashboardState state) {
                if (state.cardDetails?.status == 1) {
                  initialValue = double.parse(state
                      .cardDetails!.cardDetails!.spent!
                      .replaceAll('€', ''));
                  max = double.parse(state.cardDetails!.cardDetails!.spend!
                      .replaceAll('€', ''));
                }

                if (state.debitcardinfo?.status == 1) {
                  showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      )),
                      builder: (context) {
                        return StatefulBuilder(builder: (BuildContext context,
                            StateSetter setState /*You can rename this!*/) {
                          return Column(
                            children: [
                              const SizedBox(height: 20),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3 -
                                          50),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardback == true
                                          ? cardback = false
                                          : cardback = true;
                                    });
                                  },
                                  child: CreditCard(
                                    cardNumber: state
                                        .debitcardinfo!.cardDetails!.cardNumber,
                                    cardExpiry: state
                                        .debitcardinfo!.cardDetails!.expiryDate,
                                    cardHolderName: ' ',
                                    cvv: state.debitcardinfo!.cardDetails!.cvv,
                                    showBackSide: cardback,

                                    frontBackground: CardBackgrounds.black,
                                    backBackground: CardBackgrounds.white,
                                    showShadow: true,
                                    // mask: getCardTypeMask(cardType: CardType.americanExpress),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'click on the card to see CVV',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'livic',
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          );
                        });
                      });
                } else if (state.debitcardinfo?.status == 0) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    desc: state.debitcardinfo?.message,
                    btnCancelText: 'OK',
                    btnCancelColor: Colors.green,
                    buttonsTextStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'pop',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    btnCancelOnPress: () {},
                  ).show();
                }

                if (state.statusModel?.status == 1) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    desc: state.statusModel?.message,
                    btnCancelText: 'OK',
                    btnCancelColor: Colors.green,
                    buttonsTextStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'pop',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    btnCancelOnPress: () {
                      _dashboardBloc.add(DebitcarddetailsEvent());
                    },
                  ).show();
                } else if (state.statusModel?.status == 0) {
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
              },
              child: BlocBuilder(
                  bloc: _dashboardBloc,
                  builder: (context, DashboardState state) {
                    return SafeArea(
                      child: ProgressHUD(
                        inAsyncCall: state.isloading,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'YOUR BALANCE',
                                        style: TextStyle(
                                            color: Color(0xffC4C4C4),
                                            fontFamily: 'pop',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '€',
                                            style: TextStyle(
                                                color: Color(0xff2C2C2C),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'pop'),
                                          ),
                                          Text(
                                            state.cardDetails!.debitbalance!,
                                            style: const TextStyle(
                                                color: Color(0xff2C2C2C),
                                                fontSize: 40,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'pop'),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        'DEBIT WALLET',
                                        style: TextStyle(
                                            color: Color(0xff525252),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    height: 85,
                                    width: 80,
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.scale,
                                                alignment: Alignment.center,
                                                isIos: true,
                                                duration: const Duration(
                                                    microseconds: 500),
                                                child: const ProfileScreen(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.centerRight,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  state.dashboardModel!
                                                      .profileimage!),
                                              radius: 35,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          alignment: Alignment.topLeft,
                                          child: Image.asset(
                                              'images/message-question.png'),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            state.cardDetails!.cardImage != ''
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    alignment: Alignment.center,
                                    child: Image.network(
                                        state.cardDetails!.cardImage!),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Image.asset('images/cardex.png'),
                                  ),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                            child: CardPinVerifyScreen(),
                                            type:
                                                PageTransitionType.bottomToTop,
                                            alignment: Alignment.center,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            reverseDuration: const Duration(
                                                milliseconds: 200),
                                          )).then((value) async {
                                        if (value == true) {
                                          String userPin =
                                              await UserDataManager().getPin();

                                          _dashboardBloc.add(ResetCardPinEvent(
                                              cardId: state.cardDetails!
                                                  .cardDetails!.cardId,
                                              cardPin: userPin));
                                        }
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 35,
                                          alignment: Alignment.center,
                                          child:
                                              Image.asset('images/pincode.png'),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Resend Pin',
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: 12,
                                              fontFamily: 'pop'),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _dashboardBloc.add(
                                        UpdateCardSettingEvent(
                                          cardId: state
                                              .cardDetails!.cardDetails!.cardId,
                                          settingName: 'card_lock',
                                          settingValue: state.cardDetails!
                                                      .cardDetails?.cardLock ==
                                                  '1'
                                              ? '0'
                                              : '1',
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 35,
                                          alignment: Alignment.center,
                                          child: state.cardDetails!.cardDetails!
                                                      .cardLock ==
                                                  '1'
                                              ? Image.asset('images/lock.png')
                                              : Image.asset(
                                                  'images/unlocked.png'),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          state.cardDetails!.cardDetails!
                                                      .cardLock ==
                                                  '1'
                                              ? 'Lock Card'
                                              : 'Unlock Card',
                                          style: const TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: 12,
                                              fontFamily: 'pop'),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                            child: CardPinVerifyScreen(),
                                            type:
                                                PageTransitionType.bottomToTop,
                                            alignment: Alignment.center,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            reverseDuration: const Duration(
                                                milliseconds: 200),
                                          )).then((value) async {
                                        if (value == true) {
                                          String userPin =
                                              await UserDataManager().getPin();

                                          _dashboardBloc.add(debitcardinfoevent(
                                              pin: userPin,
                                              cardid: state.cardDetails!
                                                  .cardDetails!.cardId));
                                        }
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 35,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                              Icons.remove_red_eye_outlined),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Show Details',
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: 12,
                                              fontFamily: 'pop'),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                'Montlhy 00 Statistic',
                                style: TextStyle(
                                    color: const Color(0xff000000)
                                        .withOpacity(0.8),
                                    fontFamily: 'pop',
                                    fontSize: 12),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: IgnorePointer(
                                    ignoring: true,
                                    child: SleekCircularSlider(
                                      onChangeStart: (double value) {},
                                      onChangeEnd: (double value) {},
                                      onChange: (v) {},
                                      appearance: CircularSliderAppearance(
                                          angleRange: 365,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4.2,
                                          startAngle: 0,
                                          infoProperties:
                                              InfoProperties(modifier: (v) {
                                            return v.toString();
                                          }),
                                          animationEnabled: false,
                                          spinnerMode: false,
                                          spinnerDuration: 1000,
                                          counterClockwise: false,
                                          customColors: CustomSliderColors(
                                              trackColor:
                                                  const Color(0xff2D2E53),
                                              progressBarColors: [
                                                const Color(0xff61DE70),
                                                const Color(0xff0DA6C2),
                                                const Color(0xff0E39C6),
                                                const Color(0xff320DAF),
                                                const Color(0xff9327F0)
                                              ]),
                                          customWidths: CustomSliderWidths(
                                              handlerSize: 0,
                                              progressBarWidth: 25,
                                              trackWidth: 25,
                                              shadowWidth: 10)),
                                      initialValue: initialValue,
                                      max: max,
                                      min: 0,
                                      innerWidget: (c) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              state.cardDetails!.cardDetails!
                                                      .spent ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color(0xff000000),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Text(
                                              'Limit to spend',
                                              style: TextStyle(
                                                  color: Color(0xff7B78AA),
                                                  fontSize: 13,
                                                  fontFamily: 'pop',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              state.cardDetails!.cardDetails!
                                                      .spend ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: const Color(0xff000000)
                                                      .withOpacity(0.5),
                                                  fontSize: 15,
                                                  fontFamily: 'pop'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Spent Today',
                                        style: TextStyle(
                                            color: Color(0xff525252),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        state.cardDetails!.cardDetails!
                                                .spendtoday ??
                                            '',
                                        style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      const Text(
                                        'Spent Last 30 days',
                                        style: TextStyle(
                                            color: Color(0xff525252),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      Text(
                                        state.cardDetails!.cardDetails!.spent ??
                                            '',
                                        style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      const Text(
                                        'Available  Month',
                                        style: TextStyle(
                                            color: Color(0xff525252),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      Text(
                                        state.cardDetails!.cardDetails!.spend ??
                                            '',
                                        style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      ),

                                    ],
                                  )),
                            ])
                          ],
                        ),
                      ),
                    );
                  })),
          bottomNavigationBar: CustomBottomBar(index: 3),
        ));
  }
}
