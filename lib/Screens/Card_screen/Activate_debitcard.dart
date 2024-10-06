import 'package:awesome_card/awesome_card.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Dashboard_screen/Dashboard_screen.dart';
import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/utils/custom_scroll_behavior.dart';
import 'package:codegopay/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../cutom_weidget/cutom_progress_bar.dart';

class activateDebitCard extends StatefulWidget {
  static const id = 'activateDebitCard';

  activateDebitCard();

  @override
  _AddInternalBinficaryState createState() => _AddInternalBinficaryState();
}

class _AddInternalBinficaryState extends State<activateDebitCard> {
  final DashboardBloc _cardBloc = DashboardBloc();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryMonthController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _lastdigitsController = TextEditingController();
  final TextEditingController _activationcodeController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  bool flap = false;

  @override
  void initState() {
    _cardBloc.add(debitcardfees(type: "activate"));

    User.Screen = 'activate card';

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: BlocListener(
            bloc: _cardBloc,
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
              } else if (state.statusModel?.status == 1) {
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
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        alignment: Alignment.center,
                        isIos: true,
                        duration: const Duration(milliseconds: 200),
                        child: const DashboardScreen(),
                      ),
                    );
                  },
                ).show();
              }
            },
            child: BlocBuilder(
                bloc: _cardBloc,
                builder: (context, DashboardState state) {
                  return ProgressHUD(
                    inAsyncCall: state.isloading,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      height: double.maxFinite,
                      child: ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20, left: 20, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
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
                                  const Expanded(
                                      child: Center(
                                    child: Text(
                                      'Activate Debit-Card',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'pop',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                                  Container(
                                    width: 30,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                            CreditCard(
                              cardNumber: _cardNumberController.text,
                              cardExpiry: _expiryMonthController.text,
                              cardHolderName: ' ',
                              cvv: _cvvController.text,
                              showBackSide: flap,

                              frontBackground: CardBackgrounds.black,
                              backBackground: CardBackgrounds.white,
                              showShadow: true,
                              // mask: getCardTypeMask(cardType: CardType.americanExpress),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 15,
                                        color: Colors.white12,
                                        offset: Offset(0, 0),
                                        spreadRadius: 1)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Cost of activation  ",
                                        style: TextStyle(
                                            color: Color(0xff2C2C2C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      ),
                                      state.debitFees != null
                                          ? Text(
                                              '${state.debitFees!.symbol}'
                                              '${state.debitFees!.serviceFee}',
                                              style: const TextStyle(
                                                  color: Color(0xff0BEA2E),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'pop'),
                                            )
                                          : Container()
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          controller: _cardNumberController,
                                          readOnly: false,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                19),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CardNumberFormatter(),
                                          ],
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                            decimal: false,
                                          ),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'pop'),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                  color: Color(0xff2C2C2C),
                                                  width: 1,
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 8),
                                              hintText: 'Card number',
                                              hintStyle: const TextStyle(
                                                  color: Color(0xff867890),
                                                  fontSize: 14,
                                                  fontFamily: 'pop'),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                  color: Color(0xff2C2C2C),
                                                  width: 1,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                              ),
                                              errorMaxLines: 1,
                                              errorStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  fontFamily: 'pop')),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (v) {
                                            setState(() {
                                              flap = false;
                                            });
                                          },
                                          validator: (value) {
                                            return Validator.validateValues(
                                              value: value,
                                            );
                                          },
                                        )),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: TextFormField(
                                                controller:
                                                    _expiryMonthController,
                                                readOnly: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      4),
                                                  CardMonthInputFormatter(),
                                                ],
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                  decimal: false,
                                                ),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'pop'),
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xff2C2C2C),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20,
                                                            vertical: 8),
                                                    hintText: 'MM/YY',
                                                    hintStyle: const TextStyle(
                                                        color: Color(
                                                            0xff867890),
                                                        fontSize: 14,
                                                        fontFamily: 'pop'),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xff2C2C2C),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.red,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.blue,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    errorMaxLines: 1,
                                                    errorStyle: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                        fontFamily: 'pop')),
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                onChanged: (v) {
                                                  setState(() {
                                                    flap = false;
                                                  });
                                                },
                                                validator: (v) {
                                                  if (v!.isEmpty) {
                                                    return "Can't be Blank";
                                                  } else if (v.length != 5) {
                                                    return 'invalid Number';
                                                  } else if (int.parse(
                                                          v.substring(0, 2)) >
                                                      12) {
                                                    return 'invalid Month';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              )),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: TextFormField(
                                                controller: _cvvController,
                                                obscureText: true,
                                                obscuringCharacter: '*',
                                                readOnly: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      3),
                                                ],
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                  decimal: false,
                                                ),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'pop'),
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xff2C2C2C),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20,
                                                            vertical: 8),
                                                    hintText: 'cvv',
                                                    hintStyle: const TextStyle(
                                                        color: Color(
                                                            0xff867890),
                                                        fontSize: 14,
                                                        fontFamily: 'pop'),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xff2C2C2C),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.red,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.blue,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    errorMaxLines: 1,
                                                    errorStyle: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                        fontFamily: 'pop')),
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                onChanged: (v) {
                                                  setState(() {
                                                    flap = true;
                                                  });
                                                },
                                                validator: (value) {
                                                  return Validator
                                                      .validateValues(
                                                    value: value,
                                                  );
                                                },
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              height: 60,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11)),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      String month = _expiryMonthController.text
                                          .substring(0, 2);
                                      String year = _expiryMonthController.text
                                          .substring(3, 5);

                                      _cardBloc.add(ActivateDebutcardEvent(
                                          cardnumber: _cardNumberController.text
                                              .replaceAll(' ', ''),
                                          cvv: _cvvController.text,
                                          mm: month,
                                          yy: year));
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
                                    'Activate',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (BuildContext buildContext,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return Container(
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 60,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Expanded(
                                                    child: ScrollConfiguration(
                                                      behavior:
                                                          CustomScrollBehavior(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 18,
                                                                right: 18),
                                                        child: ListView(
                                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            const SizedBox(
                                                                height: 10),
                                                            Image.asset(
                                                              'images/icon_voucher_code.png',
                                                              color: const Color(
                                                                  0xff10245C),
                                                              width: 100,
                                                              height: 100,
                                                            ),
                                                            const SizedBox(
                                                                height: 25),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                        blurRadius:
                                                                            15,
                                                                        color: Colors
                                                                            .white30,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        spreadRadius:
                                                                            0)
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  Form(
                                                                    key:
                                                                        _formKey2,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 10),
                                                                            child: TextFormField(
                                                                              controller: _lastdigitsController,
                                                                              readOnly: false,
                                                                              inputFormatters: [
                                                                                LengthLimitingTextInputFormatter(4),
                                                                                FilteringTextInputFormatter.digitsOnly,
                                                                                CardNumberFormatter(),
                                                                              ],
                                                                              keyboardType: const TextInputType.numberWithOptions(
                                                                                decimal: false,
                                                                              ),
                                                                              style: const TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'pop'),
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(
                                                                                      color: Color(0xff10245C),
                                                                                      width: 1,
                                                                                    ),
                                                                                  ),
                                                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                                                  hintText: 'Last 4 digits',
                                                                                  hintStyle: const TextStyle(color: Color(0xff867890), fontSize: 14, fontFamily: 'pop'),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(
                                                                                      color: Color(0xff10245C),
                                                                                      width: 1,
                                                                                    ),
                                                                                  ),
                                                                                  errorBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(
                                                                                      color: Colors.red,
                                                                                      width: 1,
                                                                                    ),
                                                                                  ),
                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(
                                                                                      color: Colors.blue,
                                                                                      width: 2,
                                                                                    ),
                                                                                  ),
                                                                                  errorMaxLines: 1,
                                                                                  errorStyle: const TextStyle(color: Colors.red, fontSize: 12, fontFamily: 'pop')),
                                                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                              validator: (value) {
                                                                                return Validator.validateValues(
                                                                                  value: value,
                                                                                );
                                                                              },
                                                                            )),
                                                                        const SizedBox(
                                                                            height:
                                                                                15),
                                                                        Container(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 10),
                                                                            child: TextFormField(
                                                                              controller: _activationcodeController,
                                                                              readOnly: false,
                                                                              keyboardType: TextInputType.text,
                                                                              style: const TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'pop'),
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(
                                                                                      color: Color(0xff10245C),
                                                                                      width: 1,
                                                                                    ),
                                                                                  ),
                                                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                                                  hintText: 'Activation code',
                                                                                  hintStyle: const TextStyle(color: Color(0xff867890), fontSize: 14, fontFamily: 'pop'),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(
                                                                                      color: Color(0xff10245C),
                                                                                      width: 1,
                                                                                    ),
                                                                                  ),
                                                                                  errorBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(
                                                                                      color: Colors.red,
                                                                                      width: 1,
                                                                                    ),
                                                                                  ),
                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(
                                                                                      color: Colors.blue,
                                                                                      width: 2,
                                                                                    ),
                                                                                  ),
                                                                                  errorMaxLines: 1,
                                                                                  errorStyle: const TextStyle(color: Colors.red, fontSize: 12, fontFamily: 'pop')),
                                                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                              onChanged: (v) {
                                                                                setState(() {
                                                                                  flap = false;
                                                                                });
                                                                              },
                                                                              validator: (value) {
                                                                                return Validator.validateValues(
                                                                                  value: value,
                                                                                );
                                                                              },
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          40),
                                                                  Container(
                                                                    height: 40,
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            20),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          if (_formKey2
                                                                              .currentState!
                                                                              .validate()) {
                                                                            Navigator.pop(context);

                                                                            _cardBloc.add(activateDebitwithcodeEvent(
                                                                                code: _activationcodeController.text,
                                                                                lastdigit: _lastdigitsController.text));
                                                                          }
                                                                        },
                                                                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff10245C), elevation: 0, disabledBackgroundColor: const Color(0xffC4C4C4), shadowColor: Colors.transparent, minimumSize: const Size.fromHeight(40), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
                                                                        child: const Text(
                                                                          'Activate',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontFamily: 'pop',
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          25)
                                                                ],
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
                                      );
                                    },
                                    barrierDismissible: true,
                                    barrierLabel:
                                        MaterialLocalizations.of(context)
                                            .modalBarrierDismissLabel,
                                    barrierColor: Colors.white.withOpacity(0.1),
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                  );
                                },
                                child: const Text(
                                  "Activate using activation code",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'pop',
                                      fontSize: 14,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
