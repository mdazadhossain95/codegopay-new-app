import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constant_string/User.dart';
import '../../cutom_weidget/custom_navigationBar.dart';
import '../../cutom_weidget/cutom_progress_bar.dart';
import '../../cutom_weidget/input_textform.dart';
import '../Dashboard_screen/bloc/dashboard_bloc.dart';

class PrepaidCardBeneficiaryScreen extends StatefulWidget {
  const PrepaidCardBeneficiaryScreen({super.key});

  @override
  State<PrepaidCardBeneficiaryScreen> createState() =>
      _PrepaidCardBeneficiaryScreenState();
}

class _PrepaidCardBeneficiaryScreenState
    extends State<PrepaidCardBeneficiaryScreen> {
  final DashboardBloc _cardBeneficiaryBloc = DashboardBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User.Screen = 'virtual card beneficiary';
    _cardBeneficiaryBloc.add(CardDetailsEvent());
    _cardBeneficiaryBloc.add(CardBeneficiaryListEvent());
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
          body: SafeArea(
              bottom: false,
              child: BlocListener(
                  bloc: _cardBeneficiaryBloc,
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

                    if (state.deleteCardBeneficiaryModel?.status == 1) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        desc: state.deleteCardBeneficiaryModel?.message,
                        btnCancelText: 'OK',
                        btnCancelColor: Colors.green,
                        buttonsTextStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'pop',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        btnCancelOnPress: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              'prepaidCardBeneficiaryScreen', (route) => true);
                        },
                      ).show();
                    }
                  },
                  child: BlocBuilder(
                    bloc: _cardBeneficiaryBloc,
                    builder: (context, DashboardState state) {
                      return ProgressHUD(
                        inAsyncCall: state.isloading,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                'debitCardScreen',
                                                (route) => false);
                                          },
                                          child: Image.asset(
                                              "images/backarrow.png")),
                                    ),
                                    const Text(
                                      "Card Beneficiary",
                                      style: TextStyle(
                                        fontFamily: 'pop',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                )),
                            Container(
                              height: 42,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextField(
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    prefixIcon:
                                        Image.asset('images/search.png'),
                                    hintText: 'Name',
                                    hintStyle: const TextStyle(
                                      color: Color(0xffC4C4C4),
                                      fontSize: 15,
                                      fontFamily: 'pop',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff10245C),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: const BorderSide(
                                          width: 1.2,
                                          color: Color(0xff10245C),
                                        ))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                showBottomSheet(
                                  context: context,
                                  elevation: 5,
                                  builder: (context) {
                                    return const AddBeneficiaryBottomSheet();
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: const Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xff009456),
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: state.cardBeneficiaryListModel!.data!
                                      .isNotEmpty
                                  ? ListView.builder(
                                      itemCount: state.cardBeneficiaryListModel!
                                          .data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Slidable(
                                          endActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  label: 'Delete',
                                                  backgroundColor: Colors.red,
                                                  icon: Icons.delete,
                                                  onPressed: ((context) {
                                                    UserDataManager()
                                                        .cardBeneficiaryIdSave(state
                                                            .cardBeneficiaryListModel!
                                                            .data![index]
                                                            .cbeneficaryId!);
                                                    _cardBeneficiaryBloc.add(
                                                        DeleteCardBeneficiaryEvent());
                                                  }),
                                                ),
                                              ]),
                                          child: InkWell(
                                            onTap: () {
                                              UserDataManager()
                                                  .cardBeneficiaryIdSave(state
                                                      .cardBeneficiaryListModel!
                                                      .data![index]
                                                      .cbeneficaryId!);
                                              showBottomSheet(
                                                context: context,
                                                elevation: 5,
                                                builder: (context) {
                                                  return const SendMoneyBottomSheet();
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 65,
                                                        height: 65,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: const Color(
                                                                    0xffE3E3E3))),
                                                        child: Image.network(state
                                                            .userCardDetailsModel!
                                                            .userCardDetails!
                                                            .cardImage
                                                            .toString(), width: 50,),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            state
                                                                .cardBeneficiaryListModel!
                                                                .data![index]
                                                                .name!,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily: 'pop',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            "XXXX XXXX XXXX ${state
                                                                .cardBeneficiaryListModel!
                                                                .data![index]
                                                                .card!}",
                                                            style:
                                                                const TextStyle(
                                                              fontFamily: 'pop',
                                                              color: Color(
                                                                  0xffC4C4C4),
                                                              fontSize: 10,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),

                                                  Divider(
                                                    color: Colors.blueGrey.withOpacity(0.5))

                                                  // SizedBox(
                                                  //   width: 100,
                                                  //   child: Text(
                                                  //     state
                                                  //         .cardBeneficiaryListModel!
                                                  //         .data![index]
                                                  //         .card!,
                                                  //     maxLines: 2,
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     textAlign: TextAlign.right,
                                                  //     style: const TextStyle(
                                                  //         fontFamily: 'pop',
                                                  //         color:
                                                  //             Color(0xffC4C4C4),
                                                  //         fontSize: 12,
                                                  //         fontWeight:
                                                  //             FontWeight.w500),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: Text(
                                        'No Beneficiary',
                                        style: TextStyle(
                                          fontFamily: 'pop',
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      );
                    },
                  ))),
          bottomNavigationBar: CustomBottomBar(index: 3),
        ));
  }
}

class AddBeneficiaryBottomSheet extends StatefulWidget {
  const AddBeneficiaryBottomSheet({super.key});

