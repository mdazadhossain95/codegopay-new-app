import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Models/convert_preview_model.dart';
import 'package:codegopay/Screens/crypto_screen/bloc/crypto_bloc.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidable_button/slidable_button.dart';

// ignore: must_be_immutable
class ConfirmScreen extends StatefulWidget {
  String symbol, image;
  bool isBuy;
  ConvertModel convertModel;

  ConfirmScreen(
      {super.key,
      required this.symbol,
      required this.image,
      required this.isBuy,
      required this.convertModel});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  CryptoBloc _cryptoBloc = CryptoBloc();

  bool value = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xffFAFAFA)),
        child: Scaffold(
          backgroundColor: Colors.white,
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
                }
              },
              child: BlocBuilder(
                  bloc: _cryptoBloc,
                  builder: (context, CryptoState state) {
                    return SafeArea(
                      child: ProgressHUD(
                        inAsyncCall: state.isloading,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                        width: 30,
                                        child: Image.asset(
                                            'images/backarrow.png')),
                                  ),
                                  Expanded(
                                      child: Center(
                                    child: widget.isBuy
                                        ? const Text(
                                            'Buy',
                                            style: TextStyle(
                                                color: Color(0xff040404),
                                                fontFamily: 'pop',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )
                                        : const Text(
                                            'Sell',
                                            style: TextStyle(
                                                color: Color(0xff040404),
                                                fontFamily: 'pop',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                  )),
                                  Container(
                                    width: 30,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Container(
                                alignment: Alignment.center,
                                width: 180,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xff4F9E7D),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.network(widget.image),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.convertModel.showamount!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'pop'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: const Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.5))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${widget.symbol.toUpperCase()} price',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.convertModel.price!,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'pop',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.5))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Amount',
                                    style: TextStyle(
                                        color: Color(0xff7A7A7A),
                                        fontSize: 13,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.convertModel.payAmount!,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: Color(0xff7A7A7A),
                                          fontSize: 13,
                                          fontFamily: 'pop',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 0),
                              decoration: const BoxDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Fees',
                                    style: TextStyle(
                                        color: Color(0xff7A7A7A),
                                        fontSize: 13,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.convertModel.fee!,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: Color(0xff7A7A7A),
                                          fontSize: 13,
                                          fontFamily: 'pop',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: const Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.5))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.convertModel.getAmount!,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'pop',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.5))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Order type',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.isBuy ? 'Buy' : "Sell",
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: Color(0xff7A7A7A),
                                          fontSize: 13,
                                          fontFamily: 'pop',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                              alignment: Alignment.bottomCenter,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: value,
                                          onChanged: (v) {
                                            setState(() {
                                              value = v!;
                                            });
                                          }),
                                      const Expanded(
                                        child: Text(
                                          "Select this choice to perform the conversion",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color(0xff7A7A7A),
                                              fontSize: 12,
                                              fontFamily: 'pop',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: HorizontalSlidableButton(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 50,
                                      buttonWidth: 50.0,
                                      isRestart: true,
                                      color: const Color(0xffE8E7F9),
                                      borderRadius: BorderRadius.circular(100),
                                      buttonColor: Colors.transparent,
                                      initialPosition:
                                          SlidableButtonPosition.start,
                                      tristate: true,
                                      label: Container(
                                          alignment: Alignment.center,
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: value == true
                                                ? const Color(0xff5442D0)
                                                : Colors.grey,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.white,
                                          )),
                                      onChanged: value == true
                                          ? (position) {
                                              setState(() {
                                                if (position ==
                                                    SlidableButtonPosition
                                                        .end) {
                                                  _cryptoBloc.add(
                                                      ConfirmConvertevent(
                                                          amount: widget
                                                              .convertModel
                                                              .amount,
                                                          base_coin_symbol:
                                                              widget.symbol,
                                                          from_coin: widget
                                                              .convertModel
                                                              .fromSymbol,
                                                          to_coin: widget
                                                              .convertModel
                                                              .toSymbol,
                                                          type: widget
                                                              .convertModel
                                                              .type));
                                                } else {}
                                              });
                                            }
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Swipe to confirm',
                                              style: TextStyle(
                                                  color: value == true
                                                      ? const Color(0xff5442D0)
                                                      : Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  })),
        ));
  }
}
