import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/investment/bloc/investment_bloc.dart';
import 'package:codegopay/Screens/investment/master_node_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/custom_navigationBar.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:page_transition/page_transition.dart';

import '../crypto_screen/staking_overivew.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({super.key});

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  bool active = false;

  bool shownotification = true;
  final InvestmentBloc _investmentBloc = InvestmentBloc();

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');

    _investmentBloc.add(NodeCheckModuleEvent());
  }

  @override
  void initState() {
    super.initState();
    User.Screen = 'Investment screen';

    _investmentBloc.add(NodeCheckModuleEvent());
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
          body: Stack(
            children: [
              BlocListener(
                  bloc: _investmentBloc,
                  listener: (context, InvestmentState state) {
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
                  },
                  child: BlocBuilder(
                      bloc: _investmentBloc,
                      builder: (context, InvestmentState state) {
                        return SafeArea(
                          child: User.hidepage == 1
                              ? const Scaffold(
                                  body: Center(
                                      child: Text(
                                    'Service Not Available',
                                    style: TextStyle(
                                        color: Color(0xff26273C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'pop'),
                                  )),
                                )
                              : ProgressHUD(
                                  inAsyncCall: state.isloading,
                                  child: RefreshIndicator(
                                    onRefresh: _onRefresh,
                                    child: ListView(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        appBarSection(context, state),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .scale,
                                                    alignment: Alignment.center,
                                                    isIos: true,
                                                    duration: const Duration(
                                                        microseconds: 500),
                                                    child: StakingOverviewScreen(
                                                        symbol:
                                                            "${state.nodeCheckModuleModel?.wlMasternode!}")));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 20),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16),
                                              ),
                                              color: const Color(0xffF0EFEF),
                                              border: Border.all(
                                                color: const Color(0xffA4A2A2),
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "images/investment/t_icon.png",
                                                  height: 85,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 3),
                                                      child: Text("Staking",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ),
                                                    Text(
                                                        "${state.nodeCheckModuleModel?.wlMasternode!.toUpperCase()}",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xff489A83),
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ],
                                                ),
                                                // images/investment/right-arrow.png
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 3),
                                                  child: Image.asset(
                                                    "images/investment/right-arrow.png",
                                                    height: 24,
                                                  ),
                                                ),
                                                Text(
                                                  'Guaranteed earnings\nup to ${state.nodeCheckModuleModel?.stakingProfit} per month',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Color(0xff000000),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  '*** Profit credited every month\n*** You can unlock your investment\nwhenever you want',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color(0xff777575),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height: 1),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.scale,
                                                alignment: Alignment.center,
                                                isIos: true,
                                                duration: const Duration(
                                                    microseconds: 500),
                                                child: MasterNodeDashboardScreen(
                                                    // profit: state
                                                    //     .nodeCheckModuleModel!
                                                    //     .enduserMasternodeProfit!,
                                                    // time: state
                                                    //     .nodeCheckModuleModel!
                                                    //     .period!,
                                                    ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 20),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16),
                                              ),
                                              color: const Color(0xffF0EFEF),
                                              border: Border.all(
                                                color: const Color(0xffA4A2A2),
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Image.asset(
                                                    "images/investment/masternode.png",
                                                    height: 115,
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 3),
                                                  child: Image.asset(
                                                    "images/investment/right-arrow.png",
                                                    height: 24,
                                                  ),
                                                ),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Buy Virtual Master',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff000000),
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1),
                                                    ),
                                                    Text(
                                                      'Node',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff3C14AE),
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'up to ${state.nodeCheckModuleModel?.investmentProfit} per month',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Color(0xff000000),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      const TextSpan(
                                                        text: '***',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            height: 1),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '${state.nodeCheckModuleModel?.enduserMasternodeProfit}',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 1),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' Profit in ${state.nodeCheckModuleModel?.period} years\n***Daily profit payment',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            height: 1),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        );
                      })),
            ],
          ),
          bottomNavigationBar: CustomBottomBar(index: 2),
        ));
  }

  appBarSection(BuildContext context, state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Investment',
                  style: TextStyle(
                      color: Color(0xff2C2C2C),
                      fontFamily: 'pop',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Dashboard',
                style: TextStyle(
                    color: Color(0xff009456),
                    fontFamily: 'pop',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
