import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Card_screen/Activate_debitcard.dart';
import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/Screens/Profile_screen/Profile_screen.dart';
import 'package:codegopay/constant_string/User.dart';

import 'package:codegopay/cutom_weidget/custom_navigationBar.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class OrderCardScreen extends StatefulWidget {
  const OrderCardScreen({super.key});

  @override
  State<OrderCardScreen> createState() => _OrderCardScreenState();
}

class _OrderCardScreenState extends State<OrderCardScreen> {
  bool active = false;

  bool shownotification = true;
  DashboardBloc _dashboardBloc = new DashboardBloc();

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');

    _dashboardBloc.add(DashboarddataEvent());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User.Screen = 'order card';

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
                if (state.cardordermodel?.status == 1) {
                  User.cardexits = state.cardordermodel?.isCardOrder;
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
                      _dashboardBloc.add(checkcardEvent());
                    },
                  ).show();
                } else if (state.statusModel?.status == 0) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    desc: state.debitFees?.message,
                    btnCancelText: 'OK',
                    buttonsTextStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'pop',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    btnCancelOnPress: () {},
                  ).show();
                }

                if (state.debitFees?.status == 0) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    desc: state.debitFees?.message,
                    btnCancelText: 'OK',
                    buttonsTextStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'pop',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    btnCancelOnPress: () {},
                  ).show();
                } else if (state.debitFees?.status == 1) {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.scale,
                          btnCancelText: 'Confirm',
                          body: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Cost of card : ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'pop'),
                                    ),
                                    Text(
                                      '${state.debitFees?.symbol}'
                                      '${state.debitFees?.serviceFee}',
                                      style: const TextStyle(
                                          color: Color(0xff0BEA2E),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'pop'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                state.debitFees?.isShipping == 1
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Shipping Cost :  ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'pop'),
                                          ),
                                          Text(
                                            '${state.debitFees?.symbol}'
                                            '${state.debitFees?.shippingCost}',
                                            style: const TextStyle(
                                                color: Color(0xff0BEA2E),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'pop'),
                                          )
                                        ],
                                      )
                                    : Container(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);

                                        _dashboardBloc.add(confirmdebitorder());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff10245C),
                                          minimumSize:
                                              const Size.fromHeight(40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      child: const Text(
                                        "Confirm order",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'pop',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                          ),
                          buttonsTextStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'pop',
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          btnOkColor: const Color(0xff2C2C2C))
                      .show();
                }
              },
              child: BlocBuilder(
                  bloc: _dashboardBloc,
                  builder: (context, DashboardState state) {
                    return SafeArea(
                      child: ProgressHUD(
                        inAsyncCall: state.isloading,
                        child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              state.dashboardModel!.balance!,
                                              style: const TextStyle(
                                                  color: Color(0xff2C2C2C),
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'pop'),
                                            )
                                          ],
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
                                              Navigator.pushReplacement(
                                                context,
                                                PageTransition(
                                                  type:
                                                      PageTransitionType.scale,
                                                  alignment: Alignment.center,
                                                  isIos: true,
                                                  duration: const Duration(
                                                      microseconds: 500),
                                                  child: const ProfileScreen(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 70,
                                              height: 70,
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
                              Container(
                                alignment: Alignment.center,
                                child: Image.asset('images/cardex.png'),
                              ),
                              Expanded(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                    User.cardexits == 0
                                        ? Container(
                                            height: 60,

                                            width: double.infinity,

                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 25),

                                            //                     background: linear-gradient(0deg, #10245C, #10245C),
                                            // linear-gradient(0deg, #4E17C1, #4E17C1);

                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xff009456),
                                                      Color(0xff009456)
                                                    ],
                                                    transform:
                                                        GradientRotation(0)),
                                                borderRadius:
                                                    BorderRadius.circular(11)),

                                            child: ElevatedButton(
                                                onPressed: () {
                                                  _dashboardBloc.add(
                                                      OrdercardEvent(
                                                          type: 'order'));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shadowColor: Colors
                                                        .transparent,
                                                    backgroundColor: Colors
                                                        .transparent,
                                                    minimumSize: const Size
                                                        .fromHeight(40),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11))),
                                                child: const Text(
                                                  'Order Card',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: 'pop',
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      height: 60,
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25),

                                      //                     background: linear-gradient(0deg, #10245C, #10245C),
                                      // linear-gradient(0deg, #4E17C1, #4E17C1);

                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xff10245C),
                                              Color(0xff10245C)
                                            ],
                                            transform: GradientRotation(0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(11)),

                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                  child: activateDebitCard(),
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  alignment: Alignment.center,
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  reverseDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                ));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              shadowColor: Colors.transparent,
                                              minimumSize:
                                                  const Size.fromHeight(40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11))),
                                          child: const Text(
                                            'Activate card',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: 'pop',
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 100,
                                    ),
                                  ]))
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
          bottomNavigationBar: CustomBottomBar(index: 3),
        ));
  }
}
