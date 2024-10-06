import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/constant_string/User.dart';

import 'package:codegopay/cutom_weidget/custom_navigationBar.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/assets.dart';
import '../../utils/input_fields/custom_color.dart';
import '../../utils/user_data_manager.dart';
import '../../widgets/buttons/custom_floating_action_button.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/custom_image_widget.dart';

class BuyGiftCardScreen extends StatefulWidget {
  const BuyGiftCardScreen({super.key});

  @override
  State<BuyGiftCardScreen> createState() => _BuyGiftCardScreenState();
}

class _BuyGiftCardScreenState extends State<BuyGiftCardScreen> {
  bool active = false;

  bool shownotification = true;
  final DashboardBloc _giftCardListBloc = DashboardBloc();

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');

    _giftCardListBloc.add(GiftCardListEvent());
  }

  @override
  void initState() {
    super.initState();
    User.Screen = 'Buy Gift card';

    _giftCardListBloc.add(GiftCardListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.scaffoldBg,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocListener(
            bloc: _giftCardListBloc,
            listener: (context, DashboardState state) {
              if (state.giftCardGetFeeTypeModel?.status == 1) {
                Navigator.pushNamed(context, 'buyGiftCardDetailsScreen');
              } else if (state.statusModel?.status == 0) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  desc: state.statusModel!.message,
                  btnCancelText: 'OK',
                  buttonsTextStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'pop',
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  btnCancelOnPress: () {},
                ).show();
              }

              if (state.giftCardDetailsModel?.status == 1) {
                Navigator.pushNamed(context, 'userGiftCardDetailsScreen');
              } else if (state.statusModel?.status == 0) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  desc: state.statusModel!.message,
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
                bloc: _giftCardListBloc,
                builder: (context, DashboardState state) {
                  return SafeArea(
                    child: ProgressHUD(
                      inAsyncCall: state.isloading,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      bottom: 30, top: 10),
                                  child: Text(
                                    'Gift Cards',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        color: CustomColor.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                PrimaryButtonWidget(
                                  onPressed: () {
                                    _giftCardListBloc
                                        .add(GiftCardGetFeeTypeEvent());
                                  },
                                  buttonText: 'Buy Gift Card',
                                ),
                                Text(
                                  "Card List",
                                  style: GoogleFonts.inter(
                                    color: CustomColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                state.giftCardListModel!.cardList!.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                          itemCount: state.giftCardListModel!
                                              .cardList!.length,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                UserDataManager()
                                                    .giftCardIbanSave(state
                                                        .giftCardListModel!
                                                        .cardList![index]
                                                        .cardId
                                                        .toString());

                                                UserDataManager()
                                                    .giftCardDeleteCardIdSave(
                                                        state
                                                            .giftCardListModel!
                                                            .cardList![index]
                                                            .cardId
                                                            .toString());
                                                _giftCardListBloc.add(
                                                    GiftCardGetDetailsEvent());
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 12),
                                                // Spacing between each item
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: CustomColor.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.08),
                                                      offset:
                                                          const Offset(0, 1),
                                                      blurRadius: 8,
                                                      spreadRadius: -2,
                                                    ),
                                                  ],
                                                ),
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
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          11),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: const Color(
                                                                      0xffE3E3E3)),
                                                            ),
                                                            child: state
                                                                        .giftCardListModel!
                                                                        .cardList![
                                                                            index]
                                                                        .image !=
                                                                    ""
                                                                ? Image.network(
                                                                    state
                                                                        .giftCardListModel!
                                                                        .cardList![
                                                                            index]
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
                                                                        return const CircularProgressIndicator();
                                                                      }
                                                                    },
                                                                    errorBuilder: (BuildContext
                                                                            context,
                                                                        Object
                                                                            error,
                                                                        StackTrace?
                                                                            stackTrace) {
                                                                      // If network image fails to load, use local image instead
                                                                      return Image
                                                                          .asset(
                                                                        'images/master_card_logo.png',
                                                                        height:
                                                                            45,
                                                                        width:
                                                                            45,
                                                                      );
                                                                    },
                                                                  )
                                                                : Image.asset(
                                                                    'images/master_card_logo.png',
                                                                    height: 45,
                                                                    width: 45,
                                                                  ),
                                                          ),
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
                                                                  "${state.giftCardListModel!.cardList![index].cardNumber}",
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  "${state.giftCardListModel!.cardList![index].expiryDate}",
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(
                                                                          0xffC4C4C4)),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "Status: ",
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Color(0xffC4C4C4)),
                                                                    ),
                                                                    Text(
                                                                      "${state.giftCardListModel!.cardList![index].cardStatus}",
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color: state.giftCardListModel!.cardList![index].cardStatus == "Active"
                                                                              ? CustomColor.green
                                                                              : CustomColor.errorColor),
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
                                                          "€${state.giftCardListModel!.cardList![index].loadedAmount}",
                                                          style: GoogleFonts.inter(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: CustomColor
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
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Column(
                                          children: [
                                            CustomImageWidget(
                                              imagePath: StaticAssets.noCard,
                                              imageType: 'svg',
                                              height: 130,
                                            ),
                                            Text(
                                              "Card not purchased yet",
                                              style: GoogleFonts.inter(
                                                color: CustomColor.black
                                                    .withOpacity(0.6),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                              ]),
                        ),
                      ),
                    ),
                  );
                })),
        floatingActionButton: CustomFloatingActionButton());
  }
}
