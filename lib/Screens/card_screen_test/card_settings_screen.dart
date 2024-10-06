import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Models/card/card_replace_model.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../constant_string/User.dart';
import '../../cutom_weidget/custom_navigationBar.dart';
import '../../cutom_weidget/cutom_progress_bar.dart';
import '../../cutom_weidget/input_textform.dart';
import '../Dashboard_screen/bloc/dashboard_bloc.dart';
import '../Profile_screen/Profile_screen.dart';

class CardSettingsScreen extends StatefulWidget {
  const CardSettingsScreen({super.key});

  @override
  State<CardSettingsScreen> createState() => _CardSettingsScreenState();
}

class _CardSettingsScreenState extends State<CardSettingsScreen> {
  bool active = false;
  int? _onlinePayment; // Use nullable int to represent initial loading state
  int? _recurringPayments;
  int? _contactless;
  int? _pinBlockUnblock;
  String symbol = "";

  String? _isVirtual;

  final DashboardBloc _cardSettingBloc = DashboardBloc();

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');

    _cardSettingBloc.add(DashboarddataEvent());
    _cardSettingBloc.add(CardDetailsEvent());
  }

  @override
  void initState() {
    super.initState();
    User.Screen = 'card Settings Screen';

    _cardSettingBloc.add(DashboarddataEvent());
    _cardSettingBloc.add(CardDetailsEvent());
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
              bloc: _cardSettingBloc,
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
                  _onlinePayment = int.parse(state.userCardDetailsModel!
                      .userCardDetails!.cardSetting!.online
                      .toString());
                  _pinBlockUnblock = int.parse(state.userCardDetailsModel!
                      .userCardDetails!.cardSetting!.atmlBlock
                      .toString());
                  _recurringPayments = int.parse(state.userCardDetailsModel!
                      .userCardDetails!.cardSetting!.recurring
                      .toString());
                  _contactless = int.parse(state.userCardDetailsModel!
                      .userCardDetails!.cardSetting!.contactless
                      .toString());

                  _isVirtual = state
                      .userCardDetailsModel!.userCardDetails!.cardMaterial
                      .toString();

                  print("----------check-----------");
                  print(_onlinePayment.toString());
                  print(_recurringPayments.toString());
                  print(_contactless.toString());
                  print(_pinBlockUnblock.toString());
                  print("----------check-----------");
                  symbol = state.userCardDetailsModel!.userCardDetails!.symbol
                      .toString();
                }

                if (state.cardBlockUnblockModel?.status == 1) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    desc: state.cardBlockUnblockModel?.message,
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

                if (state.cardReplaceModel?.status == 1) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    desc: state.cardReplaceModel?.message,
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
              },
              child: BlocBuilder(
                  bloc: _cardSettingBloc,
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
                                settingSection(context, state),
                                settingsOptions(context, state),
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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.pushNamedAndRemoveUntil(
              //     context, 'cardScreen', (route) => false);

              Navigator.pushNamedAndRemoveUntil(
                  context, 'debitCardScreen', (route) => false);

              // Navigator.pop(context);
            },
            child: Image.asset(
              "images/backarrow.png",
              color: const Color(0xff373737),
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(
            width: 10,
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
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  settingSection(BuildContext context, DashboardState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isVirtual == "virtual"
              ? Container()
              : GestureDetector(
                  onTap: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            desc: "Do you want to replace card?",
                            animType: AnimType.rightSlide,
                            dismissOnTouchOutside: true,
                            btnCancelText: "No",
                            btnOkText: "Yes",
                            buttonsTextStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'pop',
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            btnOkOnPress: () {
                              _cardSettingBloc.add(CardReplaceEvent());
                            },
                            btnCancelOnPress: () {})
                        .show();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 116,
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffEDEBEB),
                    ),
                    child: const Text(
                      'Replace Card',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff322779),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                  ),
                ),
          GestureDetector(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                dismissOnTouchOutside: true,
                btnCancelText: "Permanent Block",
                btnOkText: "Temporary Block",
                buttonsTextStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                btnOkOnPress: () {
                  UserDataManager().cardBlockUnblockStatusSave("block");
                  _cardSettingBloc.add(CardBlockUnblockEvent());
                },
                btnCancelOnPress: () {
                  UserDataManager().cardBlockUnblockStatusSave("pblock");
                  _cardSettingBloc.add(CardBlockUnblockEvent());
                },
              ).show();
            },
            child: Container(
              alignment: Alignment.center,
              width: 116,
              height: 41,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffEDEBEB),
              ),
              child: const Text(
                'Block Card',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffEA1E1E),
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  settingsOptions(BuildContext context, DashboardState state) {
    return Column(
      children: [
        _isVirtual == "virtual"
            ? Container()
            : Container(
                height: 60,
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
                            state.userCardDetailsModel!.userCardDetails!
                                .cardImage
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
                                child: Icon(
                                  Icons.error_outline, // Use the error icon
                                  color: Colors.grey,
                                  // Set the color of the error icon
                                  size: 30.0, // Set the size of the error icon
                                ),
                              );
                            },
                          ),
                        ),
                        const Text(
                          'POS Daily Limit',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          elevation: 5,
                          builder: (context) {
                            return const DailyLimitWidget();
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                symbol,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                state.userCardDetailsModel!.userCardDetails!
                                    .cardSetting!.dailyLimit
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
        Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          padding: const EdgeInsets.only(right: 10),
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
                          child: Icon(
                            Icons.error_outline, // Use the error icon
                            color: Colors.grey,
                            // Set the color of the error icon
                            size: 30.0, // Set the size of the error icon
                          ),
                        );
                      },
                    ),
                  ),
                  const Text(
                    'Online Payments',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              _onlinePayment == null // Check if data is still loading
                  ? Container() // Show loading indicator if data is loading
                  : _SwitchWidget(
                      initialValue: _onlinePayment == 1,
                      onChanged: (value) {
                        // Update _onlinePayment when the switch is toggled
                        setState(() {
                          _onlinePayment = value ? 1 : 0;
                          print(_onlinePayment.toString());
                        });

                        UserDataManager()
                            .cardOnlineSave(_onlinePayment.toString());
                        _cardSettingBloc.add(CardSettingsEvent());
                      },
                    )
            ],
          ),
        ),
        _isVirtual == "virtual"
            ? Container()
            : Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                padding: const EdgeInsets.only(right: 10),
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
                            state.userCardDetailsModel!.userCardDetails!
                                .cardImage
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
                                child: Icon(
                                  Icons.error_outline, // Use the error icon
                                  color: Colors.grey,
                                  // Set the color of the error icon
                                  size: 30.0, // Set the size of the error icon
                                ),
                              );
                            },
                          ),
                        ),
                        const Text(
                          'Pin Block',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    _pinBlockUnblock == null // Check if data is still loading
                        ? Container() // Show loading indicator if data is loading
                        : _SwitchWidget(
                            initialValue: _pinBlockUnblock == 1,
                            onChanged: (value) {
                              // Update _onlinePayment when the switch is toggled
                              setState(() {
                                _pinBlockUnblock = value ? 1 : 0;
                                print(_pinBlockUnblock.toString());
                              });

                              UserDataManager().pinBlockUnblockSave(
                                  _pinBlockUnblock.toString());
                              _cardSettingBloc.add(CardSettingsEvent());
                            },
                          )
                  ],
                ),
              ),
        Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          padding: const EdgeInsets.only(right: 10),
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
                          child: Icon(
                            Icons.error_outline, // Use the error icon
                            color: Colors.grey,
                            // Set the color of the error icon
                            size: 30.0, // Set the size of the error icon
                          ),
                        );
                      },
                    ),
                  ),
                  const Text(
                    'Recurring Payments',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              _recurringPayments == null // Check if data is still loading
                  ? Container() // Show loading indicator if data is loading
                  : _SwitchWidget(
                      initialValue: _recurringPayments == 1,
                      onChanged: (value) {
                        // Update _onlinePayment when the switch is toggled
                        setState(() {
                          _recurringPayments = value ? 1 : 0;
                          print(_recurringPayments.toString());
                        });

                        UserDataManager()
                            .cardRecurringSave(_recurringPayments.toString());
                        _cardSettingBloc.add(CardSettingsEvent());
                      },
                    )
            ],
          ),
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          padding: const EdgeInsets.only(right: 10),
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
                          child: Icon(
                            Icons.error_outline, // Use the error icon
                            color: Colors.grey,
                            // Set the color of the error icon
                            size: 30.0, // Set the size of the error icon
                          ),
                        );
                      },
                    ),
                  ),
                  const Text(
                    'Contactless',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              _contactless == null // Check if data is still loading
                  ? Container() // Show loading indicator if data is loading
                  : _SwitchWidget(
                      initialValue: _contactless == 1,
                      onChanged: (value) {
                        // Update _onlinePayment when the switch is toggled
                        setState(() {
                          _contactless = value ? 1 : 0;
                          print(_contactless.toString());
                        });

                        UserDataManager()
                            .cardContactlessSave(_contactless.toString());
                        _cardSettingBloc.add(CardSettingsEvent());
                      },
                    )
            ],
          ),
        ),
        Container(
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
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.grey,
                            size: 30.0,
                          ),
                        );
                      },
                    ),
                  ),
                  const Text(
                    'Contactless limit',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          elevation: 5,
                          builder: (context) {
                            return _isVirtual == "virtual"
                                ? const VirtualDailyLimitWidget()
                                : const DailyLimitWidget();
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symbol,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            state.userCardDetailsModel!.userCardDetails!
                                .cardSetting!.contactlessLimit
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 17,
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
        ),
      ],
    );
  }
}

