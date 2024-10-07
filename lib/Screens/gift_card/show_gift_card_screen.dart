import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cutom_weidget/custom_navigationBar.dart';
import '../../cutom_weidget/cutom_progress_bar.dart';
import '../../cutom_weidget/flip_card_widget.dart';
import '../../utils/input_fields/custom_color.dart';
import '../../utils/user_data_manager.dart';
import '../../widgets/buttons/default_back_button_widget.dart';

class ShowGiftCardScreen extends StatefulWidget {
  const ShowGiftCardScreen({super.key});

  @override
  State<ShowGiftCardScreen> createState() => _ShowGiftCardScreenState();
}

class _ShowGiftCardScreenState extends State<ShowGiftCardScreen> {
  late final List<CreditCardDetails> creditCards;

  final DashboardBloc _giftCardDetailsBloc = DashboardBloc();

  bool flap = false;

  bool showDetails = false;

  @override
  void initState() {
    User.Screen = 'show gift card';

    super.initState();
    _giftCardDetailsBloc.add(GiftCardGetDetailsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      body: BlocListener(
        bloc: _giftCardDetailsBloc,
        listener: (context, DashboardState state) {
          if (state.giftCardShareModel?.status == 0) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              desc: state.giftCardShareModel?.message,
              btnCancelText: 'OK',
              buttonsTextStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'pop',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              btnCancelOnPress: () {},
            ).show();
            // Update flag to indicate sharing is successful
          } else if (state.giftCardShareModel?.status == 1) {
            ScaffoldMessenger.of(context)
                .removeCurrentSnackBar(); // Remove any existing SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                state.giftCardShareModel!.message.toString(),
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
            );
          }
        },
        child: BlocBuilder(
            bloc: _giftCardDetailsBloc,
            builder: (context, DashboardState state) {
              return ProgressHUD(
                inAsyncCall: state.isloading,
                child: SafeArea(
                  bottom: false,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    height: double.maxFinite,
                    child: Column(
                      // shrinkWrap: true,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              right: 16, left: 16, top: 30),
                          child:    Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultBackButtonWidget(onTap: () {
                                  Navigator.pushNamed(
                                      context, 'buyGiftCardScreen');
                                }),
                                Text(
                                  '',
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


                        Center(
                          child: Text(
                            "€${state.giftCardDetailsModel!.card!.balance!.toString() ?? ''}",
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 50,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          child: Image.network(
                            state.giftCardDetailsModel!.image!.toString(),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context,
                                Object error, StackTrace? stackTrace) {
                              // Error occurred while loading image, show the asset image as a fallback
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        _detailsWidget(
                            context,
                            state.giftCardDetailsModel!.card!.cardNumber
                                    .toString() ??
                                "",
                            state.giftCardDetailsModel!.card!.expiryDate
                                    .toString() ??
                                "",
                            state.giftCardDetailsModel!.card!.cvv
                                    .toString() ??
                                ""),
                        const SizedBox(height: 10),
                        _transactionTitleWidget(context),
                        Expanded(
                          flex: 1,
                          child:
                              state.giftCardDetailsModel!.card!.trx!.isEmpty
                                  ?  Center(
                                      child: Text(
                                        'No Transaction yet',
                                        style: GoogleFonts.inter(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: 5,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        if (index >=
                                            state.giftCardDetailsModel!
                                                .card!.trx!.length) {
                                          return Container(); // Return an empty container if index is out of bounds
                                        }
                                        return InkWell(
                                          onTap: () {
                                            AwesomeDialog(
                                                    context: context,
                                                    dialogType: DialogType
                                                        .info,
                                                    btnCancelColor:
                                                        const Color(
                                                            0xff10245C),
                                                    dialogBackgroundColor:
                                                        Colors.white,
                                                    animType: AnimType
                                                        .scale,
                                                    body: Container(
                                                      padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                                  10,
                                                              vertical: 5),
                                                      child: Column(
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              "€${state.giftCardDetailsModel!.card!.trx![index].amount.toString() ?? ''}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      50,
                                                                  fontFamily:
                                                                      'pop',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                    10),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Text(
                                                                    'Transaction Type',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'pop',
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight.w600,
                                                                      color:
                                                                          Color(0xff2C2C2C),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment.centerRight,
                                                                      child:
                                                                          Text(
                                                                        state.giftCardDetailsModel!.card!.trx![index].type.toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily: 'pop',
                                                                          fontSize: 12,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: state.giftCardDetailsModel!.card!.trx![index].type.toString() == "Debit" ? Colors.red : Colors.green,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                          state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .trxid
                                                                      .toString() ==
                                                                  ""
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      children: [
                                                                        const Text(
                                                                          'Transaction Id',
                                                                          style: TextStyle(
                                                                            fontFamily: 'pop',
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color(0xff2C2C2C),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Container(
                                                                            alignment: Alignment.centerRight,
                                                                            child: Text(
                                                                              state.giftCardDetailsModel!.card!.trx![index].trxid.toString(),
                                                                              maxLines: 2,
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                fontFamily: 'pop',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xffC4C4C4),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                          state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .transactionDate
                                                                      .toString() ==
                                                                  ""
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      children: [
                                                                        const Text(
                                                                          'Transaction Date',
                                                                          style: TextStyle(
                                                                            fontFamily: 'pop',
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color(0xff2C2C2C),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Container(
                                                                            alignment: Alignment.centerRight,
                                                                            child: Text(
                                                                              state.giftCardDetailsModel!.card!.trx![index].transactionDate.toString(),
                                                                              maxLines: 2,
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                fontFamily: 'pop',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xffC4C4C4),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                          state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .merchant
                                                                      .toString() ==
                                                                  ""
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      children: [
                                                                        const Text(
                                                                          'Merchant',
                                                                          style: TextStyle(
                                                                            fontFamily: 'pop',
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color(0xff2C2C2C),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Container(
                                                                            alignment: Alignment.centerRight,
                                                                            child: Text(
                                                                              state.giftCardDetailsModel!.card!.trx![index].merchant.toString(),
                                                                              maxLines: 2,
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                fontFamily: 'pop',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xffC4C4C4),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                          state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .merchantName
                                                                      .toString() ==
                                                                  ""
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      children: [
                                                                        const Text(
                                                                          'Merchant Name',
                                                                          style: TextStyle(
                                                                            fontFamily: 'pop',
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color(0xff2C2C2C),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Container(
                                                                            alignment: Alignment.centerRight,
                                                                            child: Text(
                                                                              state.giftCardDetailsModel!.card!.trx![index].merchantName.toString(),
                                                                              maxLines: 2,
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                fontFamily: 'pop',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xffC4C4C4),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                          state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .merchantCity
                                                                      .toString() ==
                                                                  ""
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      children: [
                                                                        const Text(
                                                                          'Merchant City',
                                                                          style: TextStyle(
                                                                            fontFamily: 'pop',
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color(0xff2C2C2C),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Container(
                                                                            alignment: Alignment.centerRight,
                                                                            child: Text(
                                                                              state.giftCardDetailsModel!.card!.trx![index].merchantCity.toString(),
                                                                              maxLines: 2,
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                fontFamily: 'pop',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xffC4C4C4),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                          state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .merchantCountry
                                                                      .toString() ==
                                                                  ""
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      children: [
                                                                        const Text(
                                                                          'Merchant Country',
                                                                          style: TextStyle(
                                                                            fontFamily: 'pop',
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color(0xff2C2C2C),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Container(
                                                                            alignment: Alignment.centerRight,
                                                                            child: Text(
                                                                              state.giftCardDetailsModel!.card!.trx![index].merchantCountry.toString(),
                                                                              maxLines: 2,
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                fontFamily: 'pop',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xffC4C4C4),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                          state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .description
                                                                      .toString() ==
                                                                  ""
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      children: [
                                                                        const Text(
                                                                          'Description',
                                                                          style: TextStyle(
                                                                            fontFamily: 'pop',
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color(0xff2C2C2C),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Container(
                                                                            alignment: Alignment.centerRight,
                                                                            child: Text(
                                                                              state.giftCardDetailsModel!.card!.trx![index].description.toString(),
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                fontFamily: 'pop',
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xffC4C4C4),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // btnCancelText: 'Cancel',
                                                    btnOkText: 'Ok',
                                                    btnOkColor: Colors
                                                        .green,
                                                    buttonsTextStyle:
                                                        const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'pop',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Colors
                                                                .white),
                                                    btnCancelOnPress: () {},
                                                    btnOkOnPress: () {})
                                                .show();
                                          },
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            margin:
                                                const EdgeInsets.symmetric(
                                                    vertical: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          height: 65,
                                                          width: 65,
                                                          alignment:
                                                              Alignment
                                                                  .center,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          11),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: const Color(
                                                                      0xffE3E3E3))),
                                                          child:
                                                              Image.network(
                                                            state
                                                                .giftCardDetailsModel!
                                                                .card!
                                                                .trx![index]
                                                                .image
                                                                .toString(),
                                                            height: 45,
                                                            width: 45,
                                                            loadingBuilder: (BuildContext
                                                                    context,
                                                                Widget
                                                                    child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              } else {
                                                                return Image
                                                                    .asset(
                                                                  'images/master_card_logo.png',
                                                                  height:
                                                                      45,
                                                                  width: 45,
                                                                ); // Show loading indicator
                                                              }
                                                            },
                                                            errorBuilder: (BuildContext
                                                                    context,
                                                                Object
                                                                    error,
                                                                StackTrace?
                                                                    stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                'images/master_card_logo.png',
                                                                height: 45,
                                                                width: 45,
                                                              ); // Show error icon if image loading fails
                                                            },
                                                          )),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              state
                                                                  .giftCardDetailsModel!
                                                                  .card!
                                                                  .trx![
                                                                      index]
                                                                  .merchantName
                                                                  .toString(),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  fontFamily:
                                                                      'pop',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Text(
                                                              "Date: ${state.giftCardDetailsModel!.card!.trx![index].transactionDate.toString() ?? ""}",
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      12,
                                                                  fontFamily:
                                                                      'pop',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color(
                                                                      0xffC4C4C4)),
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  "Status: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'pop',
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      color:
                                                                          Color(0xffC4C4C4)),
                                                                ),
                                                                Text(
                                                                  state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .status
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'pop',
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      color: state.giftCardDetailsModel!.card!.trx![index].status.toString() == "declined"
                                                                          ? Colors.red
                                                                          : Colors.green),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .end,
                                                  children: [
                                                    Text(
                                                      "${state.giftCardDetailsModel!.card!.trx![index].symbol.toString() ?? ""}${state.giftCardDetailsModel!.card!.trx![index].amount.toString() ?? ""}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: 'pop',
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                          color: state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .type
                                                                      .toString() ==
                                                                  "Debit"
                                                              ? Colors.red
                                                              : Colors
                                                                  .green),
                                                    ),
                                                    Text(
                                                      state
                                                              .giftCardDetailsModel!
                                                              .card!
                                                              .trx![index]
                                                              .type
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: 'pop',
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                          color: state
                                                                      .giftCardDetailsModel!
                                                                      .card!
                                                                      .trx![
                                                                          index]
                                                                      .type
                                                                      .toString() ==
                                                                  "Debit"
                                                              ? Colors.red
                                                              : Colors
                                                                  .green),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      bottomNavigationBar: CustomBottomBar(index: 3),
    );
  }

  _detailsWidget(
      BuildContext context, String cardNumber, String expiryDate, String cvv) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/details.png",
                    height: 20,
                    width: 20,
                    color: Colors.black,
                  ),
                   Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Text("Show\n Details",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            color: Color.fromRGBO(51, 51, 51, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1)),
                  )
                ],
              ),
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    btnCancelColor: const Color(0xff10245C),
                    dialogBackgroundColor: Colors.white,
                    animType: AnimType.scale,
                    body: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Card Number',
                                    style: TextStyle(
                                      fontFamily: 'pop',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff2C2C2C),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        cardNumber,
                                        style: const TextStyle(
                                          fontFamily: 'pop',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffC4C4C4),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Expiry Date',
                                    style: TextStyle(
                                      fontFamily: 'pop',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff2C2C2C),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        expiryDate,
                                        style: const TextStyle(
                                          fontFamily: 'pop',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffC4C4C4),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'CVV',
                                    style: TextStyle(
                                      fontFamily: 'pop',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff2C2C2C),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        cvv,
                                        style: const TextStyle(
                                          fontFamily: 'pop',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffC4C4C4),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    btnCancelText: 'Cancel',
                    btnOkText: 'Copy',
                    btnOkColor: Colors.green,
                    buttonsTextStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'pop',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "$cardNumber\n$expiryDate\n$cvv"))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Copied to clipboard!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      });
                    }).show();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/send.png",
                    height: 20,
                    width: 20,
                    color: Colors.black,
                  ),
                   Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Text("Share",
                        style: GoogleFonts.inter(
                            color: Color.fromRGBO(51, 51, 51, 1),

                            fontSize: 12,
                           fontWeight: FontWeight.w500,
                            height: 1)),
                  )
                ],
              ),
              onPressed: () {
                final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
                final TextEditingController _emailController =
                    TextEditingController();
                final TextEditingController _nameController =
                    TextEditingController();

                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    btnCancelColor: Colors.red,
                    dialogBackgroundColor: Colors.white,
                    animType: AnimType.scale,
                    body: Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            const Text("Share Your Gift Card "),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 55,
                              child: TextFormField(
                                controller: _nameController,
                                onChanged: (value) {
                                  UserDataManager()
                                      .giftCardShareNameSave(value.toString());
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText: 'Name',
                                  hintStyle: const TextStyle(
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      height: 2,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffC4C4C4)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffC4C4C4),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(11)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(11)),
                                  errorMaxLines: 1,
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(11)),
                                  errorStyle: const TextStyle(
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      color: Colors.red),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xff10245C),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(11)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 55,
                              child: TextFormField(
                                controller: _emailController,
                                onChanged: (value) {
                                  UserDataManager()
                                      .giftCardShareEmailSave(value.toString());
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return Validator.validateValues(
                                      value: value, isEmail: true);
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText: 'email',
                                  hintStyle: const TextStyle(
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      height: 2,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffC4C4C4)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffC4C4C4),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(11)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(11)),
                                  errorMaxLines: 1,
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(11)),
                                  errorStyle: const TextStyle(
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      color: Colors.red),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xff10245C),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(11)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    btnCancelText: 'cancel',
                    btnOkText: 'Share',
                    btnOkColor: Colors.green,
                    buttonsTextStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'pop',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    btnCancelOnPress: () {
                      // _dashboardBloc.add(opendialog(open: false));
                    },
                    btnOkOnPress: () {
                      if (_formKey.currentState!.validate()) {
                        _giftCardDetailsBloc.add(GiftCardShareEvent());
                      } else {
                        // _giftCardDetailsBloc.add(GiftCardShareEvent());
                        print('cant do');
                      }
                    }).show();
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: IconButton(
          //     icon: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           "images/settings.png",
          //           height: 20,
          //           width: 20,
          //           color: Colors.black,
          //         ),
          //         const Padding(
          //           padding: EdgeInsets.only(top: 7),
          //           child: Text("Settings",
          //               style: TextStyle(
          //                   color: Color.fromRGBO(51, 51, 51, 1),
          //                   fontFamily: 'Work Sans',
          //                   fontSize: 12,
          //                   letterSpacing:
          //                       0 /*percentages not used in flutter. defaulting to zero*/,
          //                   fontWeight: FontWeight.normal,
          //                   height: 1)),
          //         )
          //       ],
          //     ),
          //     onPressed: () {},
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/trash.png",
                    height: 20,
                    width: 20,
                    color: CustomColor.errorColor,
                  ),
                   Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Text("Delete",
                        style: GoogleFonts.inter(
                            color: CustomColor.errorColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                  )
                ],
              ),
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    desc: "Are you Sure?",
                    btnCancelColor: Colors.green,
                    dialogBackgroundColor: Colors.white,
                    animType: AnimType.scale,
                    btnCancelText: 'cancel',
                    btnOkText: 'Delete',
                    btnOkColor: Colors.red,
                    buttonsTextStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'pop',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      _giftCardDetailsBloc.add((GiftCardDeleteEvent()));

                      Navigator.pushNamed(context, 'buyGiftCardScreen');
                    }).show();
              },
            ),
          )
        ],
      ),
    );
  }

  _transactionTitleWidget(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 20, bottom: 5),
      child: const Text("Transaction Logs",
          style: TextStyle(
              color: Color.fromRGBO(51, 51, 51, 1),
              fontFamily: 'Work Sans',
              fontSize: 12,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1)),
    );
  }
}