  @override
  State<AddBeneficiaryBottomSheet> createState() =>
      _AddBeneficiaryBottomSheetState();
}

class _AddBeneficiaryBottomSheetState extends State<AddBeneficiaryBottomSheet> {
  final DashboardBloc _addCardBeneficiaryBloc = DashboardBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _addCardBeneficiaryBloc,
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
              Navigator.pushNamedAndRemoveUntil(
                  context, 'prepaidCardBeneficiaryScreen', (route) => true);
            },
          ).show();
        }
      },
      child: BlocBuilder(
          bloc: _addCardBeneficiaryBloc,
          builder: (context, DashboardState state) {
            return Material(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                height: 400,
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
                                    "Add Beneficiary",
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
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              hint: 'Email Address',
                              label: 'Email Address',
                              isEmail: false,
                              isPassword: false,
                              onChanged: () {}),
                          InputTextCustom(
                              controller: _cardNumberController,
                              keyboardType: TextInputType.number,
                              hint: 'Card Number',
                              label: 'Card Number (Last 4 Digit)',
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
                                    UserDataManager()
                                        .addCardBeneficiaryEmailSave(
                                            _emailController.text);
                                    UserDataManager()
                                        .addCardBeneficiaryCardSave(
                                            _cardNumberController.text);

                                    _addCardBeneficiaryBloc
                                        .add(AddCardBeneficiaryEvent());
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
                                  'Submit',
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

class SendMoneyBottomSheet extends StatefulWidget {
  const SendMoneyBottomSheet({super.key});

  @override
  State<SendMoneyBottomSheet> createState() => _SendMoneyBottomSheetState();
}

class _SendMoneyBottomSheetState extends State<SendMoneyBottomSheet> {
  final DashboardBloc _cardToCardTransferBloc = DashboardBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _cardNumberController.text = "00000";
    // _amountController.text = "0.00";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cardToCardTransferBloc,
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

        if (state.cardToCardTransferFeeModel?.status == 1) {
          showBottomSheet(
            context: context,
            elevation: 5,
            builder: (context) {
              return const SendMoneyDetailsBottomSheet();
            },
          );
        }
      },
      child: BlocBuilder(
          bloc: _cardToCardTransferBloc,
          builder: (context, DashboardState state) {
            return Material(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
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
                                width: 30,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Load Card",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.close_outlined,
                                      weight: 24,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // inputtextcustom(
                          //     controller: _cardNumberController,
                          //     keyboardType: TextInputType.number,
                          //     hint: 'Card Number',
                          //     label: 'Card Number',
                          //     isEmail: false,
                          //     ispassword: false,
                          //     Change: () {}),
                          InputTextCustom(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              hint: 'Amount',
                              label: 'Amount',
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
                                    UserDataManager()
                                        .cardToCardTransferAmountSave(
                                            _amountController.text);

                                    _cardToCardTransferBloc
                                        .add(CardToCardTransferFeesEvent());
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
                                  'Pay',
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

class SendMoneyDetailsBottomSheet extends StatefulWidget {
  const SendMoneyDetailsBottomSheet({super.key});

  @override
  State<SendMoneyDetailsBottomSheet> createState() =>
      _SendMoneyDetailsBottomSheetState();
}

class _SendMoneyDetailsBottomSheetState
    extends State<SendMoneyDetailsBottomSheet> {
  final DashboardBloc _cardToCardTransferFeeBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    _cardToCardTransferFeeBloc.add(CardToCardTransferFeesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cardToCardTransferFeeBloc,
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
              Navigator.pushNamedAndRemoveUntil(
                  context, 'debitCardScreen', (route) => false);
            },
          ).show();
        }
      },
      child: BlocBuilder(
          bloc: _cardToCardTransferFeeBloc,
          builder: (context, DashboardState state) {
            String currency =
                state.cardToCardTransferFeeModel!.currecny.toString();
            String amount =
                state.cardToCardTransferFeeModel!.loadCardFee.toString();
            String fee =
                state.cardToCardTransferFeeModel!.loadCardFee.toString();
            String totalPay =
                state.cardToCardTransferFeeModel!.totalPay.toString();

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
                                  "Card To Card Fee",
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     const Text(
                        //       'Amount',
                        //       textAlign: TextAlign.left,
                        //       style: TextStyle(
                        //           color: Color.fromRGBO(0, 0, 0, 1),
                        //           fontFamily: 'Poppins',
                        //           fontSize: 12,
                        //           letterSpacing:
                        //               0 /*percentages not used in flutter. defaulting to zero*/,
                        //           fontWeight: FontWeight.normal,
                        //           height: 1),
                        //     ),
                        //     Text(
                        //       "$currency $amount",
                        //       textAlign: TextAlign.left,
                        //       style: const TextStyle(
                        //           color: Color.fromRGBO(0, 0, 0, 1),
                        //           fontFamily: 'Poppins',
                        //           fontSize: 12,
                        //           letterSpacing:
                        //               0 /*percentages not used in flutter. defaulting to zero*/,
                        //           fontWeight: FontWeight.normal,
                        //           height: 1),
                        //     )
                        //   ],
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Fee',
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
                              "$currency $fee",
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
                              "$currency $totalPay",
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
                                // UserDataManager()
                                //     .cardToCardTransferSenderIdSave(fee);

                                _cardToCardTransferFeeBloc
                                    .add(CardToCardTransferConfirmEvent());
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