class _SwitchWidget extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const _SwitchWidget({
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<_SwitchWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
        widget.onChanged(value);
      },
    );
  }
}

class DailyLimitWidget extends StatefulWidget {
  const DailyLimitWidget({super.key});

  @override
  State<DailyLimitWidget> createState() => _DailyLimitWidgetState();
}

class _DailyLimitWidgetState extends State<DailyLimitWidget> {
  final DashboardBloc _cardSettingBloc = DashboardBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dailyLimitAmountController =
      TextEditingController();
  final TextEditingController _contactlassLimitAmountController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardSettingBloc.add(CardDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cardSettingBloc,
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

        if (state.cardSettingsModel?.status == 1) {
          UserDataManager().cardNumberShowSave("false");
          Navigator.pushNamedAndRemoveUntil(
              context, 'cardSettingsScreen', (route) => true);
        }
      },
      child: BlocBuilder(
          bloc: _cardSettingBloc,
          builder: (context, DashboardState state) {
            _dailyLimitAmountController.text = state
                .userCardDetailsModel!.userCardDetails!.cardSetting!.dailyLimit
                .toString();
            _contactlassLimitAmountController.text = state.userCardDetailsModel!
                .userCardDetails!.cardSetting!.contactlessLimit
                .toString();
            return Material(
              color: Colors.white, // Set the background color to white
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)), // Rounded top corners
              child: Container(
                height: 370,
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
                                    "Limits",
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
                          InputTextCustom(
                              controller: _dailyLimitAmountController,
                              hint: 'daily limit',
                              label: 'POS Daily Limit',
                              isEmail: false,
                              isPassword: false,
                              onChanged: () {}),
                          InputTextCustom(
                              controller: _contactlassLimitAmountController,
                              hint: 'contactless limit',
                              label: 'Contactless Limit',
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
                                    // All fields are valid, continue with the action
                                    UserDataManager().cardDailyLimitSave(
                                        _dailyLimitAmountController.text);
                                    UserDataManager().cardContactlessLimitSave(
                                        _contactlassLimitAmountController.text);

                                    _cardSettingBloc.add(CardSettingsEvent());
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

class VirtualDailyLimitWidget extends StatefulWidget {
  const VirtualDailyLimitWidget({super.key});

  @override
  State<VirtualDailyLimitWidget> createState() =>
      _VirtualDailyLimitWidgetState();
}

class _VirtualDailyLimitWidgetState extends State<VirtualDailyLimitWidget> {
  final DashboardBloc _cardSettingBloc = DashboardBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _contactlassLimitAmountController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardSettingBloc.add(CardDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cardSettingBloc,
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

        if (state.cardSettingsModel?.status == 1) {
          UserDataManager().cardNumberShowSave("false");
          Navigator.pushNamedAndRemoveUntil(
              context, 'cardSettingsScreen', (route) => true);
        }
      },
      child: BlocBuilder(
          bloc: _cardSettingBloc,
          builder: (context, DashboardState state) {
            _contactlassLimitAmountController.text = state.userCardDetailsModel!
                .userCardDetails!.cardSetting!.contactlessLimit
                .toString();
            return Material(
              color: Colors.white, // Set the background color to white
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)), // Rounded top corners
              child: Container(
                height: 370,
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
                                    "Limits",
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
                          InputTextCustom(
                              controller: _contactlassLimitAmountController,
                              hint: 'contactless limit',
                              label: 'Contactless Limit',
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
                                    // All fields are valid, continue with the action
                                    UserDataManager().cardDailyLimitSave("");
                                    UserDataManager().cardContactlessLimitSave(
                                        _contactlassLimitAmountController.text);

                                    _cardSettingBloc.add(CardSettingsEvent());
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
