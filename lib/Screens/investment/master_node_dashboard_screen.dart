import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/investment/bloc/investment_bloc.dart';
import 'package:codegopay/Screens/investment/investment_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/custom_navigationBar.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:url_launcher/url_launcher.dart';

import 'master_node_details_screen.dart';

class MasterNodeDashboardScreen extends StatefulWidget {
  MasterNodeDashboardScreen();

  // String profit;
  // String time;

  @override
  State<MasterNodeDashboardScreen> createState() =>
      _MasterNodeDashboardScreenState();
}

class _MasterNodeDashboardScreenState extends State<MasterNodeDashboardScreen> {
  bool active = false;

  bool shownotification = true;
  final InvestmentBloc _investmentBloc = InvestmentBloc();

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');

    _investmentBloc.add(NodeLogsEvent());
  }

  @override
  void initState() {
    super.initState();
    User.Screen = 'investment dashboard screen';
    _investmentBloc.add(NodeLogsEvent());
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
                          child: ProgressHUD(
                            inAsyncCall: state.isloading,
                            child: RefreshIndicator(
                              onRefresh: _onRefresh,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      appBarSection(context, state),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "images/investment/t_icon.png",
                                                    height: 85,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 3),
                                                        child: Text(
                                                            "Available balance",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff7D7D7D),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ),
                                                      Text(
                                                          "${state.nodeLogsModel?.availableBalance}",
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xff484444),
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Image.asset(
                                                "images/investment/masternode.png",
                                                height: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Total MasterNode : ${state.nodeLogsModel?.numberNode}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      125, 125, 125, 1),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  showBottomSheet(
                                                    context: context,
                                                    elevation: 5,
                                                    builder: (context) {
                                                      return const BottomSheetContentStep1();
                                                    },
                                                  );
                                                },
                                                child: Image.asset(
                                                  "images/investment/node_add.png",
                                                  height: 25,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Buy Virtual Master',
                                              style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1),
                                            ),
                                            Text(
                                              'Node',
                                              style: TextStyle(
                                                  color: Color(0xff3C14AE),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    // height: 200,
                                    child: ListView.builder(
                                        itemCount:
                                            state.nodeLogsModel?.order!.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type:
                                                      PageTransitionType.scale,
                                                  alignment: Alignment.center,
                                                  isIos: true,
                                                  duration: const Duration(
                                                      microseconds: 500),
                                                  child:
                                                      MasterNodeDetailsScreen(
                                                    // profit: widget.profit,
                                                    // time: widget.time,
                                                    orderId: state
                                                        .nodeLogsModel!
                                                        .order![index]
                                                        .orderId!,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 10),
                                              child: Container(
                                                // height: 58,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  color: Color(0xffF1EEEE),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'ID ${state.nodeLogsModel?.order![index].orderId}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                height: 1),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            '${state.nodeLogsModel?.order![index].start} / ${state.nodeLogsModel?.order![index].end}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                height: 1),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                                          child: Column(
                                                            children: [
                                                              SfLinearGauge(
                                                                axisTrackExtent: 0,
                                                                showTicks: false,
                                                                showLabels: false,
                                                                barPointers: [
                                                                  LinearBarPointer(
                                                                    value: double.parse(state.nodeLogsModel!.order![index].profitPercentage!.toString()),
                                                                    color: const Color(0xff3F56D1),
                                                                  ),
                                                                ],
                                                                markerPointers: [
                                                                  LinearWidgetPointer(
                                                                    value: double.parse(state.nodeLogsModel!.order![index].profitPercentage!.toString()),
                                                                    child: Image.asset(
                                                                      "images/investment/t_icon.png",
                                                                      height: 14,
                                                                      width: 14,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                width: 260,
                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    const Flexible(
                                                                      child: Text(
                                                                        'Profit Generated ',
                                                                        style: TextStyle(
                                                                          color: Color(0xff000000),
                                                                          fontFamily: 'Inter',
                                                                          fontSize: 6,
                                                                          fontWeight: FontWeight.normal,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child: Text(
                                                                        '${state.nodeLogsModel?.order![index].paidProfit}',
                                                                        style: const TextStyle(
                                                                          color: Color(0xff000000),
                                                                          fontFamily: 'Inter',
                                                                          fontSize: 8,
                                                                          fontWeight: FontWeight.normal,
                                                                          height: 1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Container(
                                                            alignment: Alignment.topRight,
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              '${state.nodeLogsModel?.order![index].profitPercentage}%',
                                                              style: const TextStyle(
                                                                color: Color.fromRGBO(16, 163, 13, 1),
                                                                fontFamily: 'Poppins',
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.normal,
                                                                height: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )

                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  // Container(
                                  //   alignment: Alignment.bottomCenter,
                                  //   padding:
                                  //       const EdgeInsets.symmetric(vertical: 5),
                                  //   child: Text(
                                  //     '***${widget.profit} Profit in ${widget.time}\n***Daily profit payment',
                                  //     textAlign: TextAlign.left,
                                  //     style: const TextStyle(
                                  //         color: Color.fromRGBO(0, 0, 0, 1),
                                  //         fontFamily: 'Poppins',
                                  //         fontSize: 10,
                                  //         letterSpacing:
                                  //             0 /*percentages not used in flutter. defaulting to zero*/,
                                  //         fontWeight: FontWeight.normal,
                                  //         height: 1),
                                  //   ),
                                  // )
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  isIos: true,
                  duration: const Duration(microseconds: 500),
                  child: InvestmentScreen(),
                ),
              );
            },
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              child: Image.asset(
                'images/backarrow.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
          const Row(
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
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

/*----------------step 1----------------*/

class BottomSheetContentStep1 extends StatefulWidget {
  const BottomSheetContentStep1({super.key});

  @override
  State<BottomSheetContentStep1> createState() =>
      _BottomSheetContentStep1State();
}

class _BottomSheetContentStep1State extends State<BottomSheetContentStep1> {
  final InvestmentBloc _investmentBloc = InvestmentBloc();
  List<int> dropdownList = [];
  int? _selectedValue;
  bool _acceptTerms = false;

  // Define base values
  double baseMasternodePrice = 00.00;
  double basePerDayProfit = 00.00;
  int baseTotalPaymentDays = 00;

  // Variables to hold updated values
  double masternodePrice = 00.00;
  double perDayProfit = 00.00;
  int totalPaymentDays = 0;
  double totalCostMasternode = 00.00;

  @override
  void initState() {
    super.initState();
    _investmentBloc.add(BuyMasterNodeInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _investmentBloc,
      listener: (context, InvestmentState state) {
        if (state.statusModel?.status == 0) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            dismissOnTouchOutside: false,
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

        if (state.buyMasterNodeModel?.status == 1) {
          setState(() {
            _selectedValue = 1;
            dropdownList = state.buyMasterNodeModel!.dropList!;
            baseMasternodePrice =
                double.parse(state.buyMasterNodeModel!.masternodePrice!);
            basePerDayProfit =
                double.parse(state.buyMasterNodeModel!.perDayProfit!);
            baseTotalPaymentDays =
                int.parse(state.buyMasterNodeModel!.totalPaymentDay!);

            masternodePrice = baseMasternodePrice;
            perDayProfit = basePerDayProfit * _selectedValue!;
            totalPaymentDays = baseTotalPaymentDays;
            totalCostMasternode = baseMasternodePrice * _selectedValue!;
          });
        }

        if (state.statusModel?.status == 1) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            dismissOnTouchOutside: false,
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
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  isIos: true,
                  duration: const Duration(microseconds: 500),
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
          ).show();
        }
      },
      child: BlocBuilder(
          bloc: _investmentBloc,
          builder: (context, InvestmentState state) {
            return Material(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)), // Rounded top corners
              child: Container(
                height: 420,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                        20), // Match the border radius of Material
                  ),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xff797777),
                      width: 2, // Set the thickness of the top border
                    ),
                  ),
                ),
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
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ),
                            Container(
                              height: 2,
                              width: 141,
                              alignment: Alignment.center,
                              decoration:
                                  const BoxDecoration(color: Color(0xff6F6E6E)),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'Cancel',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.transparent,
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Buy Virtual Master',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    height: 1),
                              ),
                              Text(
                                'Node',
                                style: TextStyle(
                                    color: Color(0xff3C14AE),
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 315,
                          // height: 293,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color.fromRGBO(241, 238, 238, 1),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'how many masternodes\ndo you want to purchase?',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: DropdownButtonFormField<int>(
                                        value: _selectedValue ?? 1,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 5.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                          ),
                                          // hintText: '0',
                                        ),
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            _selectedValue = newValue;
                                            if (newValue != null) {
                                              // masternodePrice =
                                              //     baseMasternodePrice *
                                              //         newValue;
                                              perDayProfit =
                                                  basePerDayProfit * newValue;
                                              totalPaymentDays =
                                                  baseTotalPaymentDays;
                                              totalCostMasternode =
                                                  baseMasternodePrice *
                                                      newValue;; // Already updated
                                            }
                                          });
                                        },
                                        items: dropdownList
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(value.toString()),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'MasterNode Price',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                    Text(
                                      '${masternodePrice.toStringAsFixed(2)} ${state.buyMasterNodeModel!.coin!.toUpperCase()}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          height: 1),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Profit per day',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                    Text(
                                      '${perDayProfit.toStringAsFixed(2)} ${state.buyMasterNodeModel!.coin!.toUpperCase()}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          height: 1),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total payment days',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                    Text(
                                      '${totalPaymentDays.toStringAsFixed(2)} Days',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          height: 1),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total Cost Masternode',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                    Text(
                                      '${totalCostMasternode.toStringAsFixed(2)} ${state.buyMasterNodeModel!.coin!.toUpperCase()}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _acceptTerms,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _acceptTerms = newValue ?? false;
                                      });
                                    },
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Accept ',
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: 'Inter',
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'terms and conditions',
                                          style: const TextStyle(
                                            color: Color(0xff5349CA),
                                            fontFamily: 'Inter',
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            height: 1,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              var url = state
                                                  .buyMasterNodeModel!
                                                  .termsCondition!;
                                              if (await canLaunchUrl(
                                                  Uri.parse(url))) {
                                                await launchUrl(Uri.parse(url));
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 35,
                                width: double.infinity,
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: ElevatedButton(
                                    onPressed: _acceptTerms
                                        ? () {
                                            // Handle the button press action here
                                            // print("chek box");

                                            _investmentBloc.add(NodeOrderEvent(
                                                numberOfNode: _selectedValue!));
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff3C14AE),
                                        elevation: 0,
                                        disabledBackgroundColor:
                                            const Color(0xffC4C4C4),
                                        shadowColor: Colors.transparent,
                                        minimumSize: const Size.fromHeight(40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(11))),
                                    child: const Text(
                                      'pay',
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
